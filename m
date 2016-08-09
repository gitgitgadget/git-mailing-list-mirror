Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7B231FD99
	for <e@80x24.org>; Tue,  9 Aug 2016 11:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752316AbcHILiY (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 07:38:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:51940 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751337AbcHILiY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 07:38:24 -0400
Received: (qmail 22457 invoked by uid 109); 9 Aug 2016 11:38:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Aug 2016 11:38:23 +0000
Received: (qmail 19902 invoked by uid 111); 9 Aug 2016 11:38:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Aug 2016 07:38:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Aug 2016 07:38:21 -0400
Date:	Tue, 9 Aug 2016 07:38:21 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
Subject: Re: t0027 racy?
Message-ID: <20160809113821.5p36pksfmwrhuylv@sigill.intra.peff.net>
References: <alpine.DEB.2.20.1608081556280.5786@virtualbox>
 <20160808152926.mciovipy5qlnqegs@sigill.intra.peff.net>
 <alpine.DEB.2.20.1608091329480.5786@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1608091329480.5786@virtualbox>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 09, 2016 at 01:33:04PM +0200, Johannes Schindelin wrote:

> On Mon, 8 Aug 2016, Jeff King wrote:
> 
> > I got failure within about 30 seconds on t0027 (though 5 minutes? Yeesh.
> > It runs in 9s on my laptop. I weep for you).
> 
> Yep. That is the price I (and all other Git for Windows developers) pay
> for the decision to implement Git's entire test suite in Shell script,
> including expensive tests with over a 1,000 test cases such as t0027.

To be fair, it does not run unless you set GIT_TEST_LONG. Even _I_ don't
do that by default.

-Peff
