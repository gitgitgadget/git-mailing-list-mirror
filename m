Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0F0D1FAFC
	for <e@80x24.org>; Sat,  4 Feb 2017 00:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753248AbdBDAEK (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Feb 2017 19:04:10 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:33103 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753240AbdBDAEJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2017 19:04:09 -0500
Received: by mail-it0-f65.google.com with SMTP id e137so3125145itc.0
        for <git@vger.kernel.org>; Fri, 03 Feb 2017 16:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pq0PXZSX+jRy+j4RSTKGn1iDCisBGhPGY46HfrnJaQE=;
        b=ASia+kajFsFjbj7YOyBrlkiG0KokpfeE2MGB5gTIT+ReB/JH+r7s9pREgBN5sAlJY7
         WwRAOUAAXpiDznjo38/eCVdiIYj2KEMulghe66W+y5TCOm/mWdGu91Nb8OFiEzXhGIgU
         bpBZ8NnonKFKqtgwrLAtZrtfYQTQUWasb22HHEie8J1/2NG+4JxHn02yPoXShV/43KnZ
         SEOMfMI/IszCpxGWMY79oiqZvadeesp8PB/VQvYERrhrBZfzyqZiN4yQj53WujuRhWvn
         iFVDHzW2qc9juDUKgiqkoyIIm9ah/vIEyqm6gRa2WpKPqFyLArVwx+Uarmbq6AtAz0Ae
         6LQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pq0PXZSX+jRy+j4RSTKGn1iDCisBGhPGY46HfrnJaQE=;
        b=oD6pJsCVdpuj2JXZ7LXVXE5WPjiHYRtVSf4jZryjWmOC963+uJgNVbx5YmGL5D+eDG
         LrsLAmiqIpYRadEGyzI0vDfnwcJRcYzaFgkOHAuoMfZdj2o4F4/MBWfpjR7UxnZQlh2y
         ZHH+Q8AY8TjIl0MrxtOZr0KrISqEuWJeGl+RFL01wvVFm76bKxYuPHxq+UKEMpZ9/96V
         bGogioNQt7tJ2NQ8oD2yxrXjNzTxba0b+daoYBzAdBr5zGlp0Z7FcBJQ4RcHXCtLyv38
         VjR+AvzBfHqnxvU0SFBsPM81p9/Op/Bt9nQYBSmiRFVLoTsj2tBW45rj7QCUy/w3tgHY
         Oa0w==
X-Gm-Message-State: AIkVDXLN8+HdNTZ/RWTZqEqQenK+PsSY2fRGPEcJBZrsPNN2KeMEX05qE9ZEDoxKZKyJ5vgKCJvUUKRRGqTntw==
X-Received: by 10.36.116.71 with SMTP id o68mr3381560itc.60.1486166648595;
 Fri, 03 Feb 2017 16:04:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.142.147 with HTTP; Fri, 3 Feb 2017 16:04:08 -0800 (PST)
In-Reply-To: <1486146489-8877-1-git-send-email-kannan.siddharth12@gmail.com>
References: <1486146489-8877-1-git-send-email-kannan.siddharth12@gmail.com>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Sat, 4 Feb 2017 05:34:08 +0530
Message-ID: <CAFZEwPMGTzVuLMSzm8wiNxvia4AV0T79C1ZTfcuO4=Bydz_zQA@mail.gmail.com>
Subject: Re: [PATCH] git-parse-remote.sh: Remove op_prep argument
To:     Siddharth Kannan <kannan.siddharth12@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Siddharth,

On Fri, Feb 3, 2017 at 11:58 PM, Siddharth Kannan
<kannan.siddharth12@gmail.com> wrote:
> - Remove the third argument of error_on_missing_default_upstream that is no
>   longer required
> - FIXME to remove this argument was added in commit 045fac5845

This is not exactly correct. Well, this is the commit you get on
git-blame but it isn't really the one to look for. The "real" commit
when the variable was introduced was 15a147e61898 and was used for
writing out the error message. The commit 045fac5845 changed the error
message and the variable was not used then so it got redundant. So if
possible you could document all this information in the commit message
somehow, then it would be really great! :)

> - Run "grep" on the rest of the codebase to find and remove occurences of

/s/occurences/occurrences/g     (spelling mistake ;))

>   the third argument and fix the function calls appropriately
>
> Signed-off-by: Siddharth Kannan <kannan.siddharth12@gmail.com>
> ---

So if you want a better commit message then you could probably use this,
"parse-remote: remove reference to unused op_prep

This argument was introduced in the commit 15a147e618 to help in
writing out the error message but then in commit 045fac5845, the
reference to op_prep got removed. Thus the argument is no longer
useful and is removed.
"

> The contrib/examples/git-pull.sh file also has a variable op_prep which is used
> in one of the messages shown the user. Should I remove this variable as well?

Not really. We have kept the file git-pull.sh just as an example of
how git-pull was initially implemented. So previously git-pull was a
shell script which was then ported to C code. After that conversion,
the shell script was just put as it is in contrib/examples/ as a use
case of how git-pull should be implemented. I don't think there is any
need to modify it, but there isn't really a very strong reason to not
modify it (except that we don't usually write out the new changes to
it).

>  contrib/examples/git-pull.sh | 2 +-
>  git-parse-remote.sh          | 3 +--
>  git-rebase.sh                | 2 +-
>  3 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/contrib/examples/git-pull.sh b/contrib/examples/git-pull.sh
> index 6b3a03f..1d51dc3 100755
> --- a/contrib/examples/git-pull.sh
> +++ b/contrib/examples/git-pull.sh
> @@ -267,7 +267,7 @@ error_on_no_merge_candidates () {
>                 echo "for your current branch, you must specify a branch on the command line."
>         elif [ -z "$curr_branch" -o -z "$upstream" ]; then
>                 . git-parse-remote
> -               error_on_missing_default_upstream "pull" $op_type $op_prep \
> +               error_on_missing_default_upstream "pull" $op_type \
>                         "git pull <remote> <branch>"
>         else
>                 echo "Your configuration specifies to $op_type $op_prep the ref '${upstream#refs/heads/}'"
> diff --git a/git-parse-remote.sh b/git-parse-remote.sh
> index d3c3998..9698a05 100644
> --- a/git-parse-remote.sh
> +++ b/git-parse-remote.sh
> @@ -56,8 +56,7 @@ get_remote_merge_branch () {
>  error_on_missing_default_upstream () {
>         cmd="$1"
>         op_type="$2"
> -       op_prep="$3" # FIXME: op_prep is no longer used
> -       example="$4"
> +       example="$3"
>         branch_name=$(git symbolic-ref -q HEAD)
>         display_branch_name="${branch_name#refs/heads/}"
>         # If there's only one remote, use that in the suggestion
> diff --git a/git-rebase.sh b/git-rebase.sh
> index 04f6e44..b89f960 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -448,7 +448,7 @@ then
>                 then
>                         . git-parse-remote
>                         error_on_missing_default_upstream "rebase" "rebase" \
> -                               "against" "git rebase $(gettext '<branch>')"
> +                               "git rebase $(gettext '<branch>')"
>                 fi
>
>                 test "$fork_point" = auto && fork_point=t
> --
> 2.1.4
>
>
