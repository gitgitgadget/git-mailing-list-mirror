Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1FC11F428
	for <e@80x24.org>; Fri,  5 Jan 2018 20:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752713AbeAEUoa (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 15:44:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:35800 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751884AbeAEUoa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 15:44:30 -0500
Received: (qmail 30330 invoked by uid 109); 5 Jan 2018 20:43:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 05 Jan 2018 20:43:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10941 invoked by uid 111); 5 Jan 2018 20:45:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 05 Jan 2018 15:45:01 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Jan 2018 15:44:28 -0500
Date:   Fri, 5 Jan 2018 15:44:28 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Isaac Shabtay <isaac@shabtay.com>, git@vger.kernel.org
Subject: Re: Bug report: git clone with dest
Message-ID: <20180105204427.GA6515@sigill.intra.peff.net>
References: <CAK2k7nSsygwRj_Hhrz7-qXZ8UBB=O+deOeC2FFTkrGmWSUpKqA@mail.gmail.com>
 <20180103222821.GA32287@sigill.intra.peff.net>
 <CAK2k7nRdk5qBp6Xzud-GS7YeSpchrQoOdqRd-3uXVeWZ1xsnVg@mail.gmail.com>
 <alpine.DEB.2.21.1.1801050019250.32@MININT-6BKU6QN.europe.corp.microsoft.com>
 <CAK2k7nTRAqQKFGi0OfVgub3vWZAkdML5p786L7UyhVDFtsk7Xg@mail.gmail.com>
 <alpine.DEB.2.21.1.1801051130500.32@MININT-6BKU6QN.europe.corp.microsoft.com>
 <CAK2k7nSWoNX+Y5dhLqLVzhzE12f3MgZo0R8xrHYKFwxCL+9mEg@mail.gmail.com>
 <nycvar.QRO.7.76.6.1801052118410.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1801052118410.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 05, 2018 at 09:22:07PM +0100, Johannes Schindelin wrote:

> On Fri, 5 Jan 2018, Isaac Shabtay wrote:
> 
> > Done: https://github.com/git-for-windows/git/pull/1421
> > 
> > I added credit to Jeff in the PR's description.
> 
> Sadly, the PR's description won't make it into the commit history, and the
> authorship really should have been retained.
> 
> I found Peff's topic branch in his fork and force-pushed, to demonstrate
> what I wanted to have. Currently the test suite is running (I test 64-bit
> builds of the three major platforms Windows, macOS and Linux), and once
> that is done and passed, I will merge the Pull Request.

I think the discussion has ended at "don't do anything else", but note
that Junio and I were musing on whether to update the series around the
dir_exists() function. Which would then create headaches for you later
when you try to merge a subtly-different series that makes it upstream.

Like I said, I think we've resolved not to do anything, but I wanted to
point out a potential pitfall with this kind of "pick up a topic early"
strategy (I'm intimately familiar with this pitfall because I do it all
the time for the fork we run on our servers at GitHub).

-Peff
