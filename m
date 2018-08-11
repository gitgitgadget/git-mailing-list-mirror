Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82E601F404
	for <e@80x24.org>; Sat, 11 Aug 2018 16:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbeHKTOl (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Aug 2018 15:14:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:51090 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727562AbeHKTOl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Aug 2018 15:14:41 -0400
Received: (qmail 744 invoked by uid 109); 11 Aug 2018 16:39:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 11 Aug 2018 16:39:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28552 invoked by uid 111); 11 Aug 2018 16:39:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 11 Aug 2018 12:39:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 11 Aug 2018 12:39:55 -0400
Date:   Sat, 11 Aug 2018 12:39:55 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Paul Smith <paul@mad-scientist.net>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Help with "fatal: unable to read ...." error during GC?
Message-ID: <20180811163954.GA27393@sigill.intra.peff.net>
References: <1b2f649f0ece2ff46801c7bbd971c736e257af83.camel@mad-scientist.net>
 <20180808160612.GC1607@sigill.intra.peff.net>
 <b247434b62ccd30f32adbebb83fa6ea12b51b6ff.camel@mad-scientist.net>
 <20180808182436.GA19096@sigill.intra.peff.net>
 <be46349efde84f158b80e96f2fbbcf4304a71208.camel@mad-scientist.net>
 <20180811142341.GA17605@sigill.intra.peff.net>
 <20180811142527.GB17605@sigill.intra.peff.net>
 <CACsJy8DE+V3GK0f3fDAtjseLYU_5Ct3V0RHxs3N=aNmA0hO3cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8DE+V3GK0f3fDAtjseLYU_5Ct3V0RHxs3N=aNmA0hO3cw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 11, 2018 at 04:38:00PM +0200, Duy Nguyen wrote:

> On Sat, Aug 11, 2018 at 4:25 PM Jeff King <peff@peff.net> wrote:
> > Responding myself and adding Duy to the cc to increase visibility among
> > worktree experts. :)
> 
> I do silently watch this thread (and yes I still have to fix that fsck
> thing, hit a roadblock with ref names but I should really restart it
> soon). Now you have found one more thing for me to do. Why Jeff why?
> j/k

:) I was actually thinking about doing it myself, but was worried that
the refactoring might complicate things. And it sounds from the fact
that you looked into it and hit a roadblock that it is more complicated
than I thought.

So I'll leave it for now, but I'm happy to review or discuss ideas.

-Peff
