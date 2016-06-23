Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDFF71FF40
	for <e@80x24.org>; Thu, 23 Jun 2016 18:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbcFWSjL (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 14:39:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:59254 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751166AbcFWSjK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 14:39:10 -0400
Received: (qmail 32727 invoked by uid 102); 23 Jun 2016 18:39:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jun 2016 14:39:10 -0400
Received: (qmail 13574 invoked by uid 107); 23 Jun 2016 18:39:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jun 2016 14:39:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jun 2016 14:39:08 -0400
Date:	Thu, 23 Jun 2016 14:39:08 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org, Simon Courtois <scourtois@cubyx.fr>
Subject: Re: [PATCH v2 7/7] color: support strike-through attribute
Message-ID: <20160623183907.GA32368@sigill.intra.peff.net>
References: <20160623173048.GA19923@sigill.intra.peff.net>
 <20160623174015.GG15774@sigill.intra.peff.net>
 <xmqqpor7iwgo.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpor7iwgo.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jun 23, 2016 at 11:36:23AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > This is the only remaining attribute that is commonly
> > supported (at least by xterm) that we don't support. Let's
> > add it for completeness.
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> > This was mostly for fun.  I can't think of a way in which it would be
> > useful, and I'm not sure how compelling completionism is as an argument
> > for inclusion. I'm OK if we drop this one.
> 
> It indeed is fun and it even makes sense in this context:
> 
>     $ ./git -c diff.color.old='red strike' show

Ooh, I hadn't thought of that. It's a bit noisy for my tastes in a
line-oriented diff, but with --color-words, it actually helps quite a
bit (try it on the documentation patch from this series, for example).

-Peff
