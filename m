Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B94BB203E1
	for <e@80x24.org>; Sun, 24 Jul 2016 15:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928AbcGXPc6 (ORCPT <rfc822;e@80x24.org>);
	Sun, 24 Jul 2016 11:32:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:48365 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751340AbcGXPcz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2016 11:32:55 -0400
Received: (qmail 5594 invoked by uid 102); 24 Jul 2016 15:32:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 24 Jul 2016 11:32:54 -0400
Received: (qmail 19318 invoked by uid 107); 24 Jul 2016 15:33:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 24 Jul 2016 11:33:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 24 Jul 2016 11:32:51 -0400
Date:	Sun, 24 Jul 2016 11:32:51 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 0/3] minor git-jump improvements
Message-ID: <20160724153251.GA32609@sigill.intra.peff.net>
References: <20160722162707.GA13905@sigill.intra.peff.net>
 <alpine.DEB.2.20.1607231050360.14111@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1607231050360.14111@virtualbox>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Jul 23, 2016 at 10:52:09AM +0200, Johannes Schindelin wrote:

> On Fri, 22 Jul 2016, Jeff King wrote:
> 
> > Here are a few quick fixes and features for git-jump. The first is a bug
> > I noticed and fixed recently. And that reminded me of the second one,
> > which I'd been carrying in my local copy for a long time.
> > 
> >   [1/3]: contrib/git-jump: fix greedy regex when matching hunks
> >   [2/3]: contrib/git-jump: add whitespace-checking mode
> >   [3/3]: contrib/git-jump: fix typo in README
> 
> These 3 patches look good to me.
> 
> They also made me aware of git-jump's existence and purpose. I think I
> shall use this script a lot myself from now on.

Yay, now there are at least 2 users.

Bug reports and patches very welcome. :)

-Peff
