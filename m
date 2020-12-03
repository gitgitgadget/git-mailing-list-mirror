Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F751C4167B
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 18:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD66F208A9
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 18:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731727AbgLCSwG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 13:52:06 -0500
Received: from cloud.peff.net ([104.130.231.41]:50496 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731715AbgLCSwG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 13:52:06 -0500
Received: (qmail 13810 invoked by uid 109); 3 Dec 2020 18:51:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 03 Dec 2020 18:51:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3617 invoked by uid 111); 3 Dec 2020 18:51:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 03 Dec 2020 13:51:25 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 3 Dec 2020 13:51:24 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] style: indent multiline "if" conditions by 4 spaces
Message-ID: <X8kzrFd2XaVJ+UU6@coredump.intra.peff.net>
References: <X8ibEpkel8OMS/hV@coredump.intra.peff.net>
 <xmqqv9dihhqs.fsf@gitster.c.googlers.com>
 <X8kvJRnOtSEYziRK@coredump.intra.peff.net>
 <xmqqr1o6hh09.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr1o6hh09.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 03, 2020 at 10:38:30AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Yeah, the goal is to align it, but I had trouble thinking of a succinct
> > way to say that. Maybe just:
> >
> >   style: align indent of multiline "if" conditions
> 
> I couldn't come up with a good description, and 
> just did s/by 4 spaces/to align/, i.e.
> 
>     style: indent multiline "if" conditions to align
> 
> while queuing.  I dunno.

That sounds perfectly reasonable to me.

-Peff
