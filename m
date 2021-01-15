Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EA2C433E9
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 09:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 799E523436
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 09:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbhAOJeD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 04:34:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:57016 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbhAOJeD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 04:34:03 -0500
Received: (qmail 32433 invoked by uid 109); 15 Jan 2021 09:33:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 15 Jan 2021 09:33:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25773 invoked by uid 111); 15 Jan 2021 09:33:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 Jan 2021 04:33:32 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 15 Jan 2021 04:33:29 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, jrnieder@gmail.com
Subject: Re: [PATCH v2 00/20] pack-revindex: prepare for on-disk reverse index
Message-ID: <YAFhaeO0TeKw0G7q@coredump.intra.peff.net>
References: <cover.1610129796.git.me@ttaylorr.com>
 <cover.1610576604.git.me@ttaylorr.com>
 <YACgyn029KBps/yx@coredump.intra.peff.net>
 <xmqqr1mnw88w.fsf@gitster.c.googlers.com>
 <YAFhMmEjk97sp7Dx@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YAFhMmEjk97sp7Dx@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 15, 2021 at 04:32:34AM -0500, Jeff King wrote:

> On Thu, Jan 14, 2021 at 12:53:19PM -0800, Junio C Hamano wrote:
> 
> > Jeff King <peff@peff.net> writes:
> > 
> > > On Wed, Jan 13, 2021 at 05:23:25PM -0500, Taylor Blau wrote:
> > >
> > >> In this revision, I addressed feedback from Junio, Peff, and Stolee. A
> > >> range-diff is included below, but the main changes are:
> > >> 
> > >>   - Error messages are improved to include the pack and offset when applicable.
> > >>   - Variable names were made clearer (e.g., n -> index_pos).
> > >>   - Comments were added in pack-revindex.h to introduce relevant terminology,
> > >>     and which methods convert between what orderings.
> > >>   - int-sized lower- and upper-bounds were converted to be unsigned.
> > >
> > > Thanks, this addresses all of my nits. I responded to a few of Junio's
> > > reviews with some further comments/suggestions; the most interesting one
> > > is using "index_pos" to indicate the ordering more clearly in patch 15.
> > > I'm happy with or without including that.
> > 
> > I think it is better to leave it for future "clean-up" outside the
> > series, to be done after the series hits a released version.
> 
> OK. I'll hold on to it and re-send it after the area has settled.

Oh, nevermind, you said elsewhere you'd pick it up as 21/20. Assuming
you do that, I won't resend it. :)

-Peff
