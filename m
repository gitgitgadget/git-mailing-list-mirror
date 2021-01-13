Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1572C433DB
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 17:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD24F2337F
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 17:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbhAMR4N (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 12:56:13 -0500
Received: from cloud.peff.net ([104.130.231.41]:54968 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728087AbhAMR4N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 12:56:13 -0500
Received: (qmail 24681 invoked by uid 109); 13 Jan 2021 17:55:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 13 Jan 2021 17:55:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 725 invoked by uid 111); 13 Jan 2021 17:55:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 13 Jan 2021 12:55:33 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 13 Jan 2021 12:55:32 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] CoC: update to version 2.0 + local changes
Message-ID: <X/80FBlnrTlykI4B@coredump.intra.peff.net>
References: <xmqqzh1dxmlo.fsf@gitster.c.googlers.com>
 <xmqqr1mpxl4q.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqr1mpxl4q.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 13, 2021 at 01:05:09AM -0800, Junio C Hamano wrote:

> > Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> > Acked-by: Christian Couder <chriscool@tuxfamily.org>
> > Acked-by: Derrick Stolee <dstolee@microsoft.com>
> > Acked-by: Elijah Newren <newren@gmail.com>
> > Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > Acked-by: Jonathan Nieder <jrnieder@gmail.com>
> > Acked-by: brian m. carlson <sandals@crustytoothpaste.net>
> > Signed-off-by: Junio C Hamano <gitster@pobox.com>
> > ---
> 
> I guess I should lead by an example ;-)  The above misses mine and
> Signed-off-by means a totally different thing [*1*] from Acked-by.
> 
>     Acked-by: Junio C Hamano <gitster@pobox.com>

I thought your "From" would be enough, but I see this re-wrapped version
if "From: Ævar" (so I guess my same argument applies for him ;) ).

Thanks for reposting this; I was trying hard not to look at my email
during the week of the original thread.

I agree with the sentiment expressed earlier that the "consequences" are
a little funny for us, since our decentralized infrastructure makes
things like banning a bit confusing. But that was already present to
some degree in the older version, and I do like the notion that we'd
stick to the original as closely as possible. So:

  Acked-by: Jeff King <peff@peff.net>

-Peff
