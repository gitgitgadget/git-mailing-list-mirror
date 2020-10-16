Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28D8C433DF
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 20:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CB0420878
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 20:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393562AbgJPULU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 16:11:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:34788 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393559AbgJPULU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 16:11:20 -0400
Received: (qmail 31622 invoked by uid 109); 16 Oct 2020 20:11:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 16 Oct 2020 20:11:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12375 invoked by uid 111); 16 Oct 2020 20:11:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 16 Oct 2020 16:11:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 16 Oct 2020 16:11:19 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH 0/1] Clarify and expand description of --signoff
Message-ID: <20201016201119.GA3356073@coredump.intra.peff.net>
References: <20201015215933.96425-1-bkuhn@sfconservancy.org>
 <59E3B060-63E3-41C2-A7C4-5B2C888F8D68@gmail.com>
 <CAPc5daWenXds=0BW0CXa=4MOF2UxDeQ8DF2+7V9-WkKwCFCDBw@mail.gmail.com>
 <20201016015937.GA3335046@coredump.intra.peff.net>
 <xmqqft6eewc5.fsf@gitster.c.googlers.com>
 <xmqqh7quaqwb.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh7quaqwb.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 16, 2020 at 12:53:56PM -0700, Junio C Hamano wrote:

> > Jeff King <peff@peff.net> writes:
> >
> >> What should we change there? We could perhaps bring up signoffs earlier
> >> or more prominently. Or tie it in to the git-commit docs by saying
> >> explicitly: these are _our_ project rules for signoffs.
> 
> Let's tie this loose end.  How about squashing in something like
> this?

Thanks for writing this up. I agree it makes the text much better (not
only in emphasizing the point we've been discussing, but also in general
clarity).

You said "squashing", but I'd suggest keeping it as its own patch on top
of Bradley's.

-Peff
