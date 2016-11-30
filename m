Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61B0E1FF40
	for <e@80x24.org>; Wed, 30 Nov 2016 12:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756220AbcK3Mfn (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 07:35:43 -0500
Received: from cloud.peff.net ([104.130.231.41]:49026 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755838AbcK3Mfl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 07:35:41 -0500
Received: (qmail 10337 invoked by uid 109); 30 Nov 2016 12:35:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 30 Nov 2016 12:35:40 +0000
Received: (qmail 21195 invoked by uid 111); 30 Nov 2016 12:36:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 30 Nov 2016 07:36:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Nov 2016 07:35:38 -0500
Date:   Wed, 30 Nov 2016 07:35:38 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v3 1/2] difftool: add a skeleton for the upcoming builtin
Message-ID: <20161130123538.pydczcx6rbth7ng7@sigill.intra.peff.net>
References: <alpine.DEB.2.20.1611261320050.117539@virtualbox>
 <20161126161907.xol62zytn2jb45gh@sigill.intra.peff.net>
 <alpine.DEB.2.20.1611261400300.117539@virtualbox>
 <20161127165058.uxujjehyjq7httro@sigill.intra.peff.net>
 <xmqqa8cjlekl.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1611281830040.117539@virtualbox>
 <xmqqa8cjjtfn.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1611292128340.117539@virtualbox>
 <20161129204915.lo45b2jz57dlfug5@sigill.intra.peff.net>
 <alpine.DEB.2.20.1611301330100.117539@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1611301330100.117539@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 30, 2016 at 01:30:47PM +0100, Johannes Schindelin wrote:

> On Tue, 29 Nov 2016, Jeff King wrote:
> 
> > On Tue, Nov 29, 2016 at 09:36:55PM +0100, Johannes Schindelin wrote:
> > 
> > > So the suggestion by both you and Peff, to use an environment variable,
> > > which is either global, or requires the user to set it manually per
> > > session, is simply not a good idea at all.
> > 
> > No, my suggestion was to use config and have the test suite use an
> > environment variable to test both cases (preferably automatically,
> > without the user having to do anything).
> > 
> > I do not see how that fails to cover all of your use cases.
> 
> Oh, so the suggestion is to have *both* a config *and* an environment
> variable. That is not elegant.

No, that is not at all what I said.  I was going to explain myself
again, but I do not see what good it would do, as clearly my point did
not come across in the other three emails. And then you would just
complain that I am making work for you. So whatever. I do not care about
your difftool topic at all. Do whatever you like (which hey, I already
said before, too).

-Peff
