Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5365FC4724C
	for <git@archiver.kernel.org>; Mon,  4 May 2020 15:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 235E920721
	for <git@archiver.kernel.org>; Mon,  4 May 2020 15:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbgEDPj3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 11:39:29 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:34133 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbgEDPj3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 11:39:29 -0400
Received: by mail-wr1-f42.google.com with SMTP id y3so2477101wrt.1
        for <git@vger.kernel.org>; Mon, 04 May 2020 08:39:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HAqjhoQmiPlC/ZEgWOM8EvJGVF/lpzpkZL9eXxCR2so=;
        b=nWVAAoqoHzANDOXgVb1i7CmwMM/NcG1WpltnhlQTG7W54j82dV901ZLK7w1z1WJQFv
         YlwKWOmssjr6Tw7xiEiN9s0oaZYL1iiA8nJw1sLEVCbJY38/87s56O6HEvadPkPcpA9o
         bJgtg00f0clyTCBBTwXTNRl0ZoZ/Wasn7zUxE6VOdjbHpgMF3StC2V0U3Xic17WaBjpO
         Wdvkk0x0V0YdwArT7jdUoI91wXk9L28q4uUOm1fTuqoQuSukxj71SNgCQJkgegcrlUWG
         M9+WJA2ATKghdKD/vnZ1sqXSLeq0s5Y/qtEmXkWeg8GGXCP592W+Gqgw8wGxyZ8T+g5D
         ARpg==
X-Gm-Message-State: AGi0PuZqKXp1zkgoYC+hoSShzrlSIL/0x/KTSUaKp++NEp0YGOn02C7A
        klUnow5julTdPSEWYXIp7mntSldiKUfPuDltqOs=
X-Google-Smtp-Source: APiQypIusO3Y75KiCkaCUD5zBrUE0NDQY8B62ESInN69KiO9bXi0YuaD7jWi+8CSjQNzVJn/Q+KeU9k5wwCKyNt+pwI=
X-Received: by 2002:a5d:4fc6:: with SMTP id h6mr21188135wrw.277.1588606765944;
 Mon, 04 May 2020 08:39:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAH8yC8myTMOetxgaj1wt0MbvSQ0LSRV0FHz4ywsBM1zzhUQG=w@mail.gmail.com>
In-Reply-To: <CAH8yC8myTMOetxgaj1wt0MbvSQ0LSRV0FHz4ywsBM1zzhUQG=w@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 4 May 2020 11:39:14 -0400
Message-ID: <CAPig+cReUs5Ka-gw_hXJ0XZLBmPVjV_tzJkd+TWvdTX+N-inxg@mail.gmail.com>
Subject: Re: Git 2.26.2 and failed self tests on OS X
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I'm building Git 2.26.2 from sources on a Mac-mini with OS X 10.12.6
> and a PowerMac with OS X 10.5. Some of the t3902-quoted.sh tests are
> failing.
>
> *** t3902-quoted.sh ***
> not ok 1 - setup
> not ok 3 - check fully quoted output from ls-files
> not ok 4 - check fully quoted output from diff-files
> not ok 5 - check fully quoted output from diff-index
> not ok 6 - check fully quoted output from diff-tree
> not ok 7 - check fully quoted output from ls-tree
> not ok 9 - check fully quoted output from ls-files
> not ok 10 - check fully quoted output from diff-files
> not ok 11 - check fully quoted output from diff-index
> not ok 12 - check fully quoted output from diff-tree
> not ok 13 - check fully quoted output from ls-tree

I am unable to reproduce these failures on OS X 10.13.6.
