Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9C6C07E9B
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 11:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15AE56101B
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 11:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237931AbhGUKnm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 06:43:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:53000 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236933AbhGUJaW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 05:30:22 -0400
Received: (qmail 1836 invoked by uid 109); 21 Jul 2021 10:03:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 21 Jul 2021 10:03:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2804 invoked by uid 111); 21 Jul 2021 10:04:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 21 Jul 2021 06:04:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 21 Jul 2021 06:04:15 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [PATCH v2 04/24] Documentation: build 'technical/bitmap-format'
 by default
Message-ID: <YPfxH9RW6QGjZlQv@coredump.intra.peff.net>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <b0bb2e8051f19ec47140fda6500e092e37c6bea8.1624314293.git.me@ttaylorr.com>
 <87bl7uzvaf.fsf@evledraar.gmail.com>
 <YO8h0smhBPuIjFAa@nand.local>
 <87eec0zej2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87eec0zej2.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 15, 2021 at 12:58:00AM +0200, Ævar Arnfjörð Bjarmason wrote:

> >> But there's still (but maybe later in this series) a link to
> >> bitmap-format anywhere from another manual page (but there is for
> >> e.g. technical/pack-format.html).
> >
> > No, I didn't add any links pointed at bitmap-format.
> 
> I see https://git-scm.com/docs/bitmap-format has somehow managed to get
> indexed by Google, perhaps through some magic :)

Presumably somebody somewhere mentioned it (if not, the list archive now
links to it ;) ).

The git-scm.com site doesn't use our Documentation/Makefile, so it has
been building the bitmap-format page for a while. It doesn't look
correct, though (it is missing everything before the "on-disk format"
section).

-Peff
