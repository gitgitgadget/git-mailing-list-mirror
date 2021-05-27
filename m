Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5551CC4708B
	for <git@archiver.kernel.org>; Thu, 27 May 2021 14:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A820613DE
	for <git@archiver.kernel.org>; Thu, 27 May 2021 14:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236383AbhE0OeC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 10:34:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:38818 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235925AbhE0OeB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 10:34:01 -0400
Received: (qmail 4858 invoked by uid 109); 27 May 2021 14:32:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 27 May 2021 14:32:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3329 invoked by uid 111); 27 May 2021 14:32:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 27 May 2021 10:32:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 27 May 2021 10:32:27 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 0/5] doc: asciidoc cleanups
Message-ID: <YK+texFSW6UurDui@coredump.intra.peff.net>
References: <20210521222941.525901-1-felipe.contreras@gmail.com>
 <xmqq7djoj9z9.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7djoj9z9.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 25, 2021 at 02:51:54AM +0900, Junio C Hamano wrote:

> >  Documentation/Makefile | 77 ++++++++++++++++--------------------------
> >  1 file changed, 29 insertions(+), 48 deletions(-)
> 
> Is this satisfactory to everybody (I haven't taken a look beyond
> comparing the end results)?

Yes, all five patches look good to me.

The "comments-by" sub-thread looked unproductive to me, so I mostly
skipped it. ;) But as the person whose name was in the trailer, I will
say that I do not care either way if it is included. It did not seem to
add anything to me. Some trailers are good for pointing later readers to
folks who may be able to help understand or debug an old commit. Some
are good for just giving credit to people who helped. "Comments-by"
didn't really seem to do either to me (and I don't feel like I
contributed much worthy of credit anyway).

-Peff
