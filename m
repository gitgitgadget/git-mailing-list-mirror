Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28F8F2018E
	for <e@80x24.org>; Tue, 16 Aug 2016 21:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753595AbcHPVP4 (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 17:15:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:56568 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753391AbcHPVPz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 17:15:55 -0400
Received: (qmail 1941 invoked by uid 109); 16 Aug 2016 21:15:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Aug 2016 21:15:54 +0000
Received: (qmail 31264 invoked by uid 111); 16 Aug 2016 21:15:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Aug 2016 17:15:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Aug 2016 17:15:51 -0400
Date:	Tue, 16 Aug 2016 17:15:51 -0400
From:	Jeff King <peff@peff.net>
To:	Josh Triplett <josh@joshtriplett.org>
Cc:	git@vger.kernel.org
Subject: Re: upload-pack/ls-remote: showing non-HEAD symbolic refs?
Message-ID: <20160816211551.fjobjxcqvo2dfiry@sigill.intra.peff.net>
References: <20160816161838.klvjhhoxsftvkfmd@x>
 <20160816163145.mjc726til2daxl3d@sigill.intra.peff.net>
 <20160816173444.rpqlpsz2ognvlufy@x>
 <20160816182852.inyqzplee5m3wzt6@sigill.intra.peff.net>
 <20160816203150.GA16774@cloud>
 <20160816205426.dotqythoyn7zztma@sigill.intra.peff.net>
 <20160816211141.GA16922@cloud>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160816211141.GA16922@cloud>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 16, 2016 at 02:11:41PM -0700, Josh Triplett wrote:

> > For HTTPS, I'd just as soon use HTTP-level features.
> 
> ALPN, used carefully, could potentially allow eliminating one round-trip
> compared to HTTPS, and could also allow full-duplex communication.

I'd love to have a real full-duplex git-over-https. I looked into
WebSockets at one point, but it looked non-trivial and I gave up.

But if we had a real full-duplex connection over https, I think there
would be no reason for git:// to continue existing (we'd probably keep
ssh as it's a useful protocol for authentication, though).

-Peff
