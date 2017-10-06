Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 005D61FC43
	for <e@80x24.org>; Fri,  6 Oct 2017 17:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752110AbdJFR2I (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 13:28:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:35518 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752017AbdJFR2I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 13:28:08 -0400
Received: (qmail 17262 invoked by uid 109); 6 Oct 2017 17:28:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Oct 2017 17:28:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8121 invoked by uid 111); 6 Oct 2017 17:28:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Oct 2017 13:28:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Oct 2017 13:28:05 -0400
Date:   Fri, 6 Oct 2017 13:28:05 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     "aleksander.baranowski" <aleksander.baranowski@yahoo.pl>,
        git@vger.kernel.org
Subject: Re: Git config multiple values
Message-ID: <20171006172805.2udoryqelqbim5eg@sigill.intra.peff.net>
References: <4b848032-e8b6-be67-58d9-e3fcc2c11853@yahoo.pl>
 <20171006143219.4bn63aoenluc77fd@sigill.intra.peff.net>
 <20171006172530.GV19555@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171006172530.GV19555@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 06, 2017 at 10:25:30AM -0700, Jonathan Nieder wrote:

> Jeff King wrote:
> > On Fri, Oct 06, 2017 at 01:10:17PM +0200, aleksander.baranowski wrote:
> 
> >> It's just an opinion, but this behaviour is no consistent for me.
> >>
> >> If it's not the bug it's a feature just let me know.
> >
> > It's a feature, though I agree that git-config is rather baroque. We're
> > mostly stuck with it for reasons of backwards compatibility, though.
> 
> This feels like a dodge.  Can we make a list of what is baroque here,
> with an eye to fixing it?  E.g. if we introduce a new --set option,
> then what should its semantics be, to be more intuitive?

Maybe baroque isn't the right word. But changing the function of a
command drastically based on the number of arguments seems like a source
of confusion.

I'm fine if somebody wants to champion a new "--set" option, but frankly
I'm not sure it's worth the pain at this point.

-Peff
