Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6160D20958
	for <e@80x24.org>; Thu, 23 Mar 2017 20:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935385AbdCWUm5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 16:42:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:50593 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932209AbdCWUm5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 16:42:57 -0400
Received: (qmail 18907 invoked by uid 109); 23 Mar 2017 20:42:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Mar 2017 20:42:56 +0000
Received: (qmail 11111 invoked by uid 111); 23 Mar 2017 20:43:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Mar 2017 16:43:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Mar 2017 16:42:54 -0400
Date:   Thu, 23 Mar 2017 16:42:54 -0400
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH v1] travis-ci: build and test Git on Windows
Message-ID: <20170323204253.etxrovhbxfmfve6s@sigill.intra.peff.net>
References: <xmqqwpbhjej6.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1703231716320.3767@virtualbox>
 <20170323180134.geoyvq7qbm5vujo6@sigill.intra.peff.net>
 <xmqqbmsrdcz4.fsf@gitster.mtv.corp.google.com>
 <20170323191721.7r5vrixtnx3cngdc@sigill.intra.peff.net>
 <FE4A3F88-0B86-4069-B141-2DFB9C4E269E@gmail.com>
 <20170323193823.gxodwqv4eshgtqbc@sigill.intra.peff.net>
 <3CC8E237-86EA-4F35-A03E-15BED5869403@gmail.com>
 <20170323202002.lfpuglqawz4ooruw@sigill.intra.peff.net>
 <CEE52E60-F31F-4BA9-BA79-7526EE6C5397@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CEE52E60-F31F-4BA9-BA79-7526EE6C5397@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2017 at 09:39:14PM +0100, Lars Schneider wrote:

> > Could be. Looking at:
> > 
> >  https://travis-ci.org/peff/git/branches
> > 
> > It seems to timeout on over half the branches (in fact, there are only a
> > few that passed all of the tests). My pattern is particularly spiky from
> > Travis's perspective, because once a day I rebase everything on top of
> > master and push them the whole thing in a bunch. So they 75 branches,
> > all at once. That seems like it would be ripe for throttling (though I
> > would much rather they just queue the builds and do them one at a time).
> 
> Could you try to set this to 7 or less in your TravisCI?
> https://docs.travis-ci.com/user/customizing-the-build#Limiting-Concurrent-Builds
> 
> I am curious if this improves the situation.

Sure, that's easy enough to try. I'll let it go for a few days with that
and see if it improves.

-Peff
