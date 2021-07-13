Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBE7C07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 21:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 090FB61289
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 21:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235843AbhGMVSc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 17:18:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:48274 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229478AbhGMVSa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 17:18:30 -0400
Received: (qmail 12071 invoked by uid 109); 13 Jul 2021 21:15:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Jul 2021 21:15:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14126 invoked by uid 111); 13 Jul 2021 21:15:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Jul 2021 17:15:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 13 Jul 2021 17:15:39 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 6/6] strbuf.h: add a comment about "missing"
 strftime() checking
Message-ID: <YO4Ce406huQaw6Lw@coredump.intra.peff.net>
References: <cover-0.6-00000000000-20210710T084445Z-avarab@gmail.com>
 <cover-0.6-0000000000-20210713T080411Z-avarab@gmail.com>
 <patch-6.6-fe66e06754-20210713T080411Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-6.6-fe66e06754-20210713T080411Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 13, 2021 at 10:05:21AM +0200, Ævar Arnfjörð Bjarmason wrote:

> + *
> + * Note: The omission of "__attribute__((format (strftime, [...])))"
> + * is intentional. As noted above we take %z and %Z which aren't
> + * portable. It would "work" anyway on modern compilers, but since
> + * this is mainly used in date.c (via"git log --date=<format>") we
> + * don't have any constant formats to check.

Missing whitespace after "via" here.

-Peff
