Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99CD31FEB3
	for <e@80x24.org>; Sat,  7 Jan 2017 01:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S940439AbdAGBba (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 20:31:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:36316 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932554AbdAGBb3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2017 20:31:29 -0500
Received: (qmail 30388 invoked by uid 109); 7 Jan 2017 01:31:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 07 Jan 2017 01:31:28 +0000
Received: (qmail 22074 invoked by uid 111); 7 Jan 2017 01:32:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 06 Jan 2017 20:32:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Jan 2017 20:31:26 -0500
Date:   Fri, 6 Jan 2017 20:31:26 -0500
From:   Jeff King <peff@peff.net>
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] branch_get_push: do not segfault when HEAD is detached
Message-ID: <20170107013126.4ub726mf73y36of3@sigill.intra.peff.net>
References: <20170106045623.21118-1-kyle@kyleam.com>
 <alpine.DEB.2.20.1701061438300.3469@virtualbox>
 <87inprllpv.fsf@kyleam.com>
 <20170107011138.uuy6ob234kyy3y4e@sigill.intra.peff.net>
 <87bmvjll8m.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87bmvjll8m.fsf@kyleam.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 06, 2017 at 08:19:53PM -0500, Kyle Meyer wrote:

> > The other option is just "git checkout --detach", which is also used in
> > the test suite. I tend to prefer it because it's a little more obvious
> > to a reader.
> 
> True, that does seem clearer.  Seems I should've waited a bit before
> sending out v2.

I think it's OK either way. Junio can also mark it up while applying,
too, if he has a preference.

-Peff
