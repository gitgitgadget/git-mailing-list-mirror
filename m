Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0C7B20248
	for <e@80x24.org>; Fri, 15 Mar 2019 18:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfCOSnK (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 14:43:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:52880 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725956AbfCOSnK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 14:43:10 -0400
Received: (qmail 1495 invoked by uid 109); 15 Mar 2019 18:43:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 Mar 2019 18:43:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2476 invoked by uid 111); 15 Mar 2019 18:43:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 15 Mar 2019 14:43:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Mar 2019 14:43:08 -0400
Date:   Fri, 15 Mar 2019 14:43:08 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Roberto Tyley <roberto.tyley@gmail.com>
Subject: Re: [RFC/PATCH] point pull requesters to Git Git Gadget
Message-ID: <20190315184308.GC4941@sigill.intra.peff.net>
References: <20190312213246.GA6252@sigill.intra.peff.net>
 <xmqqsgvrfsrh.fsf@gitster-ct.c.googlers.com>
 <20190313193909.GB3400@sigill.intra.peff.net>
 <20190313201854.GA5530@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1903141228510.41@tvgsbejvaqbjf.bet>
 <20190315031948.GD28943@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1903151427460.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1903151427460.41@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 15, 2019 at 02:42:42PM +0100, Johannes Schindelin wrote:

> Another thing that I always dreamed of having: GitGitGadget could
> automatically warn about commit messages that are incomplete, that
> disagree with our preferred format, that contain typos or offensive
> language.
> 
> Likewise, I had this idea that once we had some robust Clang format
> definition, GitGitGadget could verify that the patches conform to what we
> want, and automatically generate fixed branches if not.
> 
> Basically, all the automation I can get, to relieve humans from tasks that
> machines can do.
> 
> Children can have dreams, can't they ;-)

I like all of those dreams. :)

I think the "checks" could all just be another form of CI. I think there
may be some tricks with automatic rewriting, but it might be possible to
do it in the form of GitHub "suggestions", which a human could then
click "OK" to a bunch of them. I guess it would be overwhelming if you
really diverged style-wise and the diff is large.

I don't think GitHub has any support for changing commit messages,
though, short of your tool force-pushing.

-Peff
