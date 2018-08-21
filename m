Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEBA11F954
	for <e@80x24.org>; Tue, 21 Aug 2018 19:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbeHUW35 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 18:29:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:50780 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727329AbeHUW34 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 18:29:56 -0400
Received: (qmail 7035 invoked by uid 109); 21 Aug 2018 19:08:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 21 Aug 2018 19:08:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26151 invoked by uid 111); 21 Aug 2018 19:08:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 21 Aug 2018 15:08:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Aug 2018 15:08:32 -0400
Date:   Tue, 21 Aug 2018 15:08:32 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/6] reuse on-disk deltas for fetches with bitmaps
Message-ID: <20180821190832.GA30888@sigill.intra.peff.net>
References: <20180817205427.GA19580@sigill.intra.peff.net>
 <20180821190622.GA30301@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180821190622.GA30301@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 21, 2018 at 03:06:22PM -0400, Jeff King wrote:

> On Fri, Aug 17, 2018 at 04:54:27PM -0400, Jeff King wrote:
> 
> > This series more aggressively reuses on-disk deltas to serve fetches
> > when reachability bitmaps tell us a more complete picture of what the
> > client has. That saves server CPU and results in smaller packs. See the
> > final patch for numbers and more discussion.
> 
> Here's a v2, with just a few cosmetic fixes to address the comments on
> v1 (range-diff below).

Whoops. I accidentally just sent these as replies to the wrong thread:

  https://public-inbox.org/git/20180821184140.GA24165@sigill.intra.peff.net/

I'll avoid spamming the list by re-sending, but let me know if it's
easier to simply repost.

-Peff
