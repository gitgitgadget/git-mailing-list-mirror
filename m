Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B022C83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 21:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C65C20737
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 21:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgD1V6R (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:58:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:43184 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726284AbgD1V6R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 17:58:17 -0400
Received: (qmail 24138 invoked by uid 109); 28 Apr 2020 21:58:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 28 Apr 2020 21:58:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7891 invoked by uid 111); 28 Apr 2020 22:09:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Apr 2020 18:09:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Apr 2020 17:58:15 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        dstolee@microsoft.com, mhagger@alum.mit.edu
Subject: Re: [PATCH v2 3/4] commit-graph.c: write non-split graphs as
 read-only
Message-ID: <20200428215815.GA8526@coredump.intra.peff.net>
References: <cover.1588004647.git.me@ttaylorr.com>
 <86cf29ce9c1e6dc1fc881458c18850c2893b092a.1588004647.git.me@ttaylorr.com>
 <xmqqr1w85vtq.fsf@gitster.c.googlers.com>
 <20200427235935.GA14984@syl.local>
 <20200428033438.GA2369457@coredump.intra.peff.net>
 <xmqqk11z4ksl.fsf@gitster.c.googlers.com>
 <20200428205913.GC4000@coredump.intra.peff.net>
 <xmqqd07r1fu6.fsf@gitster.c.googlers.com>
 <20200428210821.GF4000@coredump.intra.peff.net>
 <20200428214413.GA47690@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200428214413.GA47690@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 28, 2020 at 03:44:13PM -0600, Taylor Blau wrote:

> What do you want to do about the final patch that I stuck on the end of
> this series in [1]? If I don't hear from anybody, I'll send it as 5/5 in
> v3 and we can feel free to not apply it if it's controversial.

I have to admit I don't care that much either way about it (see my
earlier response on three mental models). I'm happy for you or Junio to
decide. :)

-Peff
