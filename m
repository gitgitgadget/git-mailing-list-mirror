Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECDDC433E0
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 09:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA0B661934
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 09:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235749AbhC2JRB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 05:17:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:35220 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233157AbhC2JQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 05:16:58 -0400
Received: (qmail 9527 invoked by uid 109); 29 Mar 2021 09:16:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 29 Mar 2021 09:16:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11573 invoked by uid 111); 29 Mar 2021 09:16:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 29 Mar 2021 05:16:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 29 Mar 2021 05:16:55 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/7] object tests: add test for unexpected objects in tags
Message-ID: <YGGbBz+TXJfLV8VC@coredump.intra.peff.net>
References: <Pine.LNX.4.21.0506212033590.30848-100000@iabervon.org>
 <20210308200426.21824-7-avarab@gmail.com>
 <YEdRhulqevMjlrLc@coredump.intra.peff.net>
 <87h7kwnjpp.fsf@evledraar.gmail.com>
 <YGBHH7sAVsPpVKWd@coredump.intra.peff.net>
 <8735wfnv7i.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8735wfnv7i.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 28, 2021 at 05:39:45PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > I thought the "blind spot" you meant was not testing these cases. But I
> > guess you mean that we are not checking stderr.
> >
> > So OK, but...
> 
> Ah yes. I'll clarify that. I thought it was clear since the series is
> about the output we emit on errors, not the rev-list traversal itself.

TBH, I think it was as much a reading comprehension fail on my part. But
it certainly doesn't hurt to make the commit message more clear.

-Peff
