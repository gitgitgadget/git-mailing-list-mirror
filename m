Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AED811F404
	for <e@80x24.org>; Fri,  6 Apr 2018 20:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751735AbeDFUQ3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 16:16:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:56384 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751447AbeDFUQ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 16:16:28 -0400
Received: (qmail 26386 invoked by uid 109); 6 Apr 2018 20:16:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Apr 2018 20:16:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29237 invoked by uid 111); 6 Apr 2018 20:17:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 06 Apr 2018 16:17:29 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Apr 2018 16:16:26 -0400
Date:   Fri, 6 Apr 2018 16:16:26 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5404: relax overzealous test
Message-ID: <20180406201626.GA16310@sigill.intra.peff.net>
References: <958ee6f006aba0c67c8e064d31206e3e68a1cc49.1523043053.git.johannes.schindelin@gmx.de>
 <20180406195331.GC11450@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1804062212310.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1804062212310.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 06, 2018 at 10:13:46PM +0200, Johannes Schindelin wrote:

> On Fri, 6 Apr 2018, Jeff King wrote:
> 
> > On Fri, Apr 06, 2018 at 09:31:22PM +0200, Johannes Schindelin wrote:
> > 
> > > Suppose, however, that you are a big fan of whales. Or even better: your
> > > IT administrator has a whale of a time picking cute user names, e.g.
> > > referring to you (due to your like of India Pale Ales) as "one of the
> > > cuter rorquals" (see https://en.wikipedia.org/wiki/Rorqual to learn a
> > > thing or two about rorquals) and hence your home directory becomes
> > > /home/cuterrorqual. If you now run t5404, it fails! Why? Because the
> > > test calls `git push origin :b3` which outputs:
> > > 
> > >     To /home/cuterrorqual/git/t/trash directory.t5404-tracking-branches/.
> > >      - [deleted]         b3
> > 
> > This is from the same Dscho who complains about the length of some of my
> > commit messages, right? ;P
> 
> Yes. I've quieted down, though, didn't I? Mainly because I see the merit
> in your long commit messages now. Never too late to learn.

Heh, well I'm glad I've won you over, then. And thank you for cleaning
up my (ancient) mess here.

-Peff
