Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E3381F454
	for <e@80x24.org>; Mon, 11 Nov 2019 04:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfKKEPw (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Nov 2019 23:15:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:44136 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726754AbfKKEPw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Nov 2019 23:15:52 -0500
Received: (qmail 14957 invoked by uid 109); 11 Nov 2019 04:15:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 11 Nov 2019 04:15:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1593 invoked by uid 111); 11 Nov 2019 04:19:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 10 Nov 2019 23:19:20 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 10 Nov 2019 23:15:51 -0500
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: Git Developer Pages cleanup
Message-ID: <20191111041551.GD6379@sigill.intra.peff.net>
References: <CAP8UFD3sVR+Z3ktYUhSCtfCr9fY0btX2UEve+o0y=iuooVTVEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD3sVR+Z3ktYUhSCtfCr9fY0btX2UEve+o0y=iuooVTVEQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 10, 2019 at 07:15:35PM +0100, Christian Couder wrote:

> Hi everyone,
> 
> For sometime I have been thinking about cleaning up the Git Developer
> Pages web site (https://git.github.io/), and making some of the
> documentation there more generic and possibly more useful for all kind
> of newcomers.

Thanks for taking care of this. I agree these pages have been in need of
some cleanup for ages.

> So I pushed the following commits:
> 
> * 17b7b3e SoC: remove 2017 SoC material from the navbar
> * 4e01d0a SoC: remove 2018 SoC material from the navbar
> * 7c13096 Outreachy: fix titles
> 
> Old GSoC and Outreachy material can now only be accessed through the
> Historical Summer of Code Materials
> (https://git.github.io/SoC-Historical/) link.

I almost wonder if they could be dropped entirely, as they'd still be
accessible via the Git repository. But maybe somebody finds it useful to
be able to see them from the built web page.

> * 717ec3c Add General-Microproject-Information.md
> 
> Extract information from https://git.github.io/SoC-2019-Microprojects/
> to make it independent of GSoC or Outreachy. I think it's really
> better to have a separate document and just link to it, instead of
> copy pasting it each time.

Yeah, this is much better.

-Peff
