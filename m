Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E3F91FD09
	for <e@80x24.org>; Wed, 31 May 2017 15:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751194AbdEaPb1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 11:31:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:60601 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751097AbdEaPb1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 11:31:27 -0400
Received: (qmail 24900 invoked by uid 109); 31 May 2017 15:31:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 31 May 2017 15:31:24 +0000
Received: (qmail 5421 invoked by uid 111); 31 May 2017 15:32:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 31 May 2017 11:32:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 31 May 2017 11:31:24 -0400
Date:   Wed, 31 May 2017 11:31:24 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Zero King <l2dy@macports.org>
Subject: Re: [PATCH 6.5?/8] version: move --build-options to a test helper
Message-ID: <20170531153123.atl45b3kbfmqhnta@sigill.intra.peff.net>
References: <20170530051742.3j3yn3ipfmyrrteu@sigill.intra.peff.net>
 <20170530204553.25968-1-avarab@gmail.com>
 <20170530210530.o5gbz2k24wxrfner@sigill.intra.peff.net>
 <alpine.DEB.2.21.1.1705311726110.3610@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1705311726110.3610@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 31, 2017 at 05:27:21PM +0200, Johannes Schindelin wrote:

> > My intent in putting it into the actual git binary was that it could
> > also be useful for collecting build-time knobs from users (who may be
> > using a binary package). Like:
> > 
> >   http://public-inbox.org/git/20160712035719.GA30281@sigill.intra.peff.net/
> > 
> > We haven't filled in that NEEDSWORK yet, but I'd rather see us go in
> > that direction than remove the option entirely.
> 
> FWIW it also helped Git for Windows.
> 
> The two additional bits we added to the build options (the commit from
> which Git was built and the architecture) did not hurt one bit, either.
> 
> In other words, it would make my life a lot harder if --build-options were
> moved to a test helper that does not ship with the end product.

Cool, I'm glad it has helped already. If you have further bits added to
the output, is it worth sending that patch upstream?

-Peff
