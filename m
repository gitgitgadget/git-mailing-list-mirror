Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29A74203E1
	for <e@80x24.org>; Wed, 27 Jul 2016 18:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757121AbcG0SxA (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 14:53:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:50025 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754303AbcG0SxA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 14:53:00 -0400
Received: (qmail 2802 invoked by uid 102); 27 Jul 2016 18:53:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Jul 2016 14:53:00 -0400
Received: (qmail 19588 invoked by uid 107); 27 Jul 2016 18:53:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Jul 2016 14:53:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Jul 2016 14:52:56 -0400
Date:	Wed, 27 Jul 2016 14:52:56 -0400
From:	Jeff King <peff@peff.net>
To:	Phil Pennock <phil@pennock-tech.com>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 0/2] t4205 style fixes
Message-ID: <20160727185256.GA11657@sigill.intra.peff.net>
References: <20160727081414.GA21451@breadbox>
 <20160727175622.GA9961@sigill.intra.peff.net>
 <20160727181334.GA24224@tower.spodhuis.org>
 <20160727183203.GE32219@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160727183203.GE32219@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 27, 2016 at 02:32:03PM -0400, Jeff King wrote:

> > This however was matching existing style for `head1` and `head2` a
> > little above.  I was somewhat surprised.
> 
> Ah. Yeah, those are wrong and bad. We should fix that.

So here's that fix, along with a style cleanup for the here-docs.

  [1/2]: t4205: drop top-level &&-chaining
  [2/2]: t4205: indent here documents

Hopefully that provides a nicer base for building your patch on top of.

-Peff
