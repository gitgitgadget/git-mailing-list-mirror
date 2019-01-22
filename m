Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B3161F453
	for <e@80x24.org>; Tue, 22 Jan 2019 07:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfAVHVN (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 02:21:13 -0500
Received: from cloud.peff.net ([104.130.231.41]:43580 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726423AbfAVHVN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 02:21:13 -0500
Received: (qmail 6293 invoked by uid 109); 22 Jan 2019 07:21:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 22 Jan 2019 07:21:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3515 invoked by uid 111); 22 Jan 2019 07:21:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 22 Jan 2019 02:21:16 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Jan 2019 02:21:11 -0500
Date:   Tue, 22 Jan 2019 02:21:11 -0500
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?Q?S=C3=A9rgio?= Peixoto <sergio.peixoto@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] attr: do not mark queried macros as unset
Message-ID: <20190122072111.GD28555@sigill.intra.peff.net>
References: <CAK3b1G+88a=xfO=6wfRi1SMy3xtca2NcFyxuBLKwSifb_L9xwA@mail.gmail.com>
 <20190117160752.GA29375@sigill.intra.peff.net>
 <CAK3b1GJPZ5X3uEP1a-NF9PZkE0tTKVLda5hM32jExVz_OD2E=g@mail.gmail.com>
 <20190118165800.GA9956@sigill.intra.peff.net>
 <20190118213458.GB28808@sigill.intra.peff.net>
 <CACsJy8DFX2P6nF200YV_3VjXiags0W28awbSAwc9ztfEZPbJ4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8DFX2P6nF200YV_3VjXiags0W28awbSAwc9ztfEZPbJ4g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 21, 2019 at 05:05:56PM +0700, Duy Nguyen wrote:

> > It should be possible to salvage this optimization, but let's start with
> > just removing the remnants. It hasn't been doing anything (except
> > creating bugs) since 60a12722ac, and nobody seems to have noticed the
> > performance regression. It's more important to fix the correctness
> > problem clearly first.
> 
> But muh optimization!!! You're right of course, correctness comes
> first. I did try to look at this code but it's been a while and I'm
> afraid I don't have anything valuable to say. I'll dig in more in the
> next couple days.

:) See the side-thread, and the response I just wrote to Stefan. At this
point I do think it's possible, but my hope is that I could call it
quits with the bugfix portion and hand it off to somebody interested in
this area. I know you're juggling quite a few other series, though.

-Peff
