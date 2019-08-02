Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA52A1F939
	for <e@80x24.org>; Fri,  2 Aug 2019 00:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390581AbfHBAyR (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 20:54:17 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:40166 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388445AbfHBAyR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 20:54:17 -0400
Received: by mail-ua1-f67.google.com with SMTP id s4so29053103uad.7
        for <git@vger.kernel.org>; Thu, 01 Aug 2019 17:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=tvWIS7MkRemheNUz7xBh4zWkuSK2qo81CL+KnLnfSQY=;
        b=RoZdb7Z7RRURwG0wwCv+FSy38y8603AhM9rOWbnR3w7zHxQn80bj45u+YikjpK3I6Y
         QUPEKfCiXFzYbaLDO3EZIw5WMsFPCWNqGpLTTUuPVEh4sioVXJTYcn2ucVz9ZBnWmyWU
         z9K4reW5yffd7sR8bd3DszvoPxa12xxM0CeBj/2hW7WZ/r2sp0szq0pIQOXc1JS/8gxy
         tis6keBevwvmkZ/4cDJ5ds1hUYO/HndStt0m26AP3t0Ggj66fk08tiIMljV021dq0w7D
         E58oRFA/RWLcv5cbW2J/Dhm/nf7MsTIljX0gFc/FvJb1cNvUtLnuo881ySmvm2+N+z3T
         clZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=tvWIS7MkRemheNUz7xBh4zWkuSK2qo81CL+KnLnfSQY=;
        b=B5QB7G+Srz/+4bKJbWIBLLYWCh9zKhRO0/GmW/VsM/SfqnSVPoGIQL6OD52oC0fVAc
         hdX+r4FY9cYVLqeAB3vBVMj2frYaluhpQw+kEH/gX2LsAo+RXip3yiWmbJuLLoCywG8y
         kOazoxa31qpaBz673x6Wh9C6xCh3DNGtzlHAvBykZaIdeyMdBnx4I0g8ZtgsYzl1v1hJ
         eUFW867t9uOZ7tzJ6f0Qvx/KyJ0tVGWQzhB1gGNNBcAP3MbeYaMJYzGjx5iEsCjFUSCF
         RqS1IMVNNgNocKX6eKgYJP2HwCeqGSQ3inQcz21ou84YED2hGTVgm7kDO5KpnepAjxJZ
         AePQ==
X-Gm-Message-State: APjAAAUBoIo+zmEAK3DI4rEPEt1HneXJJRGJGoKLaLjm6C+9XgJkXccR
        /vjjdBIpZUfj5D+emnSq0K+GModxgcB2ap+ub+2YdP8v
X-Google-Smtp-Source: APXvYqyzQtDzBr7M6bqxaypR8ZlVbJ/XVEwC5yNusfK4khfIQT+wlYWNHRQC8we5p+IB7eG26omPTYc0eFaCn5cIyxQ=
X-Received: by 2002:ab0:168a:: with SMTP id e10mr36190394uaf.87.1564707256000;
 Thu, 01 Aug 2019 17:54:16 -0700 (PDT)
MIME-Version: 1.0
References: <0102015f985d387e-f50183c4-4b49-4a9f-b365-2a86ba24bbed-000000@eu-west-1.amazonses.com>
 <0102016bb065bf5e-005b0752-2594-45d5-a01a-12d0c5e24b70-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016bb065bf5e-005b0752-2594-45d5-a01a-12d0c5e24b70-000000@eu-west-1.amazonses.com>
From:   Max Rothman <max.r.rothman@gmail.com>
Date:   Thu, 1 Aug 2019 20:54:05 -0400
Message-ID: <CAFA_24J8Ry5LhRX5O82eJDtrqjEodDFTEniZNw06fKEWvwvYMA@mail.gmail.com>
Subject: Re: [PATCH] completion: add missing completions for log, diff, show
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ping :)


On Thu, Aug 1, 2019 at 8:50 PM Max Rothman <max.r.rothman@gmail.com> wrote:
>
> The bash completion script knows some options to "git log" and
> "git show" only in the positive form, (e.g. "--abbrev-commit"), but not
> in their negative form (e.g. "--no-abbrev-commit"). Add them.
>
> Also, the bash completion script is missing some other options to
> "git diff", and "git show" (and thus, all other commands that take
> "git diff"'s options). Add them. Of note, since "--indent-heuristic" is
> no longer experimental, add that too.
>
> Signed-off-by: Max Rothman <max.r.rothman@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 9f71bcde967bc..b6d18710135ec 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1474,6 +1474,8 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
>                         --dirstat-by-file= --cumulative
>                         --diff-algorithm=
>                         --submodule --submodule= --ignore-submodules
> +                       --indent-heuristic --no-indent-heuristic
> +                       --textconv --no-textconv
>  "
>
>  _git_diff ()
> @@ -1782,6 +1784,10 @@ _git_log ()
>                 __gitcomp "$__git_diff_submodule_formats" "" "${cur##--submodule=}"
>                 return
>                 ;;
> +       --no-walk=*)
> +               __gitcomp "sorted unsorted" "" "${cur##--no-walk=}"
> +               return
> +               ;;
>         --*)
>                 __gitcomp "
>                         $__git_log_common_options
> @@ -1789,16 +1795,19 @@ _git_log ()
>                         $__git_log_gitk_options
>                         --root --topo-order --date-order --reverse
>                         --follow --full-diff
> -                       --abbrev-commit --abbrev=
> +                       --abbrev-commit --no-abbrev-commit --abbrev=
>                         --relative-date --date=
>                         --pretty= --format= --oneline
>                         --show-signature
>                         --cherry-mark
>                         --cherry-pick
>                         --graph
> -                       --decorate --decorate=
> +                       --decorate --decorate= --no-decorate
>                         --walk-reflogs
> +                       --no-walk --no-walk= --do-walk
>                         --parents --children
> +                       --expand-tabs --expand-tabs= --no-expand-tabs
> +                       --patch
>                         $merge
>                         $__git_diff_common_options
>                         --pickaxe-all --pickaxe-regex
> @@ -2525,8 +2534,9 @@ _git_show ()
>                 return
>                 ;;
>         --*)
> -               __gitcomp "--pretty= --format= --abbrev-commit --oneline
> -                       --show-signature
> +               __gitcomp "--pretty= --format= --abbrev-commit --no-abbrev-commit
> +                       --oneline --show-signature --patch
> +                       --expand-tabs --expand-tabs= --no-expand-tabs
>                         $__git_diff_common_options
>                         "
>                 return
>
> --
> https://github.com/git/git/pull/426
>
