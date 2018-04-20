Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80FE81F404
	for <e@80x24.org>; Fri, 20 Apr 2018 17:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753486AbeDTRex (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 13:34:53 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:38355 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752749AbeDTReu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 13:34:50 -0400
Received: by mail-ua0-f193.google.com with SMTP id q38so6206010uad.5
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 10:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4dbmmVKYCZEgPg0t+vJfGPRtprLKKbdKvfuTc05hWRs=;
        b=WBZ4ZkyGM98Dzs+gFwQElDITx7xDEo1k49/fDimz0D/Qxo4Q5q4ufrpCBrZgs5S5/7
         C+//V15IbY3IzJoYYlTAy3+DDtlqU4spqoFI6r5evu+kDTfHFya5MhdDAs8zj5Wqe6Pt
         8CP/fu5u1V8mN7b8708aY49uNjW8NaqyYIMMJQCXOT/S/yBdnEyhmyBgDx2dKNv1Bv9K
         V4GLnrp72IwIN7Bn2Qf1JoUub9e1csKvd9oOxrwRibx+8hwxgnbOohlglRl0emBWptip
         VTmsVotKliN2+AOO4KAXPT7dMymvTYXZc+M25tmcAA2RDg3OGpzPaPNrVD469sS0Att1
         l+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4dbmmVKYCZEgPg0t+vJfGPRtprLKKbdKvfuTc05hWRs=;
        b=TNitNBUPmp4bSW443xAInu1a8WAp6XMmgP48MReDy23fXCJamgPv2sELJWExeSQQ8K
         +QUxBUOX7Irg5zZ95tLGkjlU01lYddAuS4bpBH+SmrRPNypsnw/xAzaeoZzxoUkLGMHK
         gdPihF36U8Mxd6kwFoGyyzUdJpTE/JeciTf1MHC9b+1VadLT91wzo58axqyBRk79f3gF
         oXByqcvsrwHNOO/eiDmlcod0ABfBdhYVIOTeT9W3ufdRWY0SACYXixwZDrLP6pVw1jEm
         XkjCiTC0sbpqEfJJfId67dJBj5iD6GB9UHqiqNSZR8icR9FgwaJwKVbWo/7SnwXSkZet
         niYg==
X-Gm-Message-State: ALQs6tA9D30MjLd6CjCrC+JPJ8KMAIUEFz/vx87XtYdiEi5PnFcRZIye
        ShRoCn7OCtTV0VtKMSxO+vVUuMXeEMyzC1KYI0A=
X-Google-Smtp-Source: AIpwx4/bx7L/AO9IaDkSyZ2e2QKNSV8+Uj5iUHfcydJVvu/Zuki3EbBvhKkiv37qn08d+2GGVwiX5lhdyMixIO+TdS4=
X-Received: by 10.176.90.48 with SMTP id l45mr2426827uad.79.1524245689393;
 Fri, 20 Apr 2018 10:34:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Fri, 20 Apr 2018 10:34:48 -0700 (PDT)
In-Reply-To: <20180420133632.17580-1-benpeart@microsoft.com>
References: <20180420133632.17580-1-benpeart@microsoft.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 20 Apr 2018 10:34:48 -0700
Message-ID: <CABPp-BEwwn+NwOEtWOKOdUKxoXfq6YwWeoH6OwkPjSwVtTm5=Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] add additional config settings for merge
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 20, 2018 at 6:36 AM, Ben Peart <Ben.Peart@microsoft.com> wrote:
> This enables the user to set a couple of additional options for merge.
>
> 1. merge.aggressive - this is to try to resolve a few more trivial
>    merge cases.  It is documented in read-tree and is not something you
>    can pass into merge itself.
>
> 2. merge.renames - this is to save git from having to go through the entire
>    3 trees to see if there were any renames that happened.
>
> For the work item repro that I have been using this drops the merge time
> from ~1 hour to ~5 minutes and the unmerged entries goes down from
> ~40,000 to 1.

Ooh, this is *very* interesting.  Is there any chance I could also get
you to test performing the same merge with the version of git at
https://github.com/newren/git/tree/big-repo-small-cherry-pick and
report on your timings?

The 'big-repo-small-cherry-pick' name could be improved, but that
branch has a number of performance fixes for really poor rename
detection performance during merges.  From your description, I'm
pretty sure it'll apply to your case.  For my specific testcase,  I
got a speedup factor of 30.  Someone else on the list saw a factor of
24[1].  Results are highly dependent on the specific repo, but it's
certainly possible that it gets much of your factor of 12 speedup that
you saw with these new config settings you added.

However, what makes this case even more interesting to me is that my
branch may not be quite as effective as your workarounds.  There are
other other performance issues in merge that I am aware of, but for
which I haven't had the time to write the patches yet (I've been
waiting for the directory rename detection stuff to land and settle
down before working more on the performance aspects).  I do not know
how big a factor those other performance issues are, but your
workarounds (namely the aggressive setting) may get around some of
those other issues as well, so I'm very interested to see how my
current branch compares to the speedups you got with these settings.

Thanks,
Elijah


[1] https://public-inbox.org/git/alpine.DEB.2.00.1711211303290.20686@ds9.cixit.se/
