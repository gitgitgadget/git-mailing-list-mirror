Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3617F203E1
	for <e@80x24.org>; Wed, 27 Jul 2016 19:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbcG0TQe (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 15:16:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:50063 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756845AbcG0TQd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 15:16:33 -0400
Received: (qmail 3840 invoked by uid 102); 27 Jul 2016 19:16:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Jul 2016 15:16:33 -0400
Received: (qmail 19958 invoked by uid 107); 27 Jul 2016 19:16:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Jul 2016 15:16:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Jul 2016 15:16:30 -0400
Date:	Wed, 27 Jul 2016 15:16:30 -0400
From:	Jeff King <peff@peff.net>
To:	Phil Pennock <phil.pennock@spodhuis.org>
Cc:	Phil Pennock <phil@pennock-tech.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] pretty format string support for reflog times
Message-ID: <20160727191630.GA6743@sigill.intra.peff.net>
References: <20160727081414.GA21451@breadbox>
 <20160727175622.GA9961@sigill.intra.peff.net>
 <20160727181334.GA24224@tower.spodhuis.org>
 <20160727183203.GE32219@sigill.intra.peff.net>
 <20160727184141.GA23975@tower.spodhuis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160727184141.GA23975@tower.spodhuis.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 27, 2016 at 06:41:41PM +0000, Phil Pennock wrote:

> On 2016-07-27 at 14:32 -0400, Jeff King wrote:
> > Yeah, I agree the "!" test for "did it work" is counter-intuitive if you're
> > coming from other languages, but it's pretty normal for C code bases
> > (especially ours).
> 
> For stuff returning pointers, sure.

I think the pattern comes more from syscalls.

> > I don't buy the tabs-become-spaces argument. We use tabs for indentation
> > in Git, and that's extremely unlikely to change. If your patch gets
> > munged in transit or by your editor, then the maintainer is going to
> > complain when applying your patch.
> 
> Okay.  (I happen to think that robustness against a cycle of developers
> discussing why whitespace broke patches in transit is good, but I'll
> change this).

What we've found is that if your whitespace breaks in transit, the
patches don't apply anyway (because of wrapping, or because tab/space
conversion breaks the context lines). So we mostly just accept the risk
and stay militant about it.

> I'm not going to write any more code today, for reasons of "weak human
> needs sleep and I'll make more stupid mistakes if I continue".  So I'm
> going silent on this thread for the rest of today.  Not ignoring.  If
> folks want fast progress (I haven't looked at release cycle status) I
> won't mind cutting me out of the loop :-D but otherwise I'll look
> Thu/Fri this week for any remedial work and offer a fresh patch with
> fixes from this thread, and documentation.

Sure, take your time. It's open source, so movement is generally
measured in days, and sometimes weeks. Thank you for working on it!

> I'm tempted to just steal the docs from Ted's patch, unless that's
> considered bad form?

I think that's fine, especially considering how short the snippet is.
If you pulled content from somewhere, it's normal to acknowledge it in
the commit message.

-Peff
