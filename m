Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4E9C2B9F4
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 00:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72DCC60FE6
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 00:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbhFRA3x (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 20:29:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:59656 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231431AbhFRA3w (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 20:29:52 -0400
Received: (qmail 22802 invoked by uid 109); 18 Jun 2021 00:27:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 18 Jun 2021 00:27:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10827 invoked by uid 111); 18 Jun 2021 00:27:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 17 Jun 2021 20:27:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 17 Jun 2021 20:27:42 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2021, #06; Thu, 17)
Message-ID: <YMvofq5aSryQzpZQ@coredump.intra.peff.net>
References: <xmqqr1h1mc81.fsf@gitster.g>
 <YMvhoXVBoO08ziI1@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YMvhoXVBoO08ziI1@camp.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 17, 2021 at 11:58:25PM +0000, brian m. carlson wrote:

> On 2021-06-17 at 02:55:26, Junio C Hamano wrote:
> > * bc/doc-asciidoctor-to-man-wo-xmlto (2021-05-14) 2 commits
> >  - doc: remove GNU_ROFF option
> >  - doc: add an option to have Asciidoctor build man pages directly
> > 
> >  An option to render the manual pages via AsciiDoctor bypassing
> >  xmlto has been introduced.
> > 
> >  What is the status of this one?
> 
> Probably best to drop it.  I think Felipe didn't want his sign-off on
> it, and I don't think there's a good way to produce an equivalent patch
> without incorporating his changes.  We don't seem to see eye to eye on
> an appropriate solution to the problem, and I don't feel like arguing
> about it further.

Hmm. I'm not sure if that's a good resolution here. I do think many
people were positive in moving in that direction. If there's a
contributor that people have trouble working with, I'm OK giving up on
possible contributions they could make, even adaptations of their work.

But if by working in an area they poison it for others (because there's
no desire to work with them, but no desire to step on their toes) that
doesn't seem like a workable long-term strategy.

I don't think this topic is particularly urgent, so I'm OK to drop it
for now (and as always, it's your choice what you work on). But I'm
worried about the general precedent / principle.

-Peff
