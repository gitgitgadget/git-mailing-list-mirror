Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F085CC4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 13:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD8A620756
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 13:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbgJENpF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 09:45:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:49834 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbgJENpF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 09:45:05 -0400
Received: (qmail 376 invoked by uid 109); 5 Oct 2020 13:45:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 05 Oct 2020 13:45:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20013 invoked by uid 111); 5 Oct 2020 13:45:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 05 Oct 2020 09:45:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 5 Oct 2020 09:45:04 -0400
From:   Jeff King <peff@peff.net>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] parallel-checkout: drop unused checkout state parameter
Message-ID: <20201005134504.GA2910591@coredump.intra.peff.net>
References: <cover.1600814153.git.matheus.bernardino@usp.br>
 <af0d790973b1e52da0fc9c4bed95e93d995d68da.1600814153.git.matheus.bernardino@usp.br>
 <20201005061732.GA2288306@coredump.intra.peff.net>
 <CAHd-oW5=ipx9RY_W44GFUSO=O1eDwWirfrjJfpv-xy8yqe6L4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHd-oW5=ipx9RY_W44GFUSO=O1eDwWirfrjJfpv-xy8yqe6L4w@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 05, 2020 at 10:13:21AM -0300, Matheus Tavares Bernardino wrote:

> I was going to suggest squashing this into fa33dd99f0, but I noticed
> that mt/parallel-checkout-part-1 is already in next. We don't re-roll
> series that are already in next, right?

Correct. That's also why I noticed it; I build my day-to-day Git by
integrating next with my personal topics, and one of my topics turns on
-Wunused-parameter. :)

-Peff
