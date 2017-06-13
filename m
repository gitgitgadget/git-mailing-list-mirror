Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 084AD20282
	for <e@80x24.org>; Tue, 13 Jun 2017 11:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752578AbdFMLaT (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 07:30:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:38998 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752418AbdFMLaS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 07:30:18 -0400
Received: (qmail 29455 invoked by uid 109); 13 Jun 2017 11:30:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Jun 2017 11:30:17 +0000
Received: (qmail 23585 invoked by uid 111); 13 Jun 2017 11:30:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Jun 2017 07:30:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Jun 2017 07:30:16 -0400
Date:   Tue, 13 Jun 2017 07:30:16 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 8/8] Use the early config machinery to expand aliases
Message-ID: <20170613113015.6l35nyyu3vbtjss7@sigill.intra.peff.net>
References: <cover.1496951503.git.johannes.schindelin@gmx.de>
 <af40ce088de03130a5edfae187bb8274b5a9d3a9.1496951503.git.johannes.schindelin@gmx.de>
 <20170610100730.j62kh2hayt6zknr5@sigill.intra.peff.net>
 <alpine.DEB.2.21.1.1706131323330.171564@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1706131323330.171564@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 13, 2017 at 01:25:53PM +0200, Johannes Schindelin wrote:

> > But couldn't we just unconditionally do:
> > 
> >   setup_git_directory_gently();
> 
> But of course we can do that! Why on earth did I not think of that...
> 
> Will change the code accordingly.

Thanks. I was really worried you were going to come back with some
subtle point that I missed. But I'm happy we will be able to take the
simpler route.

-Peff
