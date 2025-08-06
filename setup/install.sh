#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

echo "Starting post-create installation script..."

# 1. Install libunwind-dev
echo "Installing libunwind-dev..."
sudo apt-get update -y
sudo apt-get install -y libunwind-dev
echo "libunwind-dev installed."

# 2. Install nvm (Node Version Manager) and the latest Node.js
echo "Installing nvm..."
# Using the recommended installation script from nvm's GitHub repo
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# Source nvm to make it available in the current session
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

echo "Installing latest Node.js via nvm..."
nvm install node # Installs the latest stable version of Node.js
nvm use node     # Uses the latest Node.js version
nvm alias default node # Sets the latest Node.js as the default
echo "Node.js (latest) installed and set as default via nvm."
node -v
npm -v

# 3. Install IC CDK (Internet Computer Motoko Candid Development Kit) using the official script
echo "Installing IC CDK (dfx) using the official install script..."
DFXVM_INIT_YES=true sh -ci "$(curl -fsSL https://sdk.dfinity.org/install.sh)"
# The official install script typically adds dfx to the PATH, but we'll add it explicitly for certainty.
source "$HOME/.local/share/dfx/env" # dfx is often installed to ~/bin by the script
echo "IC CDK (dfx) installed."
dfx --version

# 4. install the Motoko compiler
echo "Installing Motoko compiler..."
npm i -g mops


# 5. Install npm packages
echo "Installing npm packages..."
npm install 
echo "npm install executed."


echo "All specified packages and tools installed successfully!"