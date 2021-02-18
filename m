Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E05EC433E6
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 20:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4479D64E0F
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 20:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbhBRUAo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 15:00:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:38042 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231337AbhBRT6b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 14:58:31 -0500
Received: (qmail 28556 invoked by uid 109); 18 Feb 2021 19:57:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 18 Feb 2021 19:57:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23927 invoked by uid 111); 18 Feb 2021 19:57:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 18 Feb 2021 14:57:46 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 18 Feb 2021 14:57:46 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 00/14] fsck: API improvements
Message-ID: <YC7GupBLb4IoDLj6@coredump.intra.peff.net>
References: <87blcja2ha.fsf@evledraar.gmail.com>
 <20210217194246.25342-1-avarab@gmail.com>
 <xmqqo8gijtl7.fsf@gitster.g>
 <87zh028ctp.fsf@evledraar.gmail.com>
 <xmqqtuq9faw5.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqtuq9faw5.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 18, 2021 at 11:12:26AM -0800, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> 
> >> Let's get this reviewed now, but with expectation that it will be
> >> rebased after the dust settles.
> >
> > Makes sense. Pending a review of this would you be interested in queuing
> > a v2 of this that doesn't conflict with in-flight topics?
> 
> Not really.  I am not sure your recent patches are getting
> sufficient review bandwidth they deserve.

FWIW, I just read through v2 (without having looked at all at v1 yet!),
and they all seemed like quite reasonable cleanups. I left a few small
comments that might be worth a quick re-roll, but I would also be OK
with the patches being picked up as-is.

-Peff
