Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EEDF2021E
	for <e@80x24.org>; Thu,  3 Nov 2016 15:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758176AbcKCPyD (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Nov 2016 11:54:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:38067 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757970AbcKCPyC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2016 11:54:02 -0400
Received: (qmail 29741 invoked by uid 109); 3 Nov 2016 15:54:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 03 Nov 2016 15:54:02 +0000
Received: (qmail 13550 invoked by uid 111); 3 Nov 2016 15:54:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 03 Nov 2016 11:54:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Nov 2016 11:54:00 -0400
Date:   Thu, 3 Nov 2016 11:54:00 -0400
From:   Jeff King <peff@peff.net>
To:     Chris Purcell <chris.purcell.39@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug in git rev-parse @{push}?
Message-ID: <20161103155400.jqzopj5i2rrlj6km@sigill.intra.peff.net>
References: <CAJUoZVYF=ZCBUX6jztwhJX3BZdq4JEfrSRbi4cFPwn+7yA=VjA@mail.gmail.com>
 <20161103151422.nhrgzivapy5tisr4@sigill.intra.peff.net>
 <CAJUoZVbnWzpjzWe_qGZTnX_6N2+OJVG39WYaBgY7OfQBNCg+rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJUoZVbnWzpjzWe_qGZTnX_6N2+OJVG39WYaBgY7OfQBNCg+rg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 03, 2016 at 03:48:50PM +0000, Chris Purcell wrote:

> Thanks, Jeff! If I remove the explicit configuration of remote.pushdefault
> = "origin", I get the same error message as you, so I suspect that's _not_
> the default.

That's really bizarre, because I get the same behavior with or without
it set. Not only that, but it shouldn't even come into play, as
branch.foo.remote should take precedence anyway.

So now I'm really puzzled.

-Peff
