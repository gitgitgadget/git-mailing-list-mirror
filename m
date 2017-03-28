Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5409A20958
	for <e@80x24.org>; Tue, 28 Mar 2017 11:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932296AbdC1Llf (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 07:41:35 -0400
Received: from continuum.iocl.org ([217.140.74.2]:59510 "EHLO
        continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932072AbdC1Lle (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 07:41:34 -0400
Received: (from krey@localhost)
        by continuum.iocl.org (8.11.3/8.9.3) id v2SBUtl15970;
        Tue, 28 Mar 2017 13:30:55 +0200
Date:   Tue, 28 Mar 2017 13:30:55 +0200
From:   Andreas Krey <a.krey@gmx.de>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: UNS: Re: cherry-pick --message?
Message-ID: <20170328113055.GA5269@inner.h.apk.li>
References: <20170321160520.GA15550@inner.h.apk.li> <20170321170005.35ryjh4pr3jvvmx3@sigill.intra.peff.net> <20170321170734.GI28331@inner.h.apk.li> <20170321173335.n56veklbh4iginoa@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170321173335.n56veklbh4iginoa@sigill.intra.peff.net>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 21 Mar 2017 13:33:35 +0000, Jeff King wrote:
...
> Probably "format-patch | sed | am -3" is your best bet if you want to
> modify the patches in transit _and_ have the user just use normal git
> tools.

Except that 'git am' doesn't have --no-commit like cherry-pick does. :-(
It's always something. (Perhaps I'm instead going to rewrite the commit
before cherry-picking it.)

- Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
