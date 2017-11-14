Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 326641F43C
	for <e@80x24.org>; Tue, 14 Nov 2017 18:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754201AbdKNSdR (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 13:33:17 -0500
Received: from mail-qt0-f175.google.com ([209.85.216.175]:47317 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753132AbdKNSdP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 13:33:15 -0500
Received: by mail-qt0-f175.google.com with SMTP id y5so11413586qtk.4
        for <git@vger.kernel.org>; Tue, 14 Nov 2017 10:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=k0R/lL04739Lkmmf8dPgu2HpYkJ3nS1hR3JtszyuQH8=;
        b=Xi7xMVWzjwikDiIhbjr0pU7oEMd4kV2d8IzGm09c7ixmC/m0T30jLN6OaqOF/a/sTR
         BPCUT+DbJFBrBrvSAnZDcWivDKaEvxTvhuc4UEjHUQsE4IxIUwu4WinphBy5ahAKxNvV
         0asm/JE79bDL6cy3sygpTGuIudnfTDLYTmB9ux8QzWewKT5Jkf2X+yszioJq/ejwrPtI
         UdrzMtqM4SI+C3zoTI5805qSCOMB2lXNJb17UjDWF+1ycDsXiwbW8N8NJEnWSmoXSxll
         f7DBKTeC4O5gDu1y4fzLQnx/bmB95GfAweFeyJOO60O2PoAXMXa8TRqt752POff2EbEA
         VWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=k0R/lL04739Lkmmf8dPgu2HpYkJ3nS1hR3JtszyuQH8=;
        b=N014StbYI6/T3bI8zyqhqTn8La8gixVjgM7LeoiyKfDOtzWZD9fLhGIvYocpgS9999
         3rrH9OUjjsfujPNXmOmIfwcWAV94aja3jcEYjiM/fYG3CiTdbJJ8YGilHdYNOrG7bH/T
         qLpE+rARRXoVF5iBKvZlIWgzapg4cGvRAa34/usEowsHFOmLwf9/R0txXK62+FZgu7Vv
         /65RNl8Vl/Xo7BSpFY9WRsXJ+pHdHrvqauH7GPCi9zbWHnd20Ze/b5U2Lbsb1PMEZXAt
         X5kDN9VZjZTGeXg1eku6mmEx4kB9TDAAWRMM+pkLgC2Z/C/flyLDZWI4POkQiEGGQtJe
         OwYg==
X-Gm-Message-State: AJaThX5BkgVKxC/TfR5gZg/nWpLsiTuDTr+MiRKJ8bIL0NNUiP5xKDYL
        HTt1iuqrN+X/oRtK1UmXMnZNUVIcOyhQgqd3U3k0gQ==
X-Google-Smtp-Source: AGs4zMb0swqj3HgqiI9m8jLJ0XlHGfEKHZBp0yKdNO7d+Y/jRuvdY3n3v2MKHcVYFFtCHe6hUXvFl7FYlEAXKZpAS5A=
X-Received: by 10.55.97.209 with SMTP id v200mr12445545qkb.71.1510684395112;
 Tue, 14 Nov 2017 10:33:15 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.155.209 with HTTP; Tue, 14 Nov 2017 10:33:14 -0800 (PST)
In-Reply-To: <alpine.LFD.2.21.1711140324580.12112@localhost.localdomain>
References: <alpine.LFD.2.21.1711140324580.12112@localhost.localdomain>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 14 Nov 2017 13:33:14 -0500
X-Google-Sender-Auth: tKfyLB1xTlYSwTExYri3YrSskNU
Message-ID: <CAPig+cRc7Yqeys=oPEgPnyR4qT7qKYLbH1ifnp+6F6N+mSzNVA@mail.gmail.com>
Subject: Re: some apparent inaccuracies in "man git-worktree"
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 14, 2017 at 3:43 AM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> from "man git-worktree", there seem to be some inaccuracies in the
> SYNOPSIS regarding the "add" subcommand:
>
>   git worktree add \
>     [-f] [--detach] [--checkout] [--lock] [-b <new-branch>] <path> [<branch>]
>
>   first, there's no mention of "-B" in that SYNOPSIS, even though it's
> explained further down the man page.

Omission of "-B" from the synopsis was intentional. From cbdf60fa18
(worktree: add -b/-B options, 2015-07-06):

    worktree: add -b/-B options

    One of git-worktree's roles is to populate the new worktree, much like
    git-checkout, and thus, for convenience, ought to support several of the
    same shortcuts. Toward this goal, add -b/-B options to create a new
    branch and check it out in the new worktree.

    (For brevity, only -b is mentioned in the synopsis; -B is omitted.)

Whether or not the omission was actually a good decision is
questionable. The thinking, at the time, may have been that users
already familiar with "-b" in 'git checkout' would likewise be
familiar with (and be able to infer) "-B", thus it wasn't important to
state its existence explicitly in the synopsis, which was already
getting lengthy. Of course, that decision does not assist newcomers,
so adding "-B" to the synopsis would help the page better stand on its
own.

>   next, the SYNOPSIS seems misleading as it doesn't make clear that
> the options -b, -B and --detach are mutually exclusive, which is made
> clear in the worktree.c source:
>
>     if (!!opts.detach + !!opts.new_branch + !!new_branch_force > 1)
>             die(_("-b, -B, and --detach are mutually exclusive"));

Failure to update the synopsis to indicate mutual exclusion appears to
be a simple oversight in ab0b2c53ed (worktree: make --detach mutually
exclusive with -b/-B, 2015-07-17) in response to:
https://public-inbox.org/git/55A8F4B1.9060304@drmicha.warpmail.net/

>   finally (and maybe i'm just not reading carefully enough), it's not
> clear what happens if you add a worktree at a given commit without
> specifying *any* of -b, -B or --detach. the obvious result should be a
> new worktree checked out at a detached HEAD and, interestingly, if i
> do that, then from the main tree, i see:
>
>   $ git worktree list
>   /home/rpjday/k/git   516fb7f2e73d [master]
>   /home/rpjday/k/temp  c470abd4fde4 (detached HEAD)
>   $
>
> but from within the worktree, if i ask for the status, i see only:
>
>   $ git status
>   Not currently on any branch.
>   nothing to commit, working tree clean
>   $
>
> where i would normally have expected to see "detached HEAD", is there
> a reason that's not displayed?

Someone more familiar with this bit can correct me if I'm wrong, but I
believe that the "HEAD detached at/from <branch>" you normally see
with 'git status' is derived from the reflog, and if it can't find the
information in the reflog, it instead shows the generic "Not currently
on any branch" (which is the equivalent of the "(detached HEAD)" you
see in "git worktree list").

Each worktree has its own newly-created reflog, which does _not_
contain enough information for 'git status' to present the more
detailed "detached" message, thus it falls back to the generic one.
Perhaps seeding the worktree's reflog with a bit more information at
creation time would be a good #leftoverbits task.
