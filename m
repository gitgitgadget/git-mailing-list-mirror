Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6921C201C8
	for <e@80x24.org>; Fri, 10 Nov 2017 21:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753474AbdKJVGK (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 16:06:10 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:49659 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751057AbdKJVGJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 16:06:09 -0500
Received: by mail-qt0-f194.google.com with SMTP id p44so2953026qtj.6
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 13:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=mKGXE6iLUey2M/f5Sm5nMSM0rfU8TAMhaayXk5YCifs=;
        b=pdsEQps1q7n3AzIMwZ25dMIM2NE607JZ7l635tzL6XiDhUM/1eY+g70pQPNn7RjFhL
         8tUSX6MhynmfMIJv1v2lcJyaXfqjdyX/Drrmv7Y/UYFP6jkTJS0UT/XoRH4eC2MlY0mV
         NO8RDyF5QYmfygWOuwyA267cicecftiIIcznQZcC7eNt9lIl4B95I14jaoRrIA2YreGV
         /e34yDIKWFyi9JNDyuDjhrNNAIQTZ2mn5sfBXlvZl4aCeugvPgv0KG2PxucI0aACgfD8
         MZUd6n47d2WsqbGWEaFTkfdhIHTx6qizIF+ymGnGOl7+JkzxWBF5h+IhqgXh63JZe/hz
         F+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=mKGXE6iLUey2M/f5Sm5nMSM0rfU8TAMhaayXk5YCifs=;
        b=GrBJvjjoAmK4BCJ8ylG5CUsvJd4BFheLcw4ARvVWX3W29BnY1b1NfNjMhQSOBlqTUu
         ulDlqA1NR2Po0VEKnIkHEQimsqxqXraGW5mWUAh6lelgQ5gMTQYbAsRIgv/E/Wro74rN
         SzjYrAWCwJGEu398Zl0FIFQDy095+g03CMXUmAzE4UAyRsCiHk8bOqLnt7I5OI0mFGQU
         L+10bmK9pyrYN81nrKYbCoRANxGyWKUHo9w5/dEE522/qVoHU4p4QuDSfovJQeZoTSj2
         9jy2RYV+Iq/9Fr4pn+/W8/b3Ilr3tvpNfojnHIZ7UpugkNtAd1tjkOqKeaXHjoqL0GNv
         AVFg==
X-Gm-Message-State: AJaThX4hgsGci6VSWWMs4uLASDwkAerQqT9/Xfo1G3gVpOEe6kfAdktu
        ZPNTeveQ9wTiFJbPHuScBE3a8VE/ON1ReQbAsjY=
X-Google-Smtp-Source: AGs4zMaSrmKy3/qHmxCSA8YIcJzBDTl2fDuU4jnYgxHUHkJhzZfk69RrZi2UgCgXehMRGlbNeWbLZVS5U4880OahGo8=
X-Received: by 10.237.59.249 with SMTP id s54mr2356427qte.34.1510347968670;
 Fri, 10 Nov 2017 13:06:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.155.209 with HTTP; Fri, 10 Nov 2017 13:06:08 -0800 (PST)
In-Reply-To: <alpine.LFD.2.21.1711101123280.6717@DESKTOP-1GPMCEJ>
References: <alpine.LFD.2.21.1711101123280.6717@DESKTOP-1GPMCEJ>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 10 Nov 2017 16:06:08 -0500
X-Google-Sender-Auth: ffKBC7NfPYecRJMbhJFUvfW9YIA
Message-ID: <CAPig+cRtpmtD8XqhdXrn1iWOEf9Yx=TXQB=yvXBZ+uR_+XRcPg@mail.gmail.com>
Subject: Re: [PATCH] bisect: mention "view" as an alternative to "visualize"
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the patch. Some comments below...

On Fri, Nov 10, 2017 at 11:32 AM, Robert P. J. Day
<rpjday@crashcourse.ca> wrote:
> Tweak a number of files to mention "view" as an alternative to
> "visualize":

You probably want to end this sentence with a period, not a colon.

>  Documentation/git-bisect.txt           | 9 ++++-----
>  Documentation/user-manual.txt          | 3 ++-
>  builtin/bisect--helper.c               | 2 +-
>  contrib/completion/git-completion.bash | 2 +-
>  git-bisect.sh                          | 4 ++--
>  5 files changed, 10 insertions(+), 10 deletions(-)

The diffstat belongs below the "---" separator, otherwise this text
will (undesirably) become part of the commit message proper.

> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
>
> ---
>
>   here's hoping i have the right format for this patch ... are there
> any parts of this that are inappropriate, such as extending the bash
> completion?

This is the correct place for your commentary. The diffstat should
appear below your commentary.

> diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
> @@ -23,7 +23,7 @@ on the subcommand:
>   git bisect terms [--term-good | --term-bad]
>   git bisect skip [(<rev>|<range>)...]
>   git bisect reset [<commit>]
> - git bisect visualize
> + git bisect visualize|view

I think you need parentheses around these terms (see "git bisect
skip", for example):

    git bisect (visualize | view)

However, in this case, it might be easier for readers if each is
presented on its own line (and subsequent discussion can make it clear
that they are synonyms).

    git bisect visualize
    git bisect view

But, that's a matter of taste...

> @@ -196,15 +196,14 @@ of `git bisect good` and `git bisect bad` to mark commits.
>  Bisect visualize
>  ~~~~~~~~~~~~~~~~
>
> -To see the currently remaining suspects in 'gitk', issue the following
> -command during the bisection process:
> +To see the currently remaining suspects in 'gitk', issue either of the
> +following equivalent commands during the bisection process:
>
>  ------------
>  $ git bisect visualize
> +$ git bisect view
>  ------------
>
> -`view` may also be used as a synonym for `visualize`.

Honestly, I think the original was clearer and placed a bit less
cognitive load on the reader. Moreover, for someone scanning the
documentation without reading it too deeply, the revised example makes
it seem as if it is necessary to invoke both commands rather than one
or the other.

> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> @@ -538,10 +538,11 @@ Note that the version which `git bisect` checks out for you at each
>  point is just a suggestion, and you're free to try a different
>  version if you think it would be a good idea.  For example,
>  occasionally you may land on a commit that broke something unrelated;
> -run
> +run either of the equivalent commands
>
>  -------------------------------------------------
>  $ git bisect visualize
> +$ git bisect view
>  -------------------------------------------------

Same observation as above. This has the potential to confuse someone
quickly scanning the documentation into thinking that both commands
must be invoked. Merely stating in prose that one is the alias of the
other might be better.

>  which will run gitk and label the commit it chose with a marker that
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index fdd984d34..52f68c922 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1162,7 +1162,7 @@ _git_bisect ()
>  {
>         __git_has_doubledash && return
>
> -       local subcommands="start bad good skip reset visualize replay log run"
> +       local subcommands="start bad good skip reset visualize view replay log run"

People using muscle memory to type "git bisect v<TAB>"  or
"...vi<TAB>" might find it annoying for this to suddenly become
ambiguous. Just an observation; no strong opinion on it...

> diff --git a/git-bisect.sh b/git-bisect.sh
> @@ -20,7 +20,7 @@ git bisect next
>         find next bisection to test and check it out.
>  git bisect reset [<commit>]
>         finish bisection search and go back to commit.
> -git bisect visualize
> +git bisect visualize|view
>         show bisect status in gitk.

Again, this might be easier to read if split over two lines:

    git bisect visualize
    git bisect view
        show bisect status in gitk.

in which case it's plenty clear that the commands are synonyms.
