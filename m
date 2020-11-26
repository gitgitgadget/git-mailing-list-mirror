Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108C8C56202
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 00:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C68A720770
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 00:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbgKZAm7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 19:42:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:43188 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726719AbgKZAm7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 19:42:59 -0500
Received: (qmail 12326 invoked by uid 109); 26 Nov 2020 00:42:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 26 Nov 2020 00:42:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12245 invoked by uid 111); 26 Nov 2020 00:42:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 25 Nov 2020 19:42:58 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 25 Nov 2020 19:42:58 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        szeder.dev@gmail.com
Subject: Re: [PATCH v4 0/4] update-ref: allow creation of multiple
 transactions
Message-ID: <X776EmARaq3QXRS3@coredump.intra.peff.net>
References: <cover.1604501265.git.ps@pks.im>
 <cover.1605254957.git.ps@pks.im>
 <xmqqh7pdcbb1.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh7pdcbb1.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 25, 2020 at 02:37:54PM -0800, Junio C Hamano wrote:

> Patrick Steinhardt <ps@pks.im> writes:
> 
> > this is the fourth version of this patch series implementing support for
> > creation of multiple reference transactions in a single git-update-ref
> > process.
> 
> It is my impression that the series is now in good enough shape that
> we didn't see much discussion on this round.
> 
> So I'll mark this to be merged to 'next', but I ask reviewers to
> please holler to stop me otherwise.

Yeah, this looks good to me for advancing. Thanks.

-Peff
