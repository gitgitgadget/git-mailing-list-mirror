Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B85DC433B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 12:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75E8960FEB
	for <git@archiver.kernel.org>; Tue, 18 May 2021 12:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244872AbhERMtR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 08:49:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:57802 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245083AbhERMtM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 08:49:12 -0400
Received: (qmail 14916 invoked by uid 109); 18 May 2021 12:47:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 May 2021 12:47:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7763 invoked by uid 111); 18 May 2021 12:47:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 May 2021 08:47:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 May 2021 08:47:53 -0400
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Richard Hansen <rhansen@rhansen.org>
Subject: Re: Re* [PATCH] doc: glossary: add entry for revision range
Message-ID: <YKO3eeNPxCwvIkEw@coredump.intra.peff.net>
References: <20210516203736.1098072-1-felipe.contreras@gmail.com>
 <xmqqbl993irp.fsf@gitster.g>
 <60a245a927c62_126333208ea@natae.notmuch>
 <YKJZt4vFECoLZhc2@coredump.intra.peff.net>
 <xmqqpmxp6u13.fsf@gitster.g>
 <60a2daa57d8a6_13c370208f3@natae.notmuch>
 <YKMhqZNhamnKqWfi@coredump.intra.peff.net>
 <60a34a7616cda_14d1bc20818@natae.notmuch>
 <YKNk+5k3hKW/xPBZ@coredump.intra.peff.net>
 <60a3a808d7eeb_151987208bb@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60a3a808d7eeb_151987208bb@natae.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 18, 2021 at 06:42:00AM -0500, Felipe Contreras wrote:

> A random github.com link doesn't show anything. The instructions I'm
> talking about are the **first** thing the site gives to users.

I would think the first thing most users see is _somebody else's
repository_, full of commits, that they then clone.

> > People clone a lot more than they create new repositories.
> 
> Depends what you call "people". If you are talking about professional
> software developers, then maybe.
> 
> But they are not the only users of git.
> 
> Do you have any stats?

On one of GitHub's servers (selected randomly), there were ~300k clones
in the past 24 hours. In the same time period on the same server, there
were 1780 new repos. Even that's overstating it, since some portion of
those are just forks of existing repos (so the user probably either
cloned their fork immediately, or was already working on a clone of the
upstream fork, rather than having run "git init" locally).

> > I don't think that proves anything except that your workflow is
> > different than mine.
> 
> Exactly, and we cannot assume most people follow your workflow. In fact,
> I'd say your workflow is probably one of the most atypical in the world.
> You know tricks 99.99% of users don't know about, in fact that probably
> 99% of git.git developers don't know.
> 
> It is sufficient to acknowledge that there are different workflows.

I'm not making some bizarre claim about workflows. I'm saying that
people commonly use "git clone" to get repositories. That really doesn't
seem controversial.

But you know what, I've wasted enough time on this thread. If you want
to believe that people don't use "git clone", go for it.

-Peff
