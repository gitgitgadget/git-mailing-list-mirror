Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A86F41FCA9
	for <e@80x24.org>; Wed, 14 Sep 2016 19:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760068AbcINTLP (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 15:11:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:43291 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756516AbcINTLO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2016 15:11:14 -0400
Received: (qmail 6458 invoked by uid 109); 14 Sep 2016 19:11:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Sep 2016 19:11:13 +0000
Received: (qmail 2373 invoked by uid 111); 14 Sep 2016 19:11:24 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Sep 2016 15:11:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Sep 2016 12:11:10 -0700
Date:   Wed, 14 Sep 2016 12:11:10 -0700
From:   Jeff King <peff@peff.net>
To:     Mike Ralphson <mike.ralphson@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] vcs-svn/fast_export: fix timestamp fmt specifiers
Message-ID: <20160914191110.exo4f3gr2wszf2sh@sigill.intra.peff.net>
References: <01020157276d4d1f-9c995462-4aea-4949-8d29-3dbdbec77dd7-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <01020157276d4d1f-9c995462-4aea-4949-8d29-3dbdbec77dd7-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 14, 2016 at 06:40:57AM +0000, Mike Ralphson wrote:

> Two instances of %ld being used for unsigned longs

Obviously this is an improvement, but I'm kind of surprised that
compiler warnings didn't flag this. I couldn't find a "-W" combination
that noticed, though (at least not with gcc 6).

-Peff
