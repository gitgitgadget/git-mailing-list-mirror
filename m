Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0820209AB
	for <e@80x24.org>; Wed,  6 Sep 2017 13:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754433AbdIFN2B (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Sep 2017 09:28:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:58558 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754177AbdIFN17 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2017 09:27:59 -0400
Received: (qmail 17959 invoked by uid 109); 6 Sep 2017 13:27:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Sep 2017 13:27:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21736 invoked by uid 111); 6 Sep 2017 13:28:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Sep 2017 09:28:31 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Sep 2017 09:27:57 -0400
Date:   Wed, 6 Sep 2017 09:27:57 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] system_path: move RUNTIME_PREFIX to a sub-function
Message-ID: <20170906132756.jj6esh6nrk7iuvjz@sigill.intra.peff.net>
References: <20170906122834.s7a6je4b7casdfxx@sigill.intra.peff.net>
 <20170906123027.w5y7s33p5p2kfzia@sigill.intra.peff.net>
 <alpine.DEB.2.21.1.1709061522420.4132@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1709061522420.4132@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 06, 2017 at 03:23:42PM +0200, Johannes Schindelin wrote:

> On Wed, 6 Sep 2017, Jeff King wrote:
> 
> > I find the diff hard to read because it shows the opposite of what I did
> > (moving the big block to its own function, rather than moving the little
> > bits to a new copy of the function).
> 
> I guess --patience would have made it slightly more readable. I did not
> find any commit in your fork on GitHub with the commit subject, else I
> would have pasted the output of `git diff --patience` here.

I hadn't pushed it yet (but it's there now, 130217f4a). Neither
--patience nor --histogram produces markedly different results. I think
the issue is just that what I actually did (moving the big inner block)
is not nearly as minimal a diff as moving what surrounds it.

-Peff
