Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A440C1F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 21:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752347AbdAYVfr (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 16:35:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:44828 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752337AbdAYVfq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 16:35:46 -0500
Received: (qmail 4773 invoked by uid 109); 25 Jan 2017 21:35:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 21:35:46 +0000
Received: (qmail 16418 invoked by uid 111); 25 Jan 2017 21:35:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 16:35:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Jan 2017 16:35:44 -0500
Date:   Wed, 25 Jan 2017 16:35:44 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 0/7] Macros for Asciidoctor support
Message-ID: <20170125213544.eelk4pjhrhshi6zh@sigill.intra.peff.net>
References: <20170122024156.284180-1-sandals@crustytoothpaste.net>
 <alpine.DEB.2.20.1701251425080.3469@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1701251425080.3469@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 25, 2017 at 02:28:55PM +0100, Johannes Schindelin wrote:

> > The need for the extensions could be replaced with a small amount of
> > Ruby code, if that's considered desirable.  Previous opinions on doing
> > so were negative, however.
> 
> Quite frankly, it is annoying to be forced to install the extensions. I
> would much rather have the small amount of Ruby code in Git's repository.

Me too. Dependencies can be a big annoyance. I'd reserve judgement until
I saw the actual Ruby code, though. :)

-Peff
