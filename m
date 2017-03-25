Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D082820966
	for <e@80x24.org>; Sat, 25 Mar 2017 21:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751191AbdCYVSv (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 17:18:51 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34359 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751114AbdCYVSu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 17:18:50 -0400
Received: by mail-qt0-f196.google.com with SMTP id x35so3025056qtc.1
        for <git@vger.kernel.org>; Sat, 25 Mar 2017 14:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=nPSOR5s2Ibi60kB6RQ2lfxk1/tIVyEZDgfCT736URRk=;
        b=UBtu6S1i8vg5tuzZmFazynR1wQkj9tGpGiLrIuXBPj07JMmljwdvE5mAUpgHskJZFT
         ecY8y/ZX4ghR+4SuqvuRyHXHl8av4hqCuh1UCOANwRnrPy5UbJTwKf3JhVSjT25Fa1fp
         wHVnInP7jy9KZAWLRqxALMyWI8CttcMCw2J9wk7uzsAZiYrUX6RdR66nxeG7kxgwO5bd
         QEpfCll34aprXJFNl+U4rkJcyCDiOtIXPK38yTOieXq+Ap/Kak2M7hwpbpwXK+SdpQxi
         rRFv7yo40Ev5z4HP7AIVJsSqRnFz9nIQ2nL8G+vlvt82mJDlcni4XbLyMRvXoyF5/kRW
         uzaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=nPSOR5s2Ibi60kB6RQ2lfxk1/tIVyEZDgfCT736URRk=;
        b=PWUZf1tAAxFKHYZGrvfuOd7fpMZShdH6LKecfSI+J4fYgLmDG7wKUmceI7RzocKDEM
         aiCCzajTp6oUTIwWXH4pE2tABYEf4ZAPgA8pZs5RUosfK3F1n+phoJYS78gxKbl3VKfS
         C55bx6cGshlksnIZcST8ZvkSYRRzblz/JrKoso8gEqItpGKIbS5M4j6smr4+8Pwz+alI
         ZZhXB8ZuLcKbIL2DZg/QRjC0Pyu8HpaCh/ygwpgyrX+GgK2nyRJlPdKYHp2P0/Li0j0g
         Ivc6NItTkPLzAV0Ti/GY+y0xZaTjypbPIAcg0q4HzEwMPCTo7ZVTbd4p91OxEaR713y2
         iZcQ==
X-Gm-Message-State: AFeK/H0zSKRynfTkqwB+75RU44Uqs4L/5zRzVgE//8a6mytp9TgvmcYO2R2LCuydBtEbFW+yKoUZMAmbDYUVkQ==
X-Received: by 10.237.63.78 with SMTP id q14mr15139524qtf.266.1490476725100;
 Sat, 25 Mar 2017 14:18:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.47.102 with HTTP; Sat, 25 Mar 2017 14:18:44 -0700 (PDT)
In-Reply-To: <20170325211709.21265-1-eantoranz@gmail.com>
References: <20170325211709.21265-1-eantoranz@gmail.com>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Sat, 25 Mar 2017 15:18:44 -0600
Message-ID: <CAOc6etYdLidaeT8SGMyxOkXqcvSzPJez=Vdy5HBLop6soxzSrg@mail.gmail.com>
Subject: Re: [PATCH] bisect: add quit command
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I found out about "git bisect reset HEAD" while working on "git bisect
quit" but I think it's still worth it.

Let me know.

On Sat, Mar 25, 2017 at 3:17 PM, Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
> git bisect quit will call git reset HEAD so that the working tree
> remains at the current revision
> ---
>  Documentation/git-bisect.txt | 12 ++++++++++++
>  git-bisect.sh                | 11 ++++++++++-
>  2 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
> index bdd915a66..de79e9e44 100644
> --- a/Documentation/git-bisect.txt
> +++ b/Documentation/git-bisect.txt
> @@ -23,6 +23,7 @@ on the subcommand:
>   git bisect terms [--term-good | --term-bad]
>   git bisect skip [(<rev>|<range>)...]
>   git bisect reset [<commit>]
> + git bisect quit
>   git bisect visualize
>   git bisect replay <logfile>
>   git bisect log
> @@ -120,6 +121,17 @@ bad revision, while `git bisect reset HEAD` will leave you on the
>  current bisection commit and avoid switching commits at all.
>
>
> +Bisect quit
> +~~~~~~~~~~~
> +
> +It's an equivalent of bisect reset but that stays at the current
> +revision instead of taking your working tree to the starting revision.
> +
> +------------------------------------------------
> +$ git bisect quit
> +------------------------------------------------
> +
> +
>  Alternate terms
>  ~~~~~~~~~~~~~~~
>
> diff --git a/git-bisect.sh b/git-bisect.sh
> index ae3cb013e..adbff2c69 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -1,6 +1,6 @@
>  #!/bin/sh
>
> -USAGE='[help|start|bad|good|new|old|terms|skip|next|reset|visualize|replay|log|run]'
> +USAGE='[help|start|bad|good|new|old|terms|skip|next|quit|reset|visualize|replay|log|run]'
>  LONG_USAGE='git bisect help
>         print this long help message.
>  git bisect start [--term-{old,good}=<term> --term-{new,bad}=<term>]
> @@ -20,6 +20,9 @@ git bisect next
>         find next bisection to test and check it out.
>  git bisect reset [<commit>]
>         finish bisection search and go back to commit.
> +git bisect quit
> +       stop bisection on its tracks and stay on current revision.
> +       Equivalent to git bisect reset HEAD
>  git bisect visualize
>         show bisect status in gitk.
>  git bisect replay <logfile>
> @@ -433,6 +436,10 @@ Try 'git bisect reset <commit>'.")"
>         bisect_clean_state
>  }
>
> +bisect_quit() {
> +       bisect_reset "HEAD"
> +}
> +
>  bisect_clean_state() {
>         # There may be some refs packed during bisection.
>         git for-each-ref --format='%(refname) %(objectname)' refs/bisect/\* |
> @@ -683,6 +690,8 @@ case "$#" in
>                 bisect_visualize "$@" ;;
>         reset)
>                 bisect_reset "$@" ;;
> +       quit)
> +               bisect_quit ;;
>         replay)
>                 bisect_replay "$@" ;;
>         log)
> --
> 2.11.0.rc1
>
