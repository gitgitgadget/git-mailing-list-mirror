Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C2BF1F404
	for <e@80x24.org>; Fri,  9 Feb 2018 19:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752498AbeBITdW (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 14:33:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:47208 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752218AbeBITdV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 14:33:21 -0500
Received: (qmail 5717 invoked by uid 109); 9 Feb 2018 19:33:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 09 Feb 2018 19:33:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24342 invoked by uid 111); 9 Feb 2018 19:34:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 09 Feb 2018 14:34:04 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Feb 2018 14:33:19 -0500
Date:   Fri, 9 Feb 2018 14:33:19 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH] CodingGuidelines: mention "static" and "extern"
Message-ID: <20180209193319.GB15554@sigill.intra.peff.net>
References: <20180208201546.194935-1-sbeller@google.com>
 <20180208204309.GA4541@sigill.intra.peff.net>
 <CAGZ79kb+xEVZagqqNCHCPQUbfH89N7fdrO7dp6WHRGgJJje28Q@mail.gmail.com>
 <20180208213806.GA6381@sigill.intra.peff.net>
 <CAPig+cT_ddVSEvdnMTNhtxWJMm4=DLyq8-hSDXa5X0i6rXa3xA@mail.gmail.com>
 <20180209110738.edbc7a700b689db6967ec86a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180209110738.edbc7a700b689db6967ec86a@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 09, 2018 at 11:07:38AM -0800, Jonathan Tan wrote:

> On Thu, 8 Feb 2018 18:14:06 -0500
> Eric Sunshine <sunshine@sunshineco.com> wrote:
> 
> > On Thu, Feb 8, 2018 at 4:38 PM, Jeff King <peff@peff.net> wrote:
> > > Subject: [PATCH] CodingGuidelines: mention "static" and "extern"
> > > [...]
> > >
> > > Signed-off-by: Jeff King <peff@peff.net>
> > > ---
> > > diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> > > @@ -386,6 +386,11 @@ For C programs:
> > > + - Variables and functions local to a given source file should be marked
> > > +   with "static". Variables that are visible to other source files
> > > +   must be declared with "extern" in header files. However, function
> > > +   declarations should not use "extern", as that is already the default.
> > 
> > Perhaps:
> > 
> >     ... as that is already the default, unless declarations in the
> >     header are already "extern", in which case consistency
> >     may favor mirroring existing usage.
> > 
> > or something.
> 
> I would prefer not mirroring existing usage in this case - I think it's
> better if the code becomes eventually consistent in not using extern.

Agreed. I think individual bullets in CodingGuidelines should be
definitive where possible, describing the end-game we strive for.

-Peff
