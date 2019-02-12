Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E6731F453
	for <e@80x24.org>; Tue, 12 Feb 2019 09:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbfBLJVS (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 04:21:18 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:39260 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfBLJVS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 04:21:18 -0500
Received: by mail-wr1-f54.google.com with SMTP id t27so1813115wra.6
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 01:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=oCSwwFAYrbxRnzNJ1w+dxVHfH9xrlwDTGdrRsMXA5CA=;
        b=h85Y7++ZyAnSa6mf3FMdkpuJfPUaAQiY2yltRd9TGfIGz1alzh/5NY+zZ+4a0+41pL
         xQjobKePH0FuatQorTPFHzzTj9Zhj8EvglxKJ9wX3PRoyc7hWijJ0T6SO3gkru9vOufN
         FbVzzRVo5F7I/jNAokO/qjk6rUVGZRGfBJfm1DIb+LjxNuJJyuH0MKEJDjQ7fF9dfT1T
         0NIOE+TJHfiYNfTj9p0BS9Vt7g19eFdzO3XUhugn45W9B9bIcrZQ5LrHC7Yo6dPw/azr
         zbitSQY3zYK7FmBGY1efGiTXZ9w1RHGByfGkcUymcu+ULoT/SVLc8jRPVE9dd9WYe686
         3jIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=oCSwwFAYrbxRnzNJ1w+dxVHfH9xrlwDTGdrRsMXA5CA=;
        b=RTG1prEUHDI/Gcs1qyEU0CsW/waHytnOF+NjzY2xtAtTbZhJVva6cQXWheYEmZKwgR
         ie+PhT8iSMUshpI9utmic8/mytzq0SYzzQQD+syU3xoYjPH5RmsssKxYFoi452L0k42T
         Ld7omtiH1Ec7RWIqz+pG09ZjGwOfEw/htgVnZITZ4p8Vu8rK903+6cJ/ebphyCe1bnwT
         5HrELackCjKhcyfGB9aqTrd96bXEAR2GyTbU+sOfvj3Klu0nAY2Rt38hC9Otu9jIhSjr
         PCyNkUbq63YAAGW2ltRL9wOzwH8EBXZVaYdCA7QDM4AjpDq3mGu+74quDqjvtpYk6G0+
         Za9A==
X-Gm-Message-State: AHQUAubmFLVKt1kcP11rpSLxDZ/G1tc40wanmDXhekSMIeA3hXnxuClk
        PeuZ8bb41The/pJ7z6nsqAIHPqUs
X-Google-Smtp-Source: AHgI3IaQiaPfZdH23B3R4ejdrTtqoiuzB0ApooBLp0Tj4KHquyD6Cz0G9/ZmaBL8VzoDGcusO0IatQ==
X-Received: by 2002:a05:6000:1044:: with SMTP id c4mr2028992wrx.296.1549963276182;
        Tue, 12 Feb 2019 01:21:16 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id s8sm27393518wrn.44.2019.02.12.01.21.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 01:21:15 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Roman Gelfand <rgelfand2@gmail.com>
Cc:     git@vger.kernel.org, demerphq <demerphq@gmail.com>
Subject: Re: Hotfix Branching Strategy
References: <CAJbW+rkn7wbRhDvRTtdp1aF5wd5PWHu9DqvPFm-BdVkR02Wgvg@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <CAJbW+rkn7wbRhDvRTtdp1aF5wd5PWHu9DqvPFm-BdVkR02Wgvg@mail.gmail.com>
Date:   Tue, 12 Feb 2019 10:21:15 +0100
Message-ID: <874l99l5v8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 12 2019, Roman Gelfand wrote:

>  At any one time, up to 3 developers could be developing hotfixes
> addressing issues.    Whether it is one or multiple people working on
> hotfixes, we always want to produce one hotfix.  Each hotfix is a
> cumulative update since beginning of release.  Just about every hotfix
> requires database upgrade.  Being that it is cumulative each developer
> is dependent on the other.  Considering the requirements, what should
> be a strategy to deal with this problem.?

Requirements differ, but you may be interested in the strategy we
(Booking.com) use in git-deploy[1]. It hasn't been updated in a while,
but the hotfix logic is there.

Basically:

 1. You have a "master" branch where new development happens

 2. When you make deploys to your systems you deploy latest (or recent)
    "master". This creates a dated tag like foo-YYYYMMDDHHMMSS or
    bar-YYYYMMDDHHMMSS to deploy to the "foo" or "bar" set of servers.

 3. Instead of "update to master" you can also "hotfix" which starts a
    session where you (usually!) cherry-pick from "master", but you can
    *also* make new original work.

Now, the critical thing is that when you sync out #3 we perform the
following dance:

 A. Fetch latest upstream, origin/master

 B. Make a note of the SHA-1 of the hotfix we're about to sync (let's
    call this X)

 C. Merge our X into origin/master

 D. Push our merged origin/master+X to upstream origin/master (see [2]
    for some plans to make this easier)

 E. "git reset --hard X". We want to roll out our hotfix, not the merge
     with "master"

 F. Sync out our "X"

What this ensures is that:

 * After hotfixing e.g. "foo" a new deploy of "bar" will include the
   hotfix, since we pushed it upstream to master. Thus hotfixes
   (including "live" work") don't get forgotten. Imagine a critical bug
   discovered & fixed in "foo" during an outage, you don't want a new
   deploy of "foo" the next day to regress. Merging upstream to "master"
   is critical.

 * Since you need to resolve the merge conflicts with origin/master, if
   any, things like conflicts due to e.g. DB schema versioning need to
   be resolved. E.g. in many cases your conflict with master will
   require bumping a "serial" to a value that before the hotfix didn't
   exist.

 * You can do deployments where multiple hotfixes to a system are
   stacked one on top of the other, not as any specially supported
   thing, just as an emergent property of a "hotfix" dropping you into a
   session where you start with the current rollout, then you can
   e.g. cherry-pick on top of the "X" hotfix to produce "Y" etc.

 * All deployments ever are merged into "master" including hotfixes, so
   you can eventually prune the dated tags, and can just "git log" on
   master to see all deployments ever (as opposed to "git log --all"
   etc. which would also give you topics...)

So that's one approach.

The other thing people tend to do is to make a release, and at the same
time create a release branch, if they need a hotfix they develop on top
of that

That's also a valid strategy, but I think most shops that do that tend
to invent something to emulate what I've outlined above. I.e. now you
have a "foo" and a "bar" release while "master" is moving forward, and
need to cherry-pick and merge between them to make sure your next
release of "master" doesn't regress.

1. https://github.com/git-deploy/git-deploy

2. https://public-inbox.org/git/87sh7sdtc1.fsf@evledraar.gmail.com/
