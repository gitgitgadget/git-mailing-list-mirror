Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB55A20FCF
	for <e@80x24.org>; Fri,  1 Jul 2016 07:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752148AbcGAHn7 (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 03:43:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:38826 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752043AbcGAHn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 03:43:58 -0400
Received: (qmail 28313 invoked by uid 102); 1 Jul 2016 07:43:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jul 2016 03:43:59 -0400
Received: (qmail 14421 invoked by uid 107); 1 Jul 2016 07:44:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jul 2016 03:44:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Jul 2016 03:43:54 -0400
Date:	Fri, 1 Jul 2016 03:43:54 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	dmh@ucar.edu, git@vger.kernel.org
Subject: Re: git-credentials-store.exe crash
Message-ID: <20160701074354.GA12006@sigill.intra.peff.net>
References: <7210bce6-093b-9fdf-9a9b-94059ad0d4e3@ucar.edu>
 <20160701040715.GB4832@sigill.intra.peff.net>
 <alpine.DEB.2.20.1607010938140.12947@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1607010938140.12947@virtualbox>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 01, 2016 at 09:38:33AM +0200, Johannes Schindelin wrote:

> it is sad when bug reporters simply delete the part of our bug reporting
> template that says: "I searched for existing bug reports but did not find
> any".
> 
> It saves the reporters a few minutes... and spends the time of you and me
> in the hour range.
> 
> In this particular case, the bug report is an obvious duplicate of
> https://github.com/git-for-windows/git/issues/766
> 
> The saddest part is that I already spent time to investigate this and to
> come up with a work-around, and I already committed and pushed it.
> 
> So those hours are now thoroughly wasted.

Yeah, you're right. Same bug, and your patch obviously is the right
thing to do as an immediate fix.

If it's any consolation, I diagnosed the bug quite quickly, and the
extra hours went to solving the greater problem that you mentioned in
https://github.com/git-for-windows/git/issues/766#issuecomment-226985175.

So hopefully there is still some value in my series.

-Peff
