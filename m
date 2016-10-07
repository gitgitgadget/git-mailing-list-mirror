Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB17E20986
	for <e@80x24.org>; Fri,  7 Oct 2016 14:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754091AbcJGOdQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 10:33:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:53932 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752930AbcJGOdO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 10:33:14 -0400
Received: (qmail 29951 invoked by uid 109); 7 Oct 2016 14:32:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 07 Oct 2016 14:32:03 +0000
Received: (qmail 5791 invoked by uid 111); 7 Oct 2016 14:32:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 07 Oct 2016 10:32:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Oct 2016 10:32:01 -0400
Date:   Fri, 7 Oct 2016 10:32:01 -0400
From:   Jeff King <peff@peff.net>
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] clean up confusing suggestion for commit references
Message-ID: <20161007143200.qw77pdsymbdmjhbw@sigill.intra.peff.net>
References: <20161007095638.GA55445@book.hvoigt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161007095638.GA55445@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 07, 2016 at 11:56:38AM +0200, Heiko Voigt wrote:

> The description for referencing commits looks as if it is contradicting
> the example, since it is itself enclosed in double quotes. Lets use
> single quotes around the description and include the double quotes in
> the description so it matches the example.
> ---
> Sorry for opening this up again but I just looked up the format and was
> like: "Umm, which one is now the correct one..."
> 
> For this makes more sense. What do others think?

Looking over the threads, I wasn't sure there was consensus[1,2]. So it would
be equally correct to drop the quotes from the example.

I dunno. I am in favor of no-quotes, myself, so maybe I am just
manufacturing dissent in my mind. :)

-Peff

[1] http://public-inbox.org/git/a9731f60-5c30-0bc6-f73a-f7ffb7bd4231@kdbg.org/
[2] http://public-inbox.org/git/20160829183015.2uqnfezekjfa3ott@sigill.intra.peff.net/
