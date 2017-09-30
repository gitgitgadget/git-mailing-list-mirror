Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9859720A10
	for <e@80x24.org>; Sat, 30 Sep 2017 07:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751289AbdI3HBb (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Sep 2017 03:01:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:55332 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751178AbdI3HBa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Sep 2017 03:01:30 -0400
Received: (qmail 9181 invoked by uid 109); 30 Sep 2017 07:01:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 30 Sep 2017 07:01:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11404 invoked by uid 111); 30 Sep 2017 07:02:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sat, 30 Sep 2017 03:02:10 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 30 Sep 2017 03:01:28 -0400
Date:   Sat, 30 Sep 2017 03:01:28 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 2/5] t6300: refactor %(trailers) tests
Message-ID: <20170930070127.xvtn7dfyuoh26mhp@sigill.intra.peff.net>
References: <20170930062238.87077-1-me@ttaylorr.com>
 <20170930062238.87077-3-me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170930062238.87077-3-me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 29, 2017 at 11:22:35PM -0700, Taylor Blau wrote:

> We currently have one test for %(trailers) in `git-for-each-ref(1)`, through
> "%(contents:trailers)". In preparation for more, let's add a few things:
> 
>   - Move the commit creation step to its own test so that it can be re-used.
> 
>   - Add a non-trailer to the commit's trailers to test that non-trailers aren't
>     shown using "%(trailers:only)".
> 
>   - Add a multi-line trailer to ensure that trailers are unfolded correctly
>     using "%(trailers:unfold)".

This is a minor nit, but since you invited formatting critique in your
cover letter, I feel entitled. :)

Consider wrapping your commit messages (and emails in general) at
72 characters, rather than 80. That lets them show well on an 80-column
display even when indented by "git log" or by inline quoting in an email
reply.

I'm also of the opinion that while 80 characters is fine for code, it's
a bit wide for English text. You can find various claims online[1] from
people interested in typography that a line width of about 60-70
characters is pleasant for reading.

[1] E.g., https://baymard.com/blog/line-length-readability

> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  t/t6300-for-each-ref.sh | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

The patch itself looks fine. :)

-Peff
