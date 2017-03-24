Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F27721FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 15:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965617AbdCXPxI (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 11:53:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:51042 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935237AbdCXPxG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 11:53:06 -0400
Received: (qmail 10242 invoked by uid 109); 24 Mar 2017 15:52:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Mar 2017 15:52:31 +0000
Received: (qmail 3093 invoked by uid 111); 24 Mar 2017 15:52:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Mar 2017 11:52:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Mar 2017 11:52:29 -0400
Date:   Fri, 24 Mar 2017 11:52:29 -0400
From:   Jeff King <peff@peff.net>
To:     Joan Aguilar <joan.aguilar.lorente@gmail.com>
Cc:     Michael J Gruber <git@grubix.eu>, git@vger.kernel.org
Subject: Re: report on a possible bug: git commit -p myfile.py unexpected
 output
Message-ID: <20170324155229.jw7auwikq6gig7cv@sigill.intra.peff.net>
References: <CAG+Y4s8m2MqA0yAiZFzv2bAx7g5xktNRb=S-Ej0tvMwU-Un0Og@mail.gmail.com>
 <26915be5-8749-7f66-4d60-516e7ed60adc@grubix.eu>
 <20170324150921.vwh4yqpz25ph3zxe@sigill.intra.peff.net>
 <CAG+Y4s8WGwmP7uOsNz4GkR3tsaeB2e1qBysrs-4pqLBKYC+Grg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG+Y4s8WGwmP7uOsNz4GkR3tsaeB2e1qBysrs-4pqLBKYC+Grg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 24, 2017 at 04:31:09PM +0100, Joan Aguilar wrote:

> Thank you! I learned a little bit about git. And most of all, I
> realize there are a lot of options and flags I am not aware of, and
> not using at all! I have to read the documentation. I am missing a lot
> of git!!
> 
> I am sorry that I reported this as possible bug. I guess I was just
> confused because the "standard behavior" of "git commit" differs from
> the one of "tig" or "git show".

No problem. Thanks for a thorough report; it was easy to see what the
problem was from reading it.

-Peff
