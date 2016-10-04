Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DCFB20986
	for <e@80x24.org>; Tue,  4 Oct 2016 13:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752375AbcJDNlZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 09:41:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:51988 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750908AbcJDNlY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 09:41:24 -0400
Received: (qmail 21258 invoked by uid 109); 4 Oct 2016 13:41:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Oct 2016 13:41:22 +0000
Received: (qmail 4884 invoked by uid 111); 4 Oct 2016 13:41:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Oct 2016 09:41:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Oct 2016 09:41:20 -0400
Date:   Tue, 4 Oct 2016 09:41:20 -0400
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 0/18] alternate object database cleanups
Message-ID: <20161004134120.aj6oywkiy4li7aeh@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
 <CA+P7+xob7ohj1MxuLGGLwwJyi4RfqUTeLkbw86u+VvbU=uEyAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xob7ohj1MxuLGGLwwJyi4RfqUTeLkbw86u+VvbU=uEyAw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 03, 2016 at 10:47:31PM -0700, Jacob Keller wrote:

> > The number of patches is a little intimidating, but I tried hard to
> > break the refactoring down into a sequence of obviously-correct steps.
> > You can be the judge of my success.
> 
> I read through them once. I'm going to re-read through them again and
> leave any comments I had.

Thanks for having the fortitude to read them all. :) After looking at
your comments, I don't _think_ there's anything that necessitates a
re-roll, but I'll respond to a few of them individually.

-Peff
