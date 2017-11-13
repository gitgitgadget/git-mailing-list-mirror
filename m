Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F16CF1F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 17:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754170AbdKMRjH (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 12:39:07 -0500
Received: from mail-qk0-f169.google.com ([209.85.220.169]:49055 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754138AbdKMRjG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 12:39:06 -0500
Received: by mail-qk0-f169.google.com with SMTP id a142so20710767qkb.5
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 09:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=XrG1vBjdnnFxVn/GSKJc1veRxC3G6FhBYiPdv3k94Ng=;
        b=EQBgJ00aRtjBzXEOXOqN+4Mq6d7HYZOXkmBPMS+BOloKxH45kozP0QSy8jy4ihYu+F
         FVz6aBGcnD+xvQ8CBO8YgsL/4kRU4H8G5zAUwhFd8aoeTzsZImCkIPLDrBJfNqOndujr
         imLQiFN8Jmy8+PKyCpbxEgrbf7kiAzKmT6SPaztASUN21y/WvelMuNl03BhPQeKBJbDc
         9zM42RKHtvKz9fxuG1TT5IIbRF8EH07VjSFOjxzVAMjkDqWHdxO/9QjvfebeitURTVIN
         O2EaCjRRxvClssLmbWFEBCbwD11Ujas6rUuzl3HGJoXnp7yV1fPa4R952gASOSOeeuiJ
         9AUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=XrG1vBjdnnFxVn/GSKJc1veRxC3G6FhBYiPdv3k94Ng=;
        b=HW+PrZeyVXYpRbXyoZPclsunOs1RK+sGBL6Sz0MHl5XhppxyPgAijH0p+HNFuFsYNI
         ZtCu5/PEm1CH1FfgaB6lZJQUE3/AWgcU/LfHPF4ROFhDWkWbeL3rRqUTFf5P47+/WE+s
         //TBdHglrbwq33d14zQg2I3Ej1iO4FSn6DuWle6XuJRFwkAJSoMsaVc7Tlz09YfJ6znn
         WXPriLkhNhG0mwey5W6QYwk8Hm5iZZF1erqfLAmG6TRbYb/wT9FW43gtLpBsKOAGqENz
         j2uG1X4ruP4/RJBFeFeZxpEQ4AyXbxR9p1znnUUxHA/1sYTvSJOvCPucF94KioIN3+as
         a2+w==
X-Gm-Message-State: AJaThX6kM7PiIp5HxF2c7B5yaizXGJpP6IuQPPkTEmTfiLypWBU0TeLL
        SCC5McCMz/wpC1PI+MQPIIvB71oS1/CeGlhx9Xg=
X-Google-Smtp-Source: AGs4zMaU08lCMH51+NkAvpOc//KS8h3tg3lAUmpDMuoWXtmNQROJny4bJNLEtJ7XIJXZtdIqSuqY4KYm4aGJgSI/5rE=
X-Received: by 10.55.97.209 with SMTP id v200mr6370789qkb.71.1510594745768;
 Mon, 13 Nov 2017 09:39:05 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.155.209 with HTTP; Mon, 13 Nov 2017 09:39:05 -0800 (PST)
In-Reply-To: <alpine.LFD.2.21.1711130938080.5262@DESKTOP-1GPMCEJ>
References: <alpine.LFD.2.21.1711130938080.5262@DESKTOP-1GPMCEJ>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 13 Nov 2017 12:39:05 -0500
X-Google-Sender-Auth: zBpz5iaCDm8fLxuYc-L3UeKcDQQ
Message-ID: <CAPig+cRLcJ2a=QKyKAkaNiewoWMQvKr_AWePKYVpGS5S9g-i1Q@mail.gmail.com>
Subject: Re: man page for "git-worktree" is a bit confusing WRT "prune"
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 13, 2017 at 9:48 AM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>   once more, into the man pages ... "git worktree" seems like a fairly
> simple command, but there is some confusion about the function of
>
>   $ git worktree prune
>
> the normal meaning of "prune" (certainly with git commands) is to
> actually delete some content, and the initial impression of this
> command is that it will delete an actual worktree. however, further
> reading reveals:
>
> " ... or you can run git worktree prune in the main or any linked
> working tree to clean up any stale administrative files."
>
>   ah, so one learns that the subcommand "prune" does *not* do any
> actual pruning as people would *normally* understand it, it simply
> deletes the administrative information about an already-deleted
> worktree, do i read that correctly?

Yes. This usage is consistent with "git remote prune" which removes
administrative information about local branches which have already
been deleted on the remote side.

>   that's emphasized further down in the actual definition of "prune":
>
>     prune
>         Prune working tree information in $GIT_DIR/worktrees.
>
> but perhaps that explanation could be extended to say it only works on
> already-deleted trees, since that's certainly not clear from that
> single sentence.

As originally implemented, git-worktree would detect deleted or
relocated worktrees and prune or update the administrative information
automatically. So, "prune" was more a behind-the-scenes implementation
detail rather than an important user-facing command. However, the
implementation and semantics of that automatic behavior were not quite
robust and ended up leaving things in a slightly corrupted state (if I
recall correctly), though the corruption was easily corrected by hand.
As a consequence, the automatic behavior was retired while the general
implementation of git-worktree "cooked", with the idea that it could
be revisited later, with the result that "prune" became more
user-facing than originally intended.

The above description could be extended with more information. An
alternative would be to point the reader at the "DETAILS" section as
is done already for "prune" in "DISCUSSION".

>   finally, the prune "--expire" option is truly confusing:
>
>     --expire <time>
>         With prune, only expire unused working trees older than <time>.
>
> suddenly, we encounter the verb "expire", which means ... what? how
> does "expiring" a worktree differ from "pruning" a worktree? and what
> makes a worktree "unused"? the normal meaning of "unused" is that you
> haven't, you know, *used* it lately. in this context, though, does it
> mean deleted? and if it means deleted, what does it mean for it to be
> older than some time if it's already gone?
>
>   thoughts?

This dates back to the original behavior of automatically pruning
administrative information for deleted worktrees. As discussed
elsewhere in the document, a worktree may be placed on some removable
device (USB drive, memory stick, etc.) or network share which isn't
always mounted. The "expire time" provides such
not-necessarily-mounted worktrees a grace period before being pruned
automatically. You wouldn't want your worktree administrative
information erased automatically when invoking some git-worktree
command -- say "git worktree list" -- simply because you forgot to
plug your memory stick back into the computer; the grace period
protects against this sort of lossage. As with "prune", originally,
the grace period was more a behind-the-scenes detail than a
user-facing feature. Nevertheless, it's still useful; you might forget
to plug in your memory stick before invoking "git worktree prune"
manually.

The term "unused" is unfortunate. A better description would likely be welcome.
