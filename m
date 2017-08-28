Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62266208DB
	for <e@80x24.org>; Mon, 28 Aug 2017 13:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751215AbdH1NdZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Aug 2017 09:33:25 -0400
Received: from continuum.iocl.org ([217.140.74.2]:59272 "EHLO
        continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751171AbdH1NdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2017 09:33:25 -0400
Received: (from krey@localhost)
        by continuum.iocl.org (8.11.3/8.9.3) id v7SDWru23797;
        Mon, 28 Aug 2017 15:32:53 +0200
Date:   Mon, 28 Aug 2017 15:32:53 +0200
From:   Andreas Krey <a.krey@gmx.de>
To:     Jeff King <peff@peff.net>, Bryan Turner <bturner@atlassian.com>
Cc:     git@vger.kernel.org
Subject: Re: ignoring extra bitmap file?
Message-ID: <20170828133253.GA23438@inner.h.apk.li>
References: <20170817192436.GA4782@inner.h.apk.li> <20170818065333.7povtg6b4sugnnfg@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170818065333.7povtg6b4sugnnfg@sigill.intra.peff.net>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 18 Aug 2017 02:53:34 +0000, Jeff King wrote:
...
> Whether there's a .bitmap doesn't impact whether .pack and .idx files
> are deleted. The next full repack would pack everything into a new big
> pack, and then delete any existing files, including .pack, .idx, and
> .bitmap.

It took a bit of patience, but the extra packs and .bitmaps
finally went away without intervention.

However, now I have a few GB sitting in loose objects that
refuse to vanish yet. Bryan might be interested here;
how often is bitbucket 4.latest doing prune-objects
(with auto-gc disabled)?

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
