Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAC4C2BA19
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 08:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1E222051A
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 08:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635668AbgDOIMC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 04:12:02 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:39425 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2635647AbgDOIL6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 04:11:58 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 492FSV70y2z1qs3d;
        Wed, 15 Apr 2020 10:11:54 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 492FSV6p86z1qtwb;
        Wed, 15 Apr 2020 10:11:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id os8VaT8k4Sxd; Wed, 15 Apr 2020 10:11:54 +0200 (CEST)
X-Auth-Info: LJRmI6qII11JLUykvEQwPzzGt2o+dnF5MwRo655xsVRZ1qLogWY1QPaxxSqjNVMS
Received: from igel.home (ppp-46-244-163-102.dynamic.mnet-online.de [46.244.163.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 15 Apr 2020 10:11:54 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id A7DA22C0C5D; Wed, 15 Apr 2020 10:11:53 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     git@vger.kernel.org
Subject: Re: Fetching 24 Linux commits = 1.2 GiB
References: <b7f5bfb9-61fb-2552-4399-b744428728e4@suse.cz>
X-Yow:  I want to dress you up as TALLULAH BANKHEAD and cover you with
 VASELINE and WHEAT THINS..
Date:   Wed, 15 Apr 2020 10:11:53 +0200
In-Reply-To: <b7f5bfb9-61fb-2552-4399-b744428728e4@suse.cz> (Jiri Slaby's
        message of "Wed, 15 Apr 2020 10:01:46 +0200")
Message-ID: <878sixdv7a.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Apr 15 2020, Jiri Slaby wrote:

> I was at 8f3d9f354286 of:
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>
> I did git remote update today and it fetched:
> Receiving objects: 100% (7330823/7330823), 1.20 GiB
> It updated master: 8f3d9f354286..8632e9b5645b, that is 24 small commits.

What's your git version?  I just did exactly the same update with git
2.26.1, and it only fetched 144 objects:

Receiving objects: 100% (144/144), 50.50 KiB | 1.87 MiB/s, done.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
