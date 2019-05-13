Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D21B81F461
	for <e@80x24.org>; Mon, 13 May 2019 09:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbfEMJVJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 05:21:09 -0400
Received: from mail-it1-f172.google.com ([209.85.166.172]:39779 "EHLO
        mail-it1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727992AbfEMJVJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 05:21:09 -0400
Received: by mail-it1-f172.google.com with SMTP id 9so11953161itf.4
        for <git@vger.kernel.org>; Mon, 13 May 2019 02:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xYtPguvL78c96GuPEgdeNznAv+BTOA8Wmh9CQNtXdxA=;
        b=AcSW0tc2DfjhMFbyeG2MV5UCzu+P/b0v7J0P7P6vQZR5E/18Sewcp4SVZDxyKnvJ4b
         93bxKoOmBilFU2qT97/s80mJuKoLOc4//6mqmpO4N0FUnYmFjTOYqCZUtbIg4oBJyiwz
         DpFPfoOiUWrQbGzd/8lt7bkgUHLEUqKo+0vh3pILsXMo3zk/kIB6n4dAiN/y7VDtyAta
         Owy9ESrGlRlCBgAs3nURWVbt/yzTdKzEtifrFJyvWJrlmpuWvERx5bVZ6a6iViVyaTEU
         nRJ2569o8AABjLF5wgS0bu8OhpHlJFrNQB0OY+4CfLnV68aOkgVEuiYLcHRjot9q5O89
         NZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xYtPguvL78c96GuPEgdeNznAv+BTOA8Wmh9CQNtXdxA=;
        b=o10TWFS9riW/kUpQfmebuIT8KF1EfM6pPjzbJ8Eh8gQ/o2q9oOw/Pmh23Kzpmr1irT
         RLV0IfMkq1EB6dYKFSQ4L7Fof6Jzv0rFNXRI0KnbWXF6dQs85dXBpwQ4yNd4qi8FFD3T
         hrh1lxxToGKMwbSpKKPgIBUmTpRTiGlGDKYGMvRtxdBbpmGB3141eAcY5rKlW5PmzzQ7
         gehKpR0fB8Wz/A+kJLFvkeHeyymVlcWIHVEwIWxC5txv3260TaSLLDueUi7/rp5J3vrP
         bVQFSCEHKqevyAEt/gC5XKlzf3UCrPqjaD0mLKHSYd6dgGsfTA2WVGp21YyUO2s4EX0F
         b/0g==
X-Gm-Message-State: APjAAAW3w/cWs1QVxeAcgruz/rKNBgcr4BST6fBi8xo8BYGPEsQ5gzyn
        ZoqtJnTY4ac/HV2ppJ8NlVeeCOUw9AJsZO3VlVA=
X-Google-Smtp-Source: APXvYqzkBvkHAPBgI7mOxmYda8UQoNSoLtbynH1wn3vAQHyNDgzX3rNuJuCu4L4xJvHKfebzyZLKOjGHns3G39c3NZw=
X-Received: by 2002:a24:56c1:: with SMTP id o184mr4816288itb.123.1557739268558;
 Mon, 13 May 2019 02:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAHAc2je-Yz4oej-sqvp+G+2Wv+eBABeJWUMm4scRwF2z_diUXw@mail.gmail.com>
In-Reply-To: <CAHAc2je-Yz4oej-sqvp+G+2Wv+eBABeJWUMm4scRwF2z_diUXw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 13 May 2019 16:20:42 +0700
Message-ID: <CACsJy8C++Ds4kfs_Wc8UiVQgni-ypbyJ+0bFg1m5brt+s0Tfig@mail.gmail.com>
Subject: Re: "add worktree" fails with "fatal: Invalid path" error
To:     Shaheed Haque <shaheedhaque@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 12, 2019 at 5:14 PM Shaheed Haque <shaheedhaque@gmail.com> wrote:
>
> Hi,
>
> I'm running git v.2.20.1 on Ubuntu from a program which follows the pattern:
>
> ============
> 1. create a temporary directory /tmp/tmpabc

When is this directory deleted? After step 3a?

> 2. in a loop:
>     2a. create a second level of temporary directory /tmp/tmpabc/tmpworktree123
>     2b. use "git worktree add" on the second level directory
>     2c. do something
> 3. cleanup
>     3b. "git branch -D" on each basename(second level directory)
>     3a. "git worktree prune"
> ============
>
> The loop size is of the order of 8-20. In step 2b, I often get errors
> like this (from a Bash reproducer):
>
> ============
> $ git worktree add /tmp/tmpgtxug4y9/git_worktree.gBGqnfnU
> Preparing worktree (new branch 'git_worktree.gBGqnfnU')
> fatal: Invalid path '/tmp/tmp1q9ysvyl': No such file or directory
> ============
>
> I can see that the problematic path exists in the "gitdir" file of
> what must be an earlier worktree from an older run (the branch is
> gone, but the tree is still there). The path appear to relate to the
> older run's first level directory:
>
> ============
> $ grep -r /tmp/tmp1q9ysvyl ../.git/worktrees/
> ../.git/worktrees/git_worktree.frcwtjt_/gitdir:/tmp/tmp1q9ysvyl/git_worktree.frcwtjt_/.git
> $ git worktree list
> ...
> /tmp/tmp1q9ysvyl/git_worktree.frcwtjt_  edde3f25 (detached HEAD)
> ...
> $ git branch | grep frcwtjt_
> <no matches>
> ============

Yeah I think I know where that "Invalid path" comes from and it should
not be there (at least it should not be a fatal error). I'll need to
reproduce this first. But I'm certain you've given me enough
information to do so.

> NOTE: I've not yet had to try deleting the worktree, since "add
> worktree" does appear to work some of the time, so I am able to limp
> along.

It's probably best to stay clean and delete things after you're done.
At least you should be able to avoid this problem this way until it's
fixed.

>
> I have these questions:
>
> 1. There is no branch or first level directory, but "git prune" has
> not deleted the worktree, is this expected?

I assume you meant "git worktree prune", not "git prune". See
gc.worktreePruneExpire. Dead worktree info stays for a while until
it's deleted, so that you can recover stuff if you need to.

> 2. Is there something wrong with the sequence of steps I am following?

Nope. I mean, you could try "git worktree remove" to be on the safe
side. But it should work even without that. To me this looks very much
like a bug.

> Thanks, Shaheed
>
> P.S. I have an strace of a failing worktree add if needed.
-- 
Duy
