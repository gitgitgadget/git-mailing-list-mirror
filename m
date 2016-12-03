Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 324E51FC96
	for <e@80x24.org>; Sat,  3 Dec 2016 05:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751241AbcLCFZW (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Dec 2016 00:25:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:51081 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750784AbcLCFZW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Dec 2016 00:25:22 -0500
Received: (qmail 5726 invoked by uid 109); 3 Dec 2016 05:24:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 03 Dec 2016 05:24:24 +0000
Received: (qmail 19736 invoked by uid 111); 3 Dec 2016 05:25:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 03 Dec 2016 00:25:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 03 Dec 2016 00:24:22 -0500
Date:   Sat, 3 Dec 2016 00:24:22 -0500
From:   Jeff King <peff@peff.net>
To:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 4/4] shallow.c: remove useless test
Message-ID: <20161203052422.hhaj3idboo6r6dz5@sigill.intra.peff.net>
References: <1480710664-26290-1-git-send-email-rv@rasmusvillemoes.dk>
 <1480710664-26290-4-git-send-email-rv@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1480710664-26290-4-git-send-email-rv@rasmusvillemoes.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 02, 2016 at 09:31:04PM +0100, Rasmus Villemoes wrote:

> It seems to be odd to do x=y if x==y. Maybe there's a bug somewhere near
> this, but as is this is somewhat confusing.

Yeah, this code is definitely wrong, but I'm not sure what it's trying
to do. This is the first time I've looked at it.

-Peff
