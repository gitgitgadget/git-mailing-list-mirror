Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C615A2018A
	for <e@80x24.org>; Fri,  1 Jul 2016 22:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752328AbcGAWiQ (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 18:38:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:39416 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752102AbcGAWiO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 18:38:14 -0400
Received: (qmail 1735 invoked by uid 102); 1 Jul 2016 22:38:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jul 2016 18:38:14 -0400
Received: (qmail 24103 invoked by uid 107); 1 Jul 2016 22:38:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jul 2016 18:38:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Jul 2016 18:38:10 -0400
Date:	Fri, 1 Jul 2016 18:38:10 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	"dmh@ucar.edu" <dmh@ucar.edu>, git@vger.kernel.org
Subject: Re: [PATCH 1/5] add an extra level of indirection to main()
Message-ID: <20160701223809.GA32545@sigill.intra.peff.net>
References: <20160701055532.GA4488@sigill.intra.peff.net>
 <20160701055858.GA4593@sigill.intra.peff.net>
 <alpine.DEB.2.20.1607010953440.12947@virtualbox>
 <20160701081919.GA21076@sigill.intra.peff.net>
 <alpine.DEB.2.20.1607011449380.12947@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.20.1607011449380.12947@virtualbox>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 01, 2016 at 03:39:03PM +0200, Johannes Schindelin wrote:

> > The description was sufficiently long that I didn't want to try
> > repeating it, and opted for a reference instead. If you're planning to
> > fix mingw_main(), I'd be happy to do that as a preparatory patch, and
> > then just skip this trickery entirely. :)
> 
> Deal:
> 
> ½/5 is in 5c54dff5c54e68a1101d8fe37aefc6158fddd7f2 and the fixup for 1/5
> is in 7b74f7aabb56b428c74f5983c066dc9ea8fe5116 in the 'common-main' branch
> on https://github.com/dscho/git.

Hrm. I didn't find 5c54dff5c when I fetched from dscho/git. However,
having seen 7b74f7aa, the one that comes on top, I actually think that's
what we really want anyway. It's really my first patch that makes your
cleanup safe to do.

-Peff
