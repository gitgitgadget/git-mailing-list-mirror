Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35CCD207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 15:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751316AbdDZPY6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 11:24:58 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:36433 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932718AbdDZPYn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 11:24:43 -0400
Received: by mail-it0-f66.google.com with SMTP id x188so902101itb.3
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 08:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6fcNvx+2L1t5ptjCQHnnWe5H3dC1Q///DzawY3NKlbk=;
        b=hWhTXufFxpUr3f2cfeFMD9HuTJTAAp+lndc/v4ARzzex/jVY/dzc5Hk8YpqgztLkJ8
         Dq4Pychg6JAo3V8HFfIZCzJGIjPadvRHGTwD20UWIYm1eM3zhBy+EGhQtfiEYGExeoP5
         ZSXzln0iWO96STf3jSrfy3+1S41npqTJ2ph4hNaSOtiB9vBdXu8GoIQQJ3NmSaxOiX0d
         DDWca4NFRJTcaHiJQrgknPGN2MQ9morReLxQsGRbIMttyYMZTrwk526vAc5GrbkXMsSu
         w+iZnpAZFrzNqsZF2/OMSRTidLris+bbXpIeK6dEWAPjBoL0t705TLNkbQgOPmFAcKvH
         t71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6fcNvx+2L1t5ptjCQHnnWe5H3dC1Q///DzawY3NKlbk=;
        b=MWM6vn4HTzAspiGqX0ialwyfiNbdp9EdWvzub7nCM0+yfhEtsH0o+5JwCc+u7PC8j+
         lZsaQY+PyYd8DcDMFi7KraxnU/VQbw3OWOqDzwyLtXwtiooXVp5LBZUXdxJvhYRYPSMM
         bdDvazij5RoJYjLfo4Su20AYPkF3vsDPpbybB9wLmpEz+dUDnsSKJ6H1E+1apoP1qncj
         +P8H1PzEzCMp7NDOBMRzOn27UuwYQ7t67jtcUEhfMIHCMeqpftDDEztbSQhEjyLWnwLO
         4j/RDwBB+/w1sV6/a+FcZR4/mtuwZEo24Kq4+zmmgXHMcBkWAZwx8wxu7yhvSeyz6ecm
         1wcA==
X-Gm-Message-State: AN3rC/7jFl4lB1XyHnGBpB6Bg0qxx6vufLRwxdb5cvCHpBKlq7QazGus
        /2jnLWtPzRiRPHN1jB/RFOsMY05mtg==
X-Received: by 10.36.71.14 with SMTP id t14mr1692041itb.66.1493220282017; Wed,
 26 Apr 2017 08:24:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Wed, 26 Apr 2017 08:24:21 -0700 (PDT)
In-Reply-To: <20170425044320.17840-1-liambeguin@gmail.com>
References: <20170424032347.10878-1-liambeguin@gmail.com> <20170425044320.17840-1-liambeguin@gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 26 Apr 2017 17:24:21 +0200
Message-ID: <CACBZZX49HZbQ32TTM8V3hSHwEJxkewV3VwfJO75u+D-9RmsOtw@mail.gmail.com>
Subject: Re: [PATCH v2] rebase -i: add config to abbreviate command-names
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 25, 2017 at 6:43 AM, Liam Beguin <liambeguin@gmail.com> wrote:
> Add the 'rebase.abbrevCmd' boolean config option to allow `git rebase -i`
> to abbreviate the command-names in the instruction list.
>
> This means that `git rebase -i` would print:
>     p deadbee The oneline of this commit
>     ...
>
> instead of:
>     pick deadbee The oneline of this commit
>     ...
>
> Using a single character command-name allows the lines to remain
> aligned, making the whole set more readable.

Aside from the existing comments about the commit message from others,
you should be noting that we *already* have these abbreviations for
all the todo list options, and we note this in append_todo_help.


> +rebase.abbrevCmd::
> +       If set to true, `git rebase -i` will abbreviate the command-names in the
> +       instruction list. This means that instead of looking like this,
> +
> [...]
> +rebase.abbrevCmd::
> +       If set to true, `git rebase -i` will abbreviate the command-names in the
> +       instruction list. This means that instead of looking like this,
> [...]

Better to split this out into a new *.txt file and use the include::*
facility (grep for it) rather than copy/pasting this entirely across
two files.

>  OPTIONS
>  -------
>  --onto <newbase>::
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 2c9c0165b5ab..9f3e82b79615 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -1210,6 +1210,10 @@ else
>         revisions=$onto...$orig_head
>         shortrevisions=$shorthead
>  fi
> +
> +rebasecmd=pick
> +test "$(git config --bool --get rebase.abbrevCmd)" = true && rebasecmd=p

Rather than hardcoding "p" here maybe it would be worthhwile to make
that into a variable used both here and in append_todo_help, maybe
not...

>  format=$(git config --get rebase.instructionFormat)
>  # the 'rev-list .. | sed' requires %m to parse; the instruction requires %H to parse
>  git rev-list $merges_option --format="%m%H ${format:-%s}" \
> @@ -1228,7 +1232,7 @@ do
>
>         if test t != "$preserve_merges"
>         then
> -               printf '%s\n' "${comment_out}pick $sha1 $rest" >>"$todo"
> +               printf '%s\n' "${comment_out}${rebasecmd} $sha1 $rest" >>"$todo"
>         else
>                 if test -z "$rebase_root"
>                 then
> @@ -1246,7 +1250,7 @@ do
>                 if test f = "$preserve"
>                 then
>                         touch "$rewritten"/$sha1
> -                       printf '%s\n' "${comment_out}pick $sha1 $rest" >>"$todo"
> +                       printf '%s\n' "${comment_out}${rebasecmd} $sha1 $rest" >>"$todo"
>                 fi
>         fi
>  done

I haven't tried applying & running this patch, but it seems you
definitely missed the case where --autosquash will add fixup or
squash, that should be f or s with your patch, but you didn't change
that code. See the rearrange_squash function.

Ditto for turning "exec" into "e" with --exec.

But if the motivation for this entire thing is to make sure the
commands are aligned this doesn't fix that, because the sha1s can be
of different lengths. So as others have pointed out maybe this entire
thing should be dropped & replaced with some bool command to align the
todo list, maybe turning that on by default.

Unless the real unstated reason is to make this easier to edit in vim
or something, in which case this approach seems reasonable.
