Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D2B32027B
	for <e@80x24.org>; Thu,  2 Mar 2017 07:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754218AbdCBHhh (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 02:37:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:36975 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754058AbdCBHhM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 02:37:12 -0500
Received: (qmail 19701 invoked by uid 109); 2 Mar 2017 07:37:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Mar 2017 07:37:10 +0000
Received: (qmail 14447 invoked by uid 111); 2 Mar 2017 07:37:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Mar 2017 02:37:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Mar 2017 02:37:09 -0500
Date:   Thu, 2 Mar 2017 02:37:09 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] README: create HTTP/HTTPS links from URLs in Markdown
Message-ID: <20170302073708.dxm4p24pt6zlqjuz@sigill.intra.peff.net>
References: <20170301222204.GA5413@whir>
 <20170302071810.pbczh3p4w4bnyqzg@sigill.intra.peff.net>
 <20170302073421.GA2528@whir>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170302073421.GA2528@whir>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 02, 2017 at 07:34:21AM +0000, Eric Wong wrote:

> Jeff King <peff@peff.net> wrote:
> > On Wed, Mar 01, 2017 at 10:22:04PM +0000, Eric Wong wrote:
> > 
> > > Markdown supports automatic links by surrounding URLs with
> > > angle brackets, as documented in
> > > <https://daringfireball.net/projects/markdown/syntax#autolink>
> > 
> > One of the joys of markdown is that there are so many variants. A lot of
> > them (including GitHub-flavored markdown) will linkify URLs even when
> > they're not inside angle brackets.
> > 
> > So I don't mind this patch, but I'm curious what's rendering the
> > markdown you're seeing. I'd think online that one would either come
> > across the raw text, or the GFM from https://github.com/git/git.
> 
> I was using Gruber's reference implementation from Debian stable
> (1.0.1-7).

OK. I guess my question more was "why are you doing that?". I'd expect
people to find the GFM rendering on GitHub, or just look at the text via
"less".

But it's not really my business why you would want to do it. :) It's
reasonable for us to cater to the common subset of renderers.

-Peff
