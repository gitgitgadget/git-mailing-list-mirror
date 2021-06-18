Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A990AC48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 15:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81364613F0
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 15:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbhFRPUZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 11:20:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:60198 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230329AbhFRPUZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 11:20:25 -0400
Received: (qmail 27386 invoked by uid 109); 18 Jun 2021 15:18:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 18 Jun 2021 15:18:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16289 invoked by uid 111); 18 Jun 2021 15:18:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Jun 2021 11:18:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 18 Jun 2021 11:18:14 -0400
From:   Jeff King <peff@peff.net>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] doc: warn people against --max-pack-size
Message-ID: <YMy5Nimj7F1r4Yn4@coredump.intra.peff.net>
References: <776cb2f9-5fef-4486-5aef-f3ee62fcda7e@gmail.com>
 <YL8RfGijMY95miHI@coredump.intra.peff.net>
 <xmqqfsxsq1l4.fsf@gitster.g>
 <YL8bQMOAHxApjVVe@coredump.intra.peff.net>
 <d73194b2-2fc9-80d3-d13c-fb5db3757e01@iee.email>
 <YMye+mkRPD0BkULX@coredump.intra.peff.net>
 <de7239bc-d68e-c9f5-1c97-87df24cfe7b1@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <de7239bc-d68e-c9f5-1c97-87df24cfe7b1@iee.email>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 18, 2021 at 04:15:23PM +0100, Philip Oakley wrote:

> > I'm not quite sure what you're asking. If you mean: should we tell
> > people that they can't use "4.9m" and should instead use "5017k"
> > instead, then I don't have a strong opinion.
> 
> Sorry, I should have included an example based on the patch
> 
> > +The minimum size allowed is limited to 1 MiB. The default is unlimited.
> > +Common unit suffixes of 'k', 'm', or 'g' are supported.
> 
> e.g.
> 
> +The default is unlimited. Common unit suffixes of 'k', 'm', or 'g' are
> +supported. The minimum size allowed is limited to 1 MiB (`1024k`). 
> 
> I swapped the sentence order to allow the scaled example of the minimum
> to be after the explanation of the suffixes

Ah, I see. I don't have a strong feeling either way if you want to
prepare a patch.

-Peff
