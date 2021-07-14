Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1DBC12002
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 22:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E27C613C9
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 22:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbhGNW0b (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 18:26:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:50140 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230361AbhGNW0b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 18:26:31 -0400
Received: (qmail 1281 invoked by uid 109); 14 Jul 2021 22:23:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Jul 2021 22:23:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28809 invoked by uid 111); 14 Jul 2021 22:23:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Jul 2021 18:23:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 14 Jul 2021 18:23:38 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        German Lashevich <german.lashevich@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] doc/git-config: explain --file instead of referring
 to GIT_CONFIG
Message-ID: <YO9j6hrJFFTSEd6j@coredump.intra.peff.net>
References: <YO9YyTZdU4WadYGg@coredump.intra.peff.net>
 <YO9ZGTX9f1fOpTkh@coredump.intra.peff.net>
 <YO9jLvGlIVj3aI/m@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YO9jLvGlIVj3aI/m@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 14, 2021 at 06:20:30PM -0400, Taylor Blau wrote:

> On Wed, Jul 14, 2021 at 05:37:29PM -0400, Jeff King wrote:
> >  -f config-file::
> >  --file config-file::
> > -	Use the given config file instead of the one specified by GIT_CONFIG.
> > +	For writing options: write to the specified file rather than the
> > +	repository `.git/config`.
> 
> I wonder whether or not we should write "rather than the repository
> `$GIT_DIR/config`" instead of `.git/config`. The former is true for bare
> repositories, too, but may in fact be more confusing than what you have
> writen so clearly.
> 
> Perhaps `.git/config` is clear enough; I definitely don't feel strongly
> about it.

Yes, I noticed that, too. This is copied verbatim from the other
options, so if we were to do that, it should be done on top across the
whole file.

-Peff
