Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31F7C211B3
	for <e@80x24.org>; Mon,  3 Dec 2018 21:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbeLCVeZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 16:34:25 -0500
Received: from cloud.peff.net ([104.130.231.41]:57686 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726096AbeLCVeV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 16:34:21 -0500
Received: (qmail 3299 invoked by uid 109); 3 Dec 2018 21:34:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 03 Dec 2018 21:34:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14094 invoked by uid 111); 3 Dec 2018 21:33:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 03 Dec 2018 16:33:48 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Dec 2018 16:34:19 -0500
Date:   Mon, 3 Dec 2018 16:34:19 -0500
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Paul Morelle <paul.morelle@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] rebase -i: introduce the 'test' command
Message-ID: <20181203213419.GE8700@sigill.intra.peff.net>
References: <3fb5a7ff-a63a-6fac-1456-4dbc9135d088@gmail.com>
 <nycvar.QRO.7.76.6.1811281600240.41@tvgsbejvaqbjf.bet>
 <25e07b91-3089-153c-2ecf-7d2d66bc3b65@gmail.com>
 <nycvar.QRO.7.76.6.1811281935310.41@tvgsbejvaqbjf.bet>
 <20181201200209.GC29120@sigill.intra.peff.net>
 <20181203175322.GA3892@duynguyen.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181203175322.GA3892@duynguyen.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 03, 2018 at 06:53:22PM +0100, Duy Nguyen wrote:

> On Sat, Dec 01, 2018 at 03:02:09PM -0500, Jeff King wrote:
> > I sometimes add "x false" to the top of the todo list to stop and create
> > new commits before the first one.
> 
> And here I've been doing the same by "edit" the first commit, add a
> new commit then reorder them in the second interactive rebase :P
> 
> This made me look at git-rebase.txt to really learn about interactive
> rebase. I think the interactive rebase section could use some
> improvements. Its style looks.. umm.. more story telling than a
> reference. Perhaps something like this to at least highlight the
> commands.

Yeah, I think the typographic change is an improvement that doesn't
really have a downside.

As Dscho mentioned, sometimes the story style is what you want, so I
don't think we'd want to simply rearrange it. It may be useful to
present the material twice, though: once as a table/list for reference,
and then once as a story working through an example.

-Peff
