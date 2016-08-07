Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 847381FD99
	for <e@80x24.org>; Sun,  7 Aug 2016 23:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937AbcHGXOi (ORCPT <rfc822;e@80x24.org>);
	Sun, 7 Aug 2016 19:14:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:36544 "HELO cloud.peff.net"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with SMTP
	id S1751593AbcHGXOi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2016 19:14:38 -0400
Received: (qmail 2283 invoked by uid 102); 7 Aug 2016 23:14:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 07 Aug 2016 19:14:38 -0400
Received: (qmail 24168 invoked by uid 111); 7 Aug 2016 23:14:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 07 Aug 2016 19:14:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 07 Aug 2016 19:14:35 -0400
Date:	Sun, 7 Aug 2016 19:14:35 -0400
From:	Jeff King <peff@peff.net>
To:	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:	Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] archive-tar: make write_extended_header() void
Message-ID: <20160807231434.a5i2fka5ezeiczrc@sigill.intra.peff.net>
References: <57A5F5BA.8010702@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <57A5F5BA.8010702@web.de>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Aug 06, 2016 at 04:35:38PM +0200, René Scharfe wrote:

> The function write_extended_header() only ever returns 0.  Simplify
> it and its caller by dropping its return value, like we did with
> write_global_extended_header() earlier.

Obviously correct, and much nicer to read. Thanks.

-Peff
