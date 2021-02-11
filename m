Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0317EC433E6
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 11:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6DEF64E2D
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 11:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbhBKLGR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 06:06:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:57580 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229954AbhBKLB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 06:01:26 -0500
Received: (qmail 5247 invoked by uid 109); 11 Feb 2021 11:00:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 Feb 2021 11:00:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31936 invoked by uid 111); 11 Feb 2021 11:00:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Feb 2021 06:00:26 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 11 Feb 2021 06:00:26 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Kyle Meyer <kyle@kyleam.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] rev-list --disk-usage
Message-ID: <YCUOSmnsJ4LLPFgK@coredump.intra.peff.net>
References: <YBHlGPBSJC++CnPy@coredump.intra.peff.net>
 <YCJpbPIlSpCAKSBF@coredump.intra.peff.net>
 <xmqqh7mkycno.fsf@gitster.c.googlers.com>
 <YCOu70m5SKU7L4CS@coredump.intra.peff.net>
 <xmqq1rdn51gz.fsf@gitster.c.googlers.com>
 <YCREYmBsnv2wgvXZ@coredump.intra.peff.net>
 <YCRpBCNJ2yNTbc2i@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YCRpBCNJ2yNTbc2i@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 10, 2021 at 06:15:16PM -0500, Taylor Blau wrote:

> > > I kind of feel sad to have a nice write-up like this only in the
> > > list archive.  Is there a section in our documentation set to keep
> > > collection of such a real-life use cases?  Perhaps the examples
> > > section of manpages is the closest thing, but it looks a bit too
> > > narrowly scoped for the example section of "rev-list" manpage.
> >
> > Agreed on both counts. If this gets put into a release, I suspect Taylor
> > would cover it in a release blog post. That is not quite the same thing
> > as having it in the documentation, but it may provide more search engine
> > boost than the list archive. I dunno.
> 
> Yeah, this is the perfect sort of thing for those blog posts.
> 
> But it makes sense to include some of these examples in our own
> documentation here, too. git-rev-list(1) doesn't have an EXAMPLES
> section, but maybe it should.

I think this is the "narrowly scoped" bit from Junio's response above.
It would be a bit weird to have an examples section for rev-list that
only mentions this rather obscure feature.

-Peff
