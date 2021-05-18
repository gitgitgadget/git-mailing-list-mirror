Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA72C433ED
	for <git@archiver.kernel.org>; Tue, 18 May 2021 06:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEE2D61007
	for <git@archiver.kernel.org>; Tue, 18 May 2021 06:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240431AbhERHBL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 03:01:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:57408 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239662AbhERHBK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 03:01:10 -0400
Received: (qmail 10988 invoked by uid 109); 18 May 2021 06:59:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 May 2021 06:59:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5236 invoked by uid 111); 18 May 2021 06:59:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 May 2021 02:59:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 May 2021 02:59:52 -0400
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Richard Hansen <rhansen@rhansen.org>
Subject: Re: Re* [PATCH] doc: glossary: add entry for revision range
Message-ID: <YKNl6IAFGezjCZUf@coredump.intra.peff.net>
References: <20210516203736.1098072-1-felipe.contreras@gmail.com>
 <xmqqbl993irp.fsf@gitster.g>
 <60a245a927c62_126333208ea@natae.notmuch>
 <YKJZt4vFECoLZhc2@coredump.intra.peff.net>
 <60a2a670648b1_12801e20895@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60a2a670648b1_12801e20895@natae.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 17, 2021 at 12:22:56PM -0500, Felipe Contreras wrote:

> > > If we must not use @, then I would rather use `master..mybranch`, or
> > > something like that. HEAD seems like a technical accident. But of course
> > > I would prefer HEAD to nothing, because at least it qualifies as an
> > > ending point.
> > 
> > I agree that if the purpose is to be illustrative, using shortcuts like
> > "an empty endpoint means HEAD" is not helpful. And likewise for "@"; if
> > you need to have "revision range" defined, there is a good chance that
> > you don't know about shortcuts like "@" either.
> 
> But they don't need to know what @ means; it's clearly a shortcut for
> _something_, and that's all they need to know. In fact, I'd say most
> people can quickly realize what a shorcut for it is, which is why it was
> picked by the git project, and many Mercurial projects as well.

That's my point. It _isn't_ clearly a shortcut for something for all
people. If you are reading the glossary entry for "revision range", you
might not know about the ".." syntax at all. So what does:

  foo..@

mean? Does it parse as three (foo, .., @) or is "..@" a special symbol?

I expect most people would figure it out. But if your point is to serve
as documentation, especially for people who do not yet know all of the
concepts, then why not try to reduce the chance of error as much as
possible?

> Actually, I would prefer something more real, like "feature-x".

Sure, that is fine with me.

-Peff
