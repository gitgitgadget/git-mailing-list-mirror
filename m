Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E79020958
	for <e@80x24.org>; Thu, 23 Mar 2017 18:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935751AbdCWSW0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 14:22:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:50417 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935747AbdCWSW0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 14:22:26 -0400
Received: (qmail 8950 invoked by uid 109); 23 Mar 2017 18:22:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Mar 2017 18:22:24 +0000
Received: (qmail 9052 invoked by uid 111); 23 Mar 2017 18:22:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Mar 2017 14:22:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Mar 2017 14:22:21 -0400
Date:   Thu, 23 Mar 2017 14:22:21 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] sequencer: fix missing newline
Message-ID: <20170323182221.i3noikxpmrn4ymi4@sigill.intra.peff.net>
References: <20170323170233.50499-1-bmwill@google.com>
 <alpine.DEB.2.20.1703231839570.3767@virtualbox>
 <20170323174716.GA111250@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170323174716.GA111250@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2017 at 10:47:16AM -0700, Brandon Williams wrote:

> On 03/23, Johannes Schindelin wrote:
> > Hi Brandon,
> > 
> > On Thu, 23 Mar 2017, Brandon Williams wrote:
> > 
> > > When using rebase --interactive where one of the lines is marked as
> > > 'edit' this is the resulting output:
> > > 
> > >     Stopped at ec3b9c4...  stuffYou can amend the commit now, with
> > 
> > Ugh, I should have caught this. The warning() call implicitly adds a
> > newline, the fprintf() doesn't.
> > 
> > Patch is obviously good.
> 
> All good.  If we're keeping score for finding each others bugs, I still
> think you're winning :)

It's my bug, actually. Brown paper bag, anyone?

-Peff
