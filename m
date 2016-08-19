Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8733D203BD
	for <e@80x24.org>; Fri, 19 Aug 2016 15:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932392AbcHSPFE (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 11:05:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:58153 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754186AbcHSPEw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 11:04:52 -0400
Received: (qmail 3566 invoked by uid 109); 19 Aug 2016 15:03:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Aug 2016 15:03:43 +0000
Received: (qmail 26253 invoked by uid 111); 19 Aug 2016 15:03:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Aug 2016 11:03:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Aug 2016 11:03:40 -0400
Date:   Fri, 19 Aug 2016 11:03:40 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Stefan Beller <sbeller@google.com>, meta@public-inbox.org,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Eric Wong <e@80x24.org>
Subject: Re: Working with public-inbox.org [Was: [PATCH] rev-parse: respect
 core.hooksPath in --git-path]
Message-ID: <20160819150340.725bejnps6474u2e@sigill.intra.peff.net>
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com>
 <alpine.DEB.2.20.1608181430280.4924@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1608181430280.4924@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 18, 2016 at 02:42:34PM +0200, Johannes Schindelin wrote:

> BTW I take this thread as yet another proof that people are unhappy with
> mail list-based review: if you have to build *that much* tooling around it
> (and Peff & Junio certainly have a megaton of advanced and sophisticated
> tooling around it, holy cow!) it is really incorrect to state that the
> mail list-driven approach works for you. It is much closer to the truth to
> say that the mail-list-plus-loads-of-custom-tools-driven approach works
> for you.
> 
> I am really not a fan of this.
> 
> The theory "it's inclusive because everyone has access to mail" falls on
> its face, badly, when even old timers have to build entire infrastructures
> around it just to begin to be able to use it efficiently.
> 
> It reminds me of an old software developer I met long ago, who claimed CVS
> works for him. He had written tens of thousands of lines of shell scripts,
> is what allowed "CVS" to work for him.
> 
> Same here. Old dogs claim the mail list-approach works for them. Nope.
> Doesn't. Else you would not have written all those custom scripts.

I read this over, didn't agree, waited a whole day for perspective, and
still just can't agree. So now I'm responding. :)

There is nothing wrong with building tooling around your workflow. If we
had a GitHub-based workflow, I'd build tooling around that, too. One of
the things I _like_ about a mail-based workflow is how easy it is to
build that tooling, and to get it to integrate with other existing
tools. It's the major reason I'm resistant to moving development to
GitHub. Not only would I have to throw away all of my tools, but I'm not
sure I could easily build equivalent ones.

Now, I am perfectly open to the idea that more of the tooling should be
standardized, so people do not have to build their own. But the major
problem there is that so much of what I've built is about gluing things
together for the rest of _my_ tools. I've shared my techniques and
scripts for using mutt several times, but they don't do somebody a lick
of good if they are using gmail or thunderbird.

So I don't really think I have a megaton of tooling. I just have a
little bit of glue to existing tools I was using anyway. And I think
that is where the disconnect is. If you are not using mutt already, then
it sure seems like a big jump to change your MUA. And I'm sympathetic to
that. But I don't think that means that the mailing-list approach is not
working for me, as you claim in the last paragraph.

-Peff

PS There _are_ some open questions in our workflow that are not really
   mailing list specific. E.g., the fact that it is hard to see whether
   and if your patch was picked up by Junio, what changes were made,
   tracking multiple versions, etc. I _don't_ have good tooling for
   that, but it's something that could be made generally available, as
   it's unrelated to the MUA. It's also not necessarily specific to
   mailing list development (e.g., a push-based workflow that
   aggressively rebases runs into the same versioning questions).
