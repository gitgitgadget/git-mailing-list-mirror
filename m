Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4EBC2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 03:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9969239A1
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 03:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgI1DRy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Sep 2020 23:17:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:42862 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbgI1DRy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Sep 2020 23:17:54 -0400
Received: (qmail 2600 invoked by uid 109); 28 Sep 2020 03:17:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 28 Sep 2020 03:17:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3599 invoked by uid 111); 28 Sep 2020 03:17:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 27 Sep 2020 23:17:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 27 Sep 2020 23:17:52 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Subject: Re: [PATCH v2 4/8] shortlog: match commit trailers with --group
Message-ID: <20200928031752.GA3059492@coredump.intra.peff.net>
References: <20200927083933.GA2222823@coredump.intra.peff.net>
 <20200927084004.GD2465761@coredump.intra.peff.net>
 <xmqqlfgvngkw.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlfgvngkw.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 27, 2020 at 12:51:43PM -0700, Junio C Hamano wrote:

> > +The contents of each trailer value are taken literally and completely.
> > +No mailmap is applied, and the `-e` option has no effect (if the trailer
> > +contains a username and email, they are both always shown).
> 
> OK.  Some users may find that not quite satisfying, though.
> 
> But I have a suspicion that the above will be refined in later
> steps?  It would have been nicer to see that mentioned in the
> proposed log message (e.g. "this step gives the minimum basics and
> rough edges like X and Y will be refined with later patches").

I wondered if this might confuse people reading the series, and almost
called attention to it in the cover letter. Now that you've presumably
read through and figured it out, is it worth going back and amending the
commit message? It's more of a point for reviewers, I think, but perhaps
somebody reading the commits later would care.

-Peff
