Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F1BC433B4
	for <git@archiver.kernel.org>; Mon,  3 May 2021 14:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 780B1611CB
	for <git@archiver.kernel.org>; Mon,  3 May 2021 14:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhECOys (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 10:54:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:43148 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229757AbhECOys (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 10:54:48 -0400
Received: (qmail 6051 invoked by uid 109); 3 May 2021 14:53:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 May 2021 14:53:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4328 invoked by uid 111); 3 May 2021 14:53:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 May 2021 10:53:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 May 2021 10:53:54 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Yiyuan guo <yguoaz@gmail.com>
Subject: Re: [PATCH 1/5] t5300: modernize basic tests
Message-ID: <YJAOgrZVt2oSGCfw@coredump.intra.peff.net>
References: <YI1fbERSuS7Y3LKh@coredump.intra.peff.net>
 <YI1fk3nE6AJRK8qS@coredump.intra.peff.net>
 <xmqqk0og8k09.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk0og8k09.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 03, 2021 at 02:27:18PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The first set of tests in t5300 goes back to 2005, and doesn't use some
> > of our customary style and tools these days. In preparation for touching
> > them, let's modernize a few things:
> > ...
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> >  t/t5300-pack-object.sh | 243 ++++++++++++++---------------------------
> >  1 file changed, 85 insertions(+), 158 deletions(-)
> 
> Thanks.  That was an impressive list of a "few" things ;-)  The
> result certainly is much easier to follow.

Sometimes these things get bigger than you expected. :)

-Peff
