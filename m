Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0173BC433EF
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 14:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1848613A3
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 14:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235992AbhKSOoh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 09:44:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:34874 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232249AbhKSOog (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 09:44:36 -0500
Received: (qmail 8288 invoked by uid 109); 19 Nov 2021 14:41:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Nov 2021 14:41:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13089 invoked by uid 111); 19 Nov 2021 14:41:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Nov 2021 09:41:34 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 19 Nov 2021 09:41:33 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] json-writer.[ch]: remove unused formatting functions
Message-ID: <YZe3nRLPV4FrzbDq@coredump.intra.peff.net>
References: <cover-0.6-00000000000-20211119T124420Z-avarab@gmail.com>
 <patch-6.6-e14ee1f8c47-20211119T124420Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-6.6-e14ee1f8c47-20211119T124420Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 19, 2021 at 01:46:26PM +0100, Ævar Arnfjörð Bjarmason wrote:

> These were added in 75459410edd (json_writer: new routines to create
> JSON data, 2018-07-13) for future use with trace2, but have not been
> used by anything. These are easy enough to bring back should we need
> them, but until then there's no point in carrying them.

This is another one where I could _imagine_ somebody using these in a
custom patch or topic in flight (though I don't have any such case
myself). And they complete the json-writer API, so keeping them is not
that ugly.

But I'm also OK with dropping them under the notion of cleanliness, and
that they're easy-ish to resurrect.

-Peff
