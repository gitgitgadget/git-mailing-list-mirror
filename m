Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A70EC433E0
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 20:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F234622CA1
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 20:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgHEUeg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:34:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:49594 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727928AbgHEUe1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 16:34:27 -0400
Received: (qmail 15341 invoked by uid 109); 5 Aug 2020 20:34:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 05 Aug 2020 20:34:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27290 invoked by uid 111); 5 Aug 2020 20:34:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 05 Aug 2020 16:34:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 5 Aug 2020 16:34:25 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: avoiding fetching specific refs from a remote
Message-ID: <20200805203425.GA2706898@coredump.intra.peff.net>
References: <CA+P7+xpokJ3Z4xZ9ibCBpBO65D1v-AD6_JknprGUsEDxEvMGGw@mail.gmail.com>
 <20200805063704.GA2690083@coredump.intra.peff.net>
 <xmqq1rkloyeg.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1rkloyeg.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 05, 2020 at 09:22:47AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> Essentially, because both main and master have similar names, tab
> >> completion requires remembering to type one additional character than
> >> I am used to.
> >
> > Heh, I didn't think anybody considered that implication so far; the fact
> > that they were similar names has generally been considered a positive. I
> > agree it would be annoying.
> 
> FWIW, I've been saying that 'maint' will become harder to type all
> along ever since I heard 'main'.
> 
> https://lore.kernel.org/git/xmqqtuz9tq30.fsf@gitster.c.googlers.com/

True, but I thought that was just a reason against "main" in git.git
itself. Most repos don't have "maint" (and we already conflicted on "ma"
with the existing name :) though I agree that having one as a prefix of
the other makes completion doubly painful). The interesting bit here is
that the old name probably _isn't_ going away immediately, so this would
affect everybody.

-Peff
