Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 760442035F
	for <e@80x24.org>; Fri, 11 Nov 2016 18:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935357AbcKKSNc (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 13:13:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:41916 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756887AbcKKSN2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 13:13:28 -0500
Received: (qmail 22559 invoked by uid 109); 11 Nov 2016 18:12:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 11 Nov 2016 18:12:58 +0000
Received: (qmail 15987 invoked by uid 111); 11 Nov 2016 18:13:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 11 Nov 2016 13:13:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Nov 2016 13:12:56 -0500
Date:   Fri, 11 Nov 2016 13:12:56 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mingw: hot-fix t5615
Message-ID: <20161111181256.gl5xu6jxqrd5cbg7@sigill.intra.peff.net>
References: <f4336a7fa3df8c0b426c3d01ada8d7d8f38e588a.1478881741.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f4336a7fa3df8c0b426c3d01ada8d7d8f38e588a.1478881741.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 11, 2016 at 05:29:33PM +0100, Johannes Schindelin wrote:

> That test made the incorrect assumption that the path separator character
> is always a colon. On Windows, it is a semicolon instead.

Oof, sorry about that. I remember being careful about the ";" while
doing the original alt-odb work, but forgot about it while making the
recent fix in 37a95862c.

The patch itself looks like obviously correct (or at least obviously in
the right direction, since it sounds like more is needed).

-Peff
