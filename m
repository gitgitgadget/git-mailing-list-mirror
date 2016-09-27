Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D96E20986
	for <e@80x24.org>; Tue, 27 Sep 2016 19:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934274AbcI0TVw (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 15:21:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:49031 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933425AbcI0TVu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 15:21:50 -0400
Received: (qmail 3675 invoked by uid 109); 27 Sep 2016 19:21:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 27 Sep 2016 19:21:50 +0000
Received: (qmail 19052 invoked by uid 111); 27 Sep 2016 19:22:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 27 Sep 2016 15:22:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Sep 2016 15:21:48 -0400
Date:   Tue, 27 Sep 2016 15:21:48 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] xdiff: rename "struct group" to "struct xdlgroup"
Message-ID: <20160927192147.k2borko6ryxfx2gf@sigill.intra.peff.net>
References: <20160927043733.u3emlanbipu2cn5h@sigill.intra.peff.net>
 <9fb14a41-00b3-f8d1-d8d2-8aa41261492e@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9fb14a41-00b3-f8d1-d8d2-8aa41261492e@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 27, 2016 at 03:18:02PM +0200, Michael Haggerty wrote:

> > Let's resolve by giving the xdiff variant a scoped name,
> > which is closer to other xdiff types anyway (e.g.,
> > xdlfile_t, though note that xdiff is fond if typedefs when
> > Git usually is not).
> 
> Makes sense to me. I didn't try to adhere to xdiff conventions too
> tightly because I don't think that project is alive anymore, so I don't
> expect we'll be upstreaming anything [1]. But this change definitely
> makes sense.

Yeah, TBH I don't really care about following xdiff coding conventions.
They're pretty far from our own, and at this point I think xdiff is
basically just an imported part of our code base. Mostly my rationale
was that it's not too terribly out of place to give it an "xdl" name,
and it happens to solve my other problem, too. :)

> [1] Though I've since learned that libgit2 also bases their diff code on
> xdiff, so if we avoid changing things gratuitously there is more chance
> that our two projects can benefit from each other's improvements
> whenever they are also licensed compatibly.

I'd agree on not changing things gratuitously.

-Peff
