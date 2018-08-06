Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 090D3208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 21:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731471AbeHFXjZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 19:39:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:44784 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730310AbeHFXjZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 19:39:25 -0400
Received: (qmail 26020 invoked by uid 109); 6 Aug 2018 21:28:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 06 Aug 2018 21:28:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5000 invoked by uid 111); 6 Aug 2018 21:28:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 06 Aug 2018 17:28:28 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Aug 2018 17:28:25 -0400
Date:   Mon, 6 Aug 2018 17:28:25 -0400
From:   Jeff King <peff@peff.net>
To:     Noam Postavsky <npostavs@users.sourceforge.net>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Hemmo Nieminen <hemmo.nieminen@iki.fi>, git@vger.kernel.org
Subject: Re: [BUG] A part of an edge from an octopus merge gets colored, even
 with --color=never
Message-ID: <20180806212825.GB21026@sigill.intra.peff.net>
References: <CAM-tV-_Easz+HA0GX0YkY4FZ2LithQy0+omq64D-OoHKkRe55A@mail.gmail.com>
 <573B6BF5.1090004@kdbg.org>
 <20160517194533.GA11289@sigill.intra.peff.net>
 <20160517195136.GB11289@sigill.intra.peff.net>
 <20160517195541.GC11289@sigill.intra.peff.net>
 <CAM-tV-9gAGBLsEh3=aa-bHT2DmJb=dfahq+kUW+0GLoc7eFq0w@mail.gmail.com>
 <CAM-tV--dHGJbxfWGKrRde+Q2-cnmCXNshQtX4PN7jnMWER_+bg@mail.gmail.com>
 <20180625162308.GA13719@sigill.intra.peff.net>
 <CAM-tV-8sbbht7NUwf87-gq=+P=LNPyiEcv3zL+1BxfXK+ktmVA@mail.gmail.com>
 <CAM-tV-_=nbo8T4krCRoni9F5JyZ41oxHZLGnuPgshHw3ZZMRWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAM-tV-_=nbo8T4krCRoni9F5JyZ41oxHZLGnuPgshHw3ZZMRWA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 06, 2018 at 02:34:45PM -0400, Noam Postavsky wrote:

> On 30 June 2018 at 08:47, Noam Postavsky <npostavs@users.sourceforge.net> wrote:
> 
> > I'm still having trouble getting a big picture understanding of how
> > the graph struct relates the what gets drawn on screen, but through
> > some poking around with the debugger + trial & error, I've arrived at
> > a new patch which seems to work. It's also a lot simpler. I hope you
> > can tell me if it makes sense.
> >
> > Also attached an updated test-multiway-merge.sh which allows adding
> > more branches to test different sized merges more easily.
> 
> Ping? (I got some bounce message regarding test-multiway-merge.sh, but
> it does show up in the mailing list archive, so I think my message has
> gone through)
> 
> https://marc.info/?l=git&m=153036284214253&w=2

No, it made it. It just got shuffled to the bottom of my pile (for
future reference, you can ping more frequently than once a month if you
think something was dropped ;) ).

-Peff
