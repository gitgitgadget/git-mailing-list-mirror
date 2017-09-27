Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45A562047F
	for <e@80x24.org>; Wed, 27 Sep 2017 16:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751879AbdI0Q3C (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 12:29:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:52154 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751823AbdI0Q3B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 12:29:01 -0400
Received: (qmail 17352 invoked by uid 109); 27 Sep 2017 16:29:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Sep 2017 16:29:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16136 invoked by uid 111); 27 Sep 2017 16:29:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Sep 2017 12:29:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Sep 2017 12:28:58 -0400
Date:   Wed, 27 Sep 2017 12:28:58 -0400
From:   Jeff King <peff@peff.net>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] git: add --no-optional-locks option
Message-ID: <20170927162858.r6a3zx64bhqsoqzp@sigill.intra.peff.net>
References: <20170921043214.pyhdsrpy4omy54rm@sigill.intra.peff.net>
 <79ed4c34-1727-7c1e-868a-1206902638ad@gmail.com>
 <20170927064026.5xa3ydaggmknvulw@sigill.intra.peff.net>
 <1506520205.6209.4.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1506520205.6209.4.camel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 27, 2017 at 07:20:05PM +0530, Kaartic Sivaraam wrote:

> On Wed, 2017-09-27 at 02:40 -0400, Jeff King wrote:
> > On Sun, Sep 24, 2017 at 01:08:41PM +0530, Kaartic Sivaraam wrote:
> > 
> > > 
> > > So, if I get that correctly "git status --no-optional-locks" is a way to get
> > > the "current" status without updating the on disk index file?
> > 
> > It's actually "git --no-optional-locks status", since it's a git-wide
> > option (it's just that "status" is the only one who respects it for
> > now).
> 
> Thanks for correcting the command. Now let me ask my (corrected)
> question again! So, if I get that correctly "git --no-optional-
> locks status" is a way to get the "current" status *without updating*
> the on disk index file?

Yes.

-Peff
