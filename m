Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 964D2211B3
	for <e@80x24.org>; Sun,  2 Dec 2018 03:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725300AbeLBDbP (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Dec 2018 22:31:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:56408 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725290AbeLBDbP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Dec 2018 22:31:15 -0500
Received: (qmail 14151 invoked by uid 109); 2 Dec 2018 03:31:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 02 Dec 2018 03:31:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3252 invoked by uid 111); 2 Dec 2018 03:30:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 01 Dec 2018 22:30:39 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Dec 2018 22:31:10 -0500
Date:   Sat, 1 Dec 2018 22:31:10 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        paul.morelle@gmail.com, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] rebase -i: introduce the 'test' command
Message-ID: <20181202033110.GA30004@sigill.intra.peff.net>
References: <3fb5a7ff-a63a-6fac-1456-4dbc9135d088@gmail.com>
 <nycvar.QRO.7.76.6.1811281600240.41@tvgsbejvaqbjf.bet>
 <25e07b91-3089-153c-2ecf-7d2d66bc3b65@gmail.com>
 <nycvar.QRO.7.76.6.1811281935310.41@tvgsbejvaqbjf.bet>
 <20181201200209.GC29120@sigill.intra.peff.net>
 <CAPig+cT6yo+wBHhkaAFK1REisOdtZsJNWEhoShcspzQsFeiWxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cT6yo+wBHhkaAFK1REisOdtZsJNWEhoShcspzQsFeiWxQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 01, 2018 at 09:28:47PM -0500, Eric Sunshine wrote:

> On Sat, Dec 1, 2018 at 3:02 PM Jeff King <peff@peff.net> wrote:
> > On Thu, Nov 29, 2018 at 09:32:48AM +0100, Johannes Schindelin wrote:
> > > In reality, I think that it would even make sense to change the default to
> > > reschedule failed `exec` commands. Which is why I suggested to also add a
> > > config option.
> >
> > I sometimes add "x false" to the top of the todo list to stop and create
> > new commits before the first one. That would be awkward if I could never
> > get past that line. However, I think elsewhere a "pause" line has been
> > discussed, which would serve the same purpose.
> 
> Are you thinking of the "break" command (not "pause") which Dscho
> already added[1]?
> 
> [1]: 71f82465b1 (rebase -i: introduce the 'break' command, 2018-10-12)

Yes, thanks (as you can see, I haven't actually used it yet ;) ).

-Peff
