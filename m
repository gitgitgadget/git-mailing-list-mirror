Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8014720D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 15:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752368AbdFAPyd (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 11:54:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:33247 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752252AbdFAPyb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 11:54:31 -0400
Received: (qmail 24360 invoked by uid 109); 1 Jun 2017 15:54:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Jun 2017 15:54:25 +0000
Received: (qmail 18820 invoked by uid 111); 1 Jun 2017 15:55:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Jun 2017 11:55:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Jun 2017 11:54:26 -0400
Date:   Thu, 1 Jun 2017 11:54:26 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Kevin Willford <kcwillford@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com, Kevin Willford <kewillf@microsoft.com>
Subject: Re: [PATCH 1/2] format-patch: have progress option while generating
 patches
Message-ID: <20170601155426.hx7ximvrvqmdteoj@sigill.intra.peff.net>
References: <20170531150427.7820-1-kewillf@microsoft.com>
 <20170531150427.7820-2-kewillf@microsoft.com>
 <20170531220100.t27w3w642sn33h7s@sigill.intra.peff.net>
 <alpine.DEB.2.21.1.1706011312510.3610@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1706011312510.3610@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 01, 2017 at 01:15:57PM +0200, Johannes Schindelin wrote:

> On Wed, 31 May 2017, Jeff King wrote:
> 
> > I'm generally in favor of progress meters, though it does seem a little
> > funny to me that we'd need one on format-patch.
> 
> When working with huge repositories with a large number of branches, it is
> all too easy to pick the wrong branch to rebase to. In that case, it can
> take a long time for the `git rebase` call to even generate the mbox.
> 
> Kevin's patch is a visual indication when this is happening.

Right, sorry if it wasn't clear from the rest of my message. My
statement was one of surprise, not objection. I understand his use case.

-Peff
