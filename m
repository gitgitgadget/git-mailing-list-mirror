Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482F8C2BA19
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 11:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CEA920732
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 11:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408858AbgDOLKI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 07:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408850AbgDOLJr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 07:09:47 -0400
X-Greylist: delayed 437 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Apr 2020 04:00:14 PDT
Received: from vps892.directvps.nl (unknown [IPv6:2a02:2308::216:3eff:fede:83d0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35D5C061A0F
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 04:00:14 -0700 (PDT)
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 64FC14400E1; Wed, 15 Apr 2020 12:52:47 +0200 (CEST)
Date:   Wed, 15 Apr 2020 12:52:47 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     git@vger.kernel.org
Subject: Re: Fetching 24 Linux commits = 1.2 GiB
Message-ID: <20200415105247.GA1710231@alpha>
Mail-Followup-To: Kevin Daudt <me@ikke.info>, Jiri Slaby <jslaby@suse.cz>,
        git@vger.kernel.org
References: <b7f5bfb9-61fb-2552-4399-b744428728e4@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7f5bfb9-61fb-2552-4399-b744428728e4@suse.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 15, 2020 at 10:01:46AM +0200, Jiri Slaby wrote:
> Hi,
> 
> I was at 8f3d9f354286 of:
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> 
> I did git remote update today and it fetched:
> Receiving objects: 100% (7330823/7330823), 1.20 GiB
> It updated master: 8f3d9f354286..8632e9b5645b, that is 24 small commits.
> 
> One colleague of mine fetched 1324 commits:
> Receiving objects: 100% (6820/6820), 4.21 MiB | 6.70 MiB/s, done.
> Resolving deltas: 100% (5114/5114), completed with 1035 local objects.
> From git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux
>    7e63420847ae..8632e9b5645b  master     -> origin/master
> 
> Another colleague fetched the same what I and:
>   Receiving objects: 100% (7330823/7330823), 1.20 GiB
> too.
> 
> I did git gc --prune && git prune now and I am at 1.7G back from 3.5 G.
> 
> Is that a bug? What info should I provide?
> 
> thanks,
> -- 
> js
> suse labs

Not as big as you report, but I recall a user on IRC (guardian) was
wondering as well why a packfile was 240MB while they claimed that the
objects were committed months ago.


