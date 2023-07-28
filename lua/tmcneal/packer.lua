local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup({function(use)
    -- Packer
    -- plugin manages itself
    use "wbthomason/packer.nvim"

    -- colorscheme
    -- kanagawa (dragon/lotus/wave(default))
    use({
        "rebelot/kanagawa.nvim",
        config = function()
            vim.cmd("colorscheme kanagawa")
        end
    })

    -- telescope.nvim
    -- includes its dependency plenary.nvim
    use {
        "nvim-telescope/telescope.nvim",
        tag = '0.1.2',
        requires = {{"nvim-lua/plenary.nvim"}}
    }

    -- treesitter
    -- used for better syntax highlighting
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }

    -- lualine
    -- a new look for the status bar
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
   
    -- LSP
    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip"
    }

    if packer_bootstrap then
        require("packer").sync()
    end
end,
config = {
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "single" })
        end
    }
}})
