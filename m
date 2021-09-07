Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C353C433EF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 19:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E721610C8
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 19:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346046AbhIGTXa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 15:23:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:40942 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346038AbhIGTX3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 15:23:29 -0400
Received: (qmail 20196 invoked by uid 109); 7 Sep 2021 19:22:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Sep 2021 19:22:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17145 invoked by uid 111); 7 Sep 2021 19:22:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Sep 2021 15:22:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 7 Sep 2021 15:22:21 -0400
From:   Jeff King <peff@peff.net>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: expired key in junio-gpg-pub
Message-ID: <YTe77RPYavw9HAfZ@coredump.intra.peff.net>
References: <YTerpXCxYx+f+8ws@coredump.intra.peff.net>
 <20210907182042.3ugoaicjt4e3h4fp@meerkat.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210907182042.3ugoaicjt4e3h4fp@meerkat.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 07, 2021 at 02:20:42PM -0400, Konstantin Ryabitsev wrote:

> On Tue, Sep 07, 2021 at 02:12:53PM -0400, Jeff King wrote:
> > Have you extended the expiration on it? I wasn't able to find any
> > updates on the keyservers I checked. But regardless, we should probably
> > ship an updated one via the tag.
> 
> You can get it from here:
> https://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git/plain/keys/20D04E5A713660A7.asc

Thanks! That fixes my problem. I do think we should update the in-repo
tag. :)

-Peff
