Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91A9820989
	for <e@80x24.org>; Mon, 10 Oct 2016 18:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752421AbcJJS0s (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 14:26:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:55213 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752216AbcJJS0r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 14:26:47 -0400
Received: (qmail 7567 invoked by uid 109); 10 Oct 2016 18:26:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Oct 2016 18:26:25 +0000
Received: (qmail 484 invoked by uid 111); 10 Oct 2016 18:26:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Oct 2016 14:26:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Oct 2016 14:26:23 -0400
Date:   Mon, 10 Oct 2016 14:26:23 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org
Subject: Re: [PATCH] clean up confusing suggestion for commit references
Message-ID: <20161010182623.hsczlsfc6oaa2byj@sigill.intra.peff.net>
References: <20161007095638.GA55445@book.hvoigt.net>
 <20161007143200.qw77pdsymbdmjhbw@sigill.intra.peff.net>
 <xmqqh98kf4fy.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh98kf4fy.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2016 at 11:24:01AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Fri, Oct 07, 2016 at 11:56:38AM +0200, Heiko Voigt wrote:
> >
> >> The description for referencing commits looks as if it is contradicting
> >> the example, since it is itself enclosed in double quotes. Lets use
> >> single quotes around the description and include the double quotes in
> >> the description so it matches the example.
> >> ---
> >> Sorry for opening this up again but I just looked up the format and was
> >> like: "Umm, which one is now the correct one..."
> >> 
> >> For this makes more sense. What do others think?
> >
> > Looking over the threads, I wasn't sure there was consensus[1,2]. So it would
> > be equally correct to drop the quotes from the example.
> >
> > I dunno. I am in favor of no-quotes, myself, so maybe I am just
> > manufacturing dissent in my mind. :)
> 
> I no longer have preference either way myself, even though I was in
> favor of no-quotes simply because I had an alias to produce that
> format and was used to it.

I'll admit that I don't care _that_ much and am happy to leave it up to
individual authors, as long as nobody quotes SubmittingPatches at me as
some kind of gospel when I use the no-quotes form.

-Peff
