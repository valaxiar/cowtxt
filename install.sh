#!/bin/bash

check_package() {
    if which "$1" >/dev/null 2>&1; then
        echo "$1 is installed."
        return 0
    else
        echo "$1 is not installed."
        return 1
    fi
}

check_package cowsay
if [ $? -ne 0 ]; then
    read -p "cowsay is required. Would you like to install it? (y/n): " install_cowsay
    if [[ $install_cowsay == "y" ]]; then
        echo "Installing cowsay..."
        sudo apt-get install cowsay -y
    else
        echo "Cowsay is required. Exiting."
        exit 1
    fi
fi

check_package aichat
if [ $? -ne 0 ]; then
    echo "aichat is not installed. Please install it manually."
fi

echo "Cloning the repository..."
git clone https://github.com/valaxiar/cowtxt

echo "Moving the executable to /bin..."
sudo mv cowtxt/cowtxt /bin

echo "Making the executable accessible..."
sudo chmod +x /bin/cowtxt

echo "Cleaning up..."
sudo rm -rf cowtxt

echo "Installation complete!"
