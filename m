Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C46141FC96
	for <e@80x24.org>; Tue, 29 Nov 2016 20:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754853AbcK2UtU (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Nov 2016 15:49:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:48725 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755285AbcK2UtS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2016 15:49:18 -0500
Received: (qmail 13465 invoked by uid 109); 29 Nov 2016 20:49:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Nov 2016 20:49:17 +0000
Received: (qmail 15061 invoked by uid 111); 29 Nov 2016 20:49:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Nov 2016 15:49:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Nov 2016 15:49:15 -0500
Date:   Tue, 29 Nov 2016 15:49:15 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v3 1/2] difftool: add a skeleton for the upcoming builtin
Message-ID: <20161129204915.lo45b2jz57dlfug5@sigill.intra.peff.net>
References: <alpine.DEB.2.20.1611251841030.117539@virtualbox>
 <20161125174721.f35mzc276kdwakzm@sigill.intra.peff.net>
 <alpine.DEB.2.20.1611261320050.117539@virtualbox>
 <20161126161907.xol62zytn2jb45gh@sigill.intra.peff.net>
 <alpine.DEB.2.20.1611261400300.117539@virtualbox>
 <20161127165058.uxujjehyjq7httro@sigill.intra.peff.net>
 <xmqqa8cjlekl.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1611281830040.117539@virtualbox>
 <xmqqa8cjjtfn.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1611292128340.117539@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1611292128340.117539@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 29, 2016 at 09:36:55PM +0100, Johannes Schindelin wrote:

> So the suggestion by both you and Peff, to use an environment variable,
> which is either global, or requires the user to set it manually per
> session, is simply not a good idea at all.

No, my suggestion was to use config and have the test suite use an
environment variable to test both cases (preferably automatically,
without the user having to do anything).

I do not see how that fails to cover all of your use cases.

-Peff
