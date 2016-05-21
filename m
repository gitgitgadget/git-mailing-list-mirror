From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 14/21] i18n: rebase-interactive: mark strings for translation
Date: Sat, 21 May 2016 14:57:17 +0200
Message-ID: <CACBZZX7T7b9xMM_mDcH6JBnuCap7RtKvSYoFNDrN5mLdmLLYHQ@mail.gmail.com>
References: <1463585274-9027-1-git-send-email-vascomalmeida@sapo.pt> <1463585274-9027-15-git-send-email-vascomalmeida@sapo.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>, Jiang Xin <worldhello.net@gmail.com>
To: Vasco Almeida <vascomalmeida@sapo.pt>
X-From: git-owner@vger.kernel.org Sat May 21 14:57:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b46TV-0008H3-6a
	for gcvg-git-2@plane.gmane.org; Sat, 21 May 2016 14:57:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbcEUM5k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 May 2016 08:57:40 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:36520 "EHLO
	mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172AbcEUM5i (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2016 08:57:38 -0400
Received: by mail-qk0-f194.google.com with SMTP id l68so13307888qkf.3
        for <git@vger.kernel.org>; Sat, 21 May 2016 05:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RGAdUUE+22rGr8+I58uFGNR71nU1yzbI6Nu2QfrfY7o=;
        b=br2V5BoWZGoj8QI1ZCTVyDe0nyRJvzBlvEM/44QbmHu7I7noBLwcPi1fodP+4HcN04
         Zej/XJbDY8C316LXAWMvvGeczj+zQBbNu7WbpoEmBuaRboBM/Ku/Be6sXpbFCISHqbz4
         cvB/+NFxYsflRb8eO46OuzvDsMj2OzxpQBf5weVP2ZnP482YN2wGFMZ8vaCoLS52IVSv
         tsBulXDAWbKP8Ni5mNyFZEbSjtJasC29Db7BmSfNWIINLM6vxDoZ1LKC2VvJeI5J+eZl
         mw4pjq584mtPwTl1hLaV0VW5+W9cmtTQEsBZ8SbemjwJ06y4cOEUqUCFWMpV7zRXA0NX
         +NWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RGAdUUE+22rGr8+I58uFGNR71nU1yzbI6Nu2QfrfY7o=;
        b=E8UcYI99LRB5lkez0qXXMhzUkGs43M8jIQTbEt9g45UXmsbSdTDCsdY0w3Dk3ug0Rg
         17fNzkIM/PQ4IjxF1KGUVTZUUvcM58C+DE+BximoYHCyKocm5zy//x6GCA9xXBCj6ut8
         TbjDZCR/ZYT6ZEUxQYVEy+DQV2JfkBNFsOzz+dbbWpQpSRHlmtp4MnGYelJRQ0R+jbvc
         CpxwK2OaKj1IMS/Kz2EtkdH90Zdqe7krh4WPnI0M3QIiPfede9AKCdUWE0iWdOUqSmpl
         xRXfZ1VhRgr54sixJJ5XYqtIP/GZV5JjLqxQWcrIlw9vsa27EMTf35XxQKDHH0qGVwpo
         Dviw==
X-Gm-Message-State: AOPr4FVcVSM/s+iyG4WVQebdA0DTvnjeM4NaIMebR/T8+1ORnEaQelMrCdcJoRCDq6/vQHchJC+qV2TWiIAAiQ==
X-Received: by 10.55.163.214 with SMTP id m205mr7991569qke.21.1463835457277;
 Sat, 21 May 2016 05:57:37 -0700 (PDT)
Received: by 10.55.77.133 with HTTP; Sat, 21 May 2016 05:57:17 -0700 (PDT)
In-Reply-To: <1463585274-9027-15-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295228>

On Wed, May 18, 2016 at 5:27 PM, Vasco Almeida <vascomalmeida@sapo.pt> wrote:
> Mark strings in git-rebase--interactive.sh for translation. There is no
> need to source git-sh-i18n since git-rebase.sh already does so.

Cool, thanks for working on this.

> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -128,7 +128,7 @@ mark_action_done () {
>         if test "$last_count" != "$new_count"
>         then
>                 last_count=$new_count
> -               printf "Rebasing (%d/%d)\r" $new_count $total
> +               printf "$(gettext Rebasing) (%d/%d)\r" $new_count $total
>                 test -z "$verbose" || echo
>         fi
>  }

Things like these should be converted into something you can pass to
eval_gettext. I.e. For any message the translator needs to be able to
translate the whole message. Consider e.g. RTL languages where the
(%d/%d) will be on the right-hand-side of the message.

> @@ -201,11 +201,13 @@ exit_with_patch () {
>         make_patch $1
>         git rev-parse --verify HEAD > "$amend"
>         gpg_sign_opt_quoted=${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")}
> -       warn "You can amend the commit now, with"
> +       # TRANSLATORS: after this line is a command to be issued by the user
> +       warn "$(gettext "You can amend the commit now, with")"
>         warn
>         warn "  git commit --amend $gpg_sign_opt_quoted"
>         warn
> -       warn "Once you are satisfied with your changes, run"
> +       # TRANSLATORS: after this line is a command to be issued by the user
> +       warn "$(gettext "Once you are satisfied with your changes, run")"
>         warn
>         warn "  git rebase --continue"
>         warn

Stuff like this should be one big call to gettext. I.e. everything
from "You can amend" up to and including "--continue". Even if the
translators probably don't want to change the order here it helps a
lot to have the extra context. I.e. do it like ...

> @@ -536,10 +543,11 @@ do_next () {
>                 mark_action_done
>                 do_pick $sha1 "$rest"
>                 git commit --amend --no-post-rewrite ${gpg_sign_opt:+"$gpg_sign_opt"} || {
> -                       warn "Could not amend commit after successfully picking $sha1... $rest"
> -                       warn "This is most likely due to an empty commit message, or the pre-commit hook"
> -                       warn "failed. If the pre-commit hook failed, you may need to resolve the issue before"
> -                       warn "you are able to reword the commit."
> +                       warn "$(eval_gettext "\
> +Could not amend commit after successfully picking \$sha1... \$rest
> +This is most likely due to an empty commit message, or the pre-commit hook
> +failed. If the pre-commit hook failed, you may need to resolve the issue before
> +you are able to reword the commit.")"
>                         exit_with_patch $sha1 1
>                 }

... this! :)

> @@ -607,7 +615,7 @@ do_next () {
>         x|"exec")
>                 read -r command rest < "$todo"
>                 mark_action_done
> -               printf 'Executing: %s\n' "$rest"
> +               printf "$(gettext Executing:) %s\n" "$rest"
>                 "${SHELL:-@SHELL_PATH@}" -c "$rest" # Actual execution
>                 status=$?
>                 # Run in subshell because require_clean_work_tree can die.

Ditto my first comment about the whole thing needing to be a call to
eval_gettext. I.e. also that " %s" part.

> -                       warn "You can fix the problem, and then run"
> +                       # TRANSLATORS: after this line is a command to be issued by the user
> +                       warn "$(gettext "You can fix the problem, and then run")"
>                         warn
>                         warn "  git rebase --continue"
>                         warn
> @@ -630,9 +639,11 @@ do_next () {
>                         exit "$status"
>                 elif test "$dirty" = t
>                 then
> -                       warn "Execution succeeded: $rest"
> -                       warn "but left changes to the index and/or the working tree"
> -                       warn "Commit or stash your changes, and then run"
> +                       # TRANSLATORS: after these lines is a command to be issued by the user
> +                       warn "$(eval_gettext "\
> +Execution succeeded: \$rest
> +but left changes to the index and/or the working tree
> +Commit or stash your changes, and then run")"
>                         warn
>                         warn "  git rebase --continue"
>                         warn

Both ditto the above. I.e. just include the command to be issued in
the message. Then you can also skip the TRANSLATORS comment since this
won't be confusing to them anymore.

> @@ -991,28 +1002,26 @@ check_todo_list () {
>                 then
>                         test "$check_level" = error && raise_error=t
>
> -                       warn "Warning: some commits may have been dropped" \
> -                               "accidentally."
> -                       warn "Dropped commits (newer to older):"
> +                       warn "$(gettext "\
> +Warning: some commits may have been dropped accidentally.
> +Dropped commits (newer to older):")"
>
>                         # Make the list user-friendly and display
>                         opt="--no-walk=sorted --format=oneline --abbrev-commit --stdin"
>                         git rev-list $opt <"$todo".miss | warn_lines
>
> -                       warn "To avoid this message, use \"drop\" to" \
> -                               "explicitly remove a commit."
> -                       warn
> -                       warn "Use 'git config rebase.missingCommitsCheck' to change" \
> -                               "the level of warnings."
> -                       warn "The possible behaviours are: ignore, warn, error."
> +                       warn "$(gettext "\
> +To avoid this message, use \"drop\" to explicitly remove a commit.
> +
> +Use 'git config rebase.missingCommitsCheck' to change the level of warnings.
> +The possible behaviours are: ignore, warn, error.")"
>                         warn
>                 fi
>                 ;;
>         ignore)
>                 ;;
>         *)

Making this into one big eval_gettext where we stash away those "newer
to older" commits into a variable would be easier on translators, but
maybe there are performance considerations and we could just live with
two messages. Not sure how large this list might get in practice.

I haven't tried to apply & run this patch. But aside from the chunks I
commented on the rest of this looks fine to me.
