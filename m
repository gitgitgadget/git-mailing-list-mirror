Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CCAE2018A
	for <e@80x24.org>; Mon, 27 Jun 2016 19:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197AbcF0TKO (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 15:10:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:33603 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751940AbcF0TKN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 15:10:13 -0400
Received: (qmail 3148 invoked by uid 102); 27 Jun 2016 19:10:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Jun 2016 15:10:07 -0400
Received: (qmail 12438 invoked by uid 107); 27 Jun 2016 19:10:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Jun 2016 15:10:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Jun 2016 15:10:05 -0400
Date:	Mon, 27 Jun 2016 15:10:05 -0400
From:	Jeff King <peff@peff.net>
To:	Matthieu Moy <Matthieu.Moy@imag.fr>
Cc:	gitster@pobox.com, git@vger.kernel.org,
	Jordan DE GEA <jordan.de-gea@ensimag.grenoble-inp.fr>,
	Samuel GROOT <samuel.groot@ensimag.grenoble-inp.fr>,
	Erwan MATHONIERE <erwan.mathoniere@ensimag.grenoble-inp.fr>,
	Tom RUSSELLO <tom.russello@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH 3/6] doc: typeset -- as litteral
Message-ID: <20160627191005.GD9594@sigill.intra.peff.net>
References: <20160627174623.11084-1-Matthieu.Moy@imag.fr>
 <20160627174623.11084-3-Matthieu.Moy@imag.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160627174623.11084-3-Matthieu.Moy@imag.fr>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jun 27, 2016 at 07:46:20PM +0200, Matthieu Moy wrote:

> Subject: Re: [PATCH 3/6] doc: typeset -- as litteral

s/litteral/literal/

I can hardly blame you, though. I think English stole the word from
French and then switched its spelling. :)

You may also want put quotes around "--" to make it clear that you are
talking about it as punctuation, not using it as such in your sentence.

I read all the way through patch 6, and they all look good to me (though
the "litteral" typo appears again later). I won't bother responding to
each separately.

I do notice that your patterns are finding existing items marked with
single-quotes. We may have other cases lurking that are not quoted at
all (but should be). I think those could be a separate series, but if
anybody wants to look for them, I think searching for "\--" will help (a
literal double-dash needs that to avoid becoming an emdash).

-Peff
