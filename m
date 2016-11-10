Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8327120229
	for <e@80x24.org>; Thu, 10 Nov 2016 23:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934559AbcKJXGI (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 18:06:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:41438 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933993AbcKJXGH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 18:06:07 -0500
Received: (qmail 17627 invoked by uid 109); 10 Nov 2016 23:06:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 10 Nov 2016 23:06:07 +0000
Received: (qmail 9267 invoked by uid 111); 10 Nov 2016 23:06:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 10 Nov 2016 18:06:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Nov 2016 18:06:05 -0500
Date:   Thu, 10 Nov 2016 18:06:05 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kristoffer Haugsbakk <kristoffer.haugsbakk@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] doc: fill in omitted word
Message-ID: <20161110230605.pwgzhai6xhud7pnu@sigill.intra.peff.net>
References: <20161104214357.32477-1-kristoffer.haugsbakk@gmail.com>
 <xmqqd1i356ql.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd1i356ql.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 10, 2016 at 02:07:30PM -0800, Junio C Hamano wrote:

> Kristoffer Haugsbakk <kristoffer.haugsbakk@gmail.com> writes:
> 
> > Signed-off-by: Kristoffer Haugsbakk <kristoffer.haugsbakk@gmail.com>
> > ---
> >  Documentation/gitcore-tutorial.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
> > index 4546fa0..9860517 100644
> > --- a/Documentation/gitcore-tutorial.txt
> > +++ b/Documentation/gitcore-tutorial.txt
> > @@ -25,7 +25,7 @@ you want to understand Git's internals.
> >  The core Git is often called "plumbing", with the prettier user
> >  interfaces on top of it called "porcelain". You may not want to use the
> >  plumbing directly very often, but it can be good to know what the
> > -plumbing does for when the porcelain isn't flushing.
> > +plumbing does for you when the porcelain isn't flushing.
> 
> I need an English teacher here to help me out, but I think this
> changes the meaning of the sentence from what the original author
> intended..

It does. I'd take the original to mean "for the case when", which is
correct (though as you note, just dropping "for" says the same thing
more succinctly).

-Peff
