ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
RPS1='[$(ruby_prompt_info)]$EPS1'  # Add ruby version on prompt (float right)
COMPLETION_WAITING_DOTS="true"
plugins=(gitfast brew rbenv last-working-dir common-aliases sublime history-substring-search zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

export RBENV_ROOT=$HOME/.rbenv
export PATH="${RBENV_ROOT}/bin:${PATH}"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
export PATH="./bin:/usr/local/bin:${PATH}"

[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export BUNDLER_EDITOR="subl $@ >/dev/null 2>&1"
export BUNDLER_EDITOR="subl $@ >/dev/null 2>&1"
export BUNDLER_EDITOR="subl $@ >/dev/null 2>&1"
export BUNDLER_EDITOR="subl $@ >/dev/null 2>&1"
export BUNDLER_EDITOR="subl $@ >/dev/null 2>&1"
export BUNDLER_EDITOR="subl $@ >/dev/null 2>&1"
export BUNDLER_EDITOR="subl $@ >/dev/null 2>&1"
export BUNDLER_EDITOR="subl $@ >/dev/null 2>&1"
export BUNDLER_EDITOR="subl $@ >/dev/null 2>&1"
export BUNDLER_EDITOR="subl $@ >/dev/null 2>&1"
export BUNDLER_EDITOR="subl $@ >/dev/null 2>&1"
export BUNDLER_EDITOR="subl $@ >/dev/null 2>&1"
export BUNDLER_EDITOR="subl $@ >/dev/null 2>&1"
export BUNDLER_EDITOR="subl $@ >/dev/null 2>&1"
export BUNDLER_EDITOR="subl $@ >/dev/null 2>&1"
export BUNDLER_EDITOR="subl $@ >/dev/null 2>&1"
export BUNDLER_EDITOR="subl $@ >/dev/null 2>&1"
export BUNDLER_EDITOR="subl $@ >/dev/null 2>&1"
source $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export BUNDLER_EDITOR="subl $@ >/dev/null 2>&1"
export BUNDLER_EDITOR="subl $@ >/dev/null 2>&1"
export BUNDLER_EDITOR="subl $@ >/dev/null 2>&1"
export BUNDLER_EDITOR="subl $@ >/dev/null 2>&1"
export BUNDLER_EDITOR="subl $@ >/dev/null 2>&1"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

scal () {
    if [ -z "$1" ]; then
        echo "Usage: scal <app_name> [L|XL|2XL]"
        return 1
    fi

    local app_name="$1"
    local full_app_name="${app_name}-mailoop"
    local size="$2"

    if [ -n "$size" ]; then
        case "$size" in
            L|XL|2XL)
                scalingo --app "$full_app_name" --region osc-secnum-fr1 run --size "$size" rails console
                ;;
            *)
                echo "Taille invalide : $size (attendu: L, XL, 2XL)"
                return 1
                ;;
        esac
    else
        scalingo --app "$full_app_name" --region osc-secnum-fr1 run rails console
    fi
}

tunnel (){
    if [ -z "$1" ]; then
        echo "Usage: scal <app_name>"
        return 1
    fi

    local app_name="$1"
    local full_app_name="${app_name}-mailoop"
    scalingo --app "$full_app_name" --region osc-secnum-fr1 db-tunnel SCALINGO_POSTGRESQL_URL
}

gcp() {
    local categories=("Data import" "Data export" "Data calculation" "Cost reduction, scalability & automation" "Maintenance & Security")
    local types=("New feature" "Refacto" "Fix" "Perf" "Config")

    # Durées affichées à l'utilisateur
    local durations=(
        "Moins de 10 min"
        "30 minutes"
        "1 heure"
        "3 heures"
        "1 journée"
        "2 journées"
        "Plus de 3 journées"
    )

    # Valeurs en minutes correspondantes
    local duration_minutes=(
        10
        30
        60
        180
        360
        720
        1080
    )

    export COLUMNS=1
   
    echo "Choisis une catégorie :"
    select category in "${categories[@]}"; do
        [[ -n $category ]] && break
        echo "Choix invalide."
    done
    echo $category

    echo "Choisis un type :"
    select type in "${types[@]}"; do
        [[ -n $type ]] && break
        echo "Choix invalide."
    done
    echo $type

    echo "Choisis une durée :"
    select duration in "${durations[@]}"; do
        if [[ -n $duration ]]; then
            duration_index=$((REPLY))
            minutes=${duration_minutes[$duration_index]}
            break
        fi
        echo "Choix invalide."
    done

    if [ -z "$1" ]; then
        read -p "Message de commit : " commit_msg
    else
        commit_msg="$*"
    fi

    full_msg="[$category][$type][⏱ $minutes] $commit_msg"

    git add .
    git commit -m "$full_msg"
    git push
}