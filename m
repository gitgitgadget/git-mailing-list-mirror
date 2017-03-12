Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EEF820352
	for <e@80x24.org>; Sun, 12 Mar 2017 12:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755738AbdCLMZD (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Mar 2017 08:25:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:42810 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755704AbdCLMZC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2017 08:25:02 -0400
Received: (qmail 29080 invoked by uid 109); 12 Mar 2017 12:25:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 12 Mar 2017 12:25:01 +0000
Received: (qmail 12292 invoked by uid 111); 12 Mar 2017 12:25:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 12 Mar 2017 08:25:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 12 Mar 2017 08:24:59 -0400
Date:   Sun, 12 Mar 2017 08:24:59 -0400
From:   Jeff King <peff@peff.net>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [RFC][PATCH] index-pack: add testcases found using AFL
Message-ID: <20170312122458.5iyypzfbpl6kblkn@sigill.intra.peff.net>
References: <20170310151556.18490-1-vegard.nossum@oracle.com>
 <20170310190641.i7geazhrlmzzfna6@sigill.intra.peff.net>
 <eec5ab2a-7fe7-b47f-8073-a8212a9634f1@oracle.com>
 <20170310194245.p37w6mew4que6oya@sigill.intra.peff.net>
 <3a09226f-6749-6956-6fb9-265383cd4d66@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3a09226f-6749-6956-6fb9-265383cd4d66@oracle.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 10, 2017 at 10:18:23PM +0100, Vegard Nossum wrote:

> On 10/03/2017 20:42, Jeff King wrote:
> > > > That's something I guess, but I'm not enthused by the idea of just
> > > > dumping a bunch of binary test cases that nobody, not even the author,
> > > > understands.
> [...]
> 
> > My real concern is that this is the tip of the ice berg. So we increased
> > coverage in one program by a few percent. But wouldn't this procedure be
> > applicable to lots of _other_ parts of Git, too?
> 
> I think that index-pack is in a special position given its role as the
> verifier for packs received over the network, which you also wrote here:
> https://www.spinics.net/lists/git/msg265118.html

That's true. If we take that attitude, my "slippery slope" concerns go
away.

-Peff
