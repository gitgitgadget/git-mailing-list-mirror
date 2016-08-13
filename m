Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F01401F6C1
	for <e@80x24.org>; Sun, 14 Aug 2016 10:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752668AbcHNKef (ORCPT <rfc822;e@80x24.org>);
	Sun, 14 Aug 2016 06:34:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:54973 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752268AbcHNKef (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2016 06:34:35 -0400
Received: (qmail 1891 invoked by uid 109); 13 Aug 2016 18:34:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 Aug 2016 18:34:32 +0000
Received: (qmail 4039 invoked by uid 111); 13 Aug 2016 18:34:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 Aug 2016 14:34:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Aug 2016 14:34:29 -0400
Date:	Sat, 13 Aug 2016 14:34:29 -0400
From:	Jeff King <peff@peff.net>
To:	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:	Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] receive-pack: use FLEX_ALLOC_MEM in queue_command()
Message-ID: <20160813183429.lhgl3qfx7gf4duvj@sigill.intra.peff.net>
References: <57AF3F10.3050508@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <57AF3F10.3050508@web.de>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Aug 13, 2016 at 05:38:56PM +0200, René Scharfe wrote:

> Use the macro FLEX_ALLOC_MEM instead of open-coding it.  This shortens
> and simplifies the code a bit.

Thanks, looks good (I obviously missed a few opportunities for
conversion during the initial introduction of FLEX_ALLOC simply by not
noticing; I don't think there is any more reason that this one was not
converted).

-Peff
