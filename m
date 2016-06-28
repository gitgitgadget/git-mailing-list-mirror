Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F6D32018A
	for <e@80x24.org>; Tue, 28 Jun 2016 16:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752115AbcF1QqC (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 12:46:02 -0400
Received: from cloud.peff.net ([50.56.180.127]:34224 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752209AbcF1QqA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 12:46:00 -0400
Received: (qmail 26037 invoked by uid 102); 28 Jun 2016 16:45:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Jun 2016 12:45:59 -0400
Received: (qmail 8805 invoked by uid 107); 28 Jun 2016 16:46:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Jun 2016 12:46:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Jun 2016 12:45:55 -0400
Date:	Tue, 28 Jun 2016 12:45:55 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>, Karsten Blees <blees@dcon.de>,
	Stepan Kasal <kasal@ucw.cz>,
	Lukas Fleischer <lfleischer@lfos.de>
Subject: Re: [PATCH] Remove obsolete comment from color.h
Message-ID: <20160628164555.GA13821@sigill.intra.peff.net>
References: <16f3d3edb03c2cb9a6c11b745eda9fb2274af182.1467108142.git.johannes.schindelin@gmx.de>
 <xmqqinwt9v6e.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1606281822240.12947@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1606281822240.12947@virtualbox>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jun 28, 2016 at 06:24:05PM +0200, Johannes Schindelin wrote:

> Essentially, the caveat in color.h that one should use fprintf() and
> printf() when outputting color sequences to a terminal no longer holds
> true. fwrite() or write() work just as well.

Cool. One less thing to worry about.

Thanks for digging into this.

-Peff
