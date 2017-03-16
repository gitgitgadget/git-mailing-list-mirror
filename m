Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A0FC20953
	for <e@80x24.org>; Thu, 16 Mar 2017 22:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752684AbdCPWLe (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 18:11:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:45479 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752193AbdCPWLd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 18:11:33 -0400
Received: (qmail 2854 invoked by uid 109); 16 Mar 2017 22:10:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Mar 2017 22:10:48 +0000
Received: (qmail 13183 invoked by uid 111); 16 Mar 2017 22:10:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Mar 2017 18:10:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Mar 2017 18:10:45 -0400
Date:   Thu, 16 Mar 2017 18:10:45 -0400
From:   Jeff King <peff@peff.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/2] Re-integrate sha1dc
Message-ID: <20170316221044.ij5yuifmohktn6cl@sigill.intra.peff.net>
References: <alpine.LFD.2.20.1703161315310.18484@i7.lan>
 <20170316220456.m4yz2kbvzv6waokn@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170316220456.m4yz2kbvzv6waokn@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 16, 2017 at 06:04:56PM -0400, Jeff King wrote:

> So here's my version. It's on top of the hash.h tweak, as well.
> 
>   [1/5]: add collision-detecting sha1 implementation
>   [2/5]: sha1dc: adjust header includes for git
>   [3/5]: sha1dc: disable safe_hash feature
>   [4/5]: Makefile: add USE_SHA1DC knob
>   [5/5]: t0013: add a basic sha1 collision detection test
> [...]
>  t/t0013/shattered-1.pdf |  Bin 0 -> 422435 bytes

So obviously I had the same 100K problem you did on the first patch, but
the fifth one also won't make it to the list. You can pull the whole
thing from:

  https://github.com/peff/git.git jk/sha1dc

-Peff
