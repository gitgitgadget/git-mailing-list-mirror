Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB625C433DF
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 18:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80B9620866
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 18:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbgHGS6o (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 14:58:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:52058 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgHGS6o (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 14:58:44 -0400
Received: (qmail 1197 invoked by uid 109); 7 Aug 2020 18:58:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 07 Aug 2020 18:58:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15479 invoked by uid 111); 7 Aug 2020 18:21:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 07 Aug 2020 14:21:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 7 Aug 2020 14:21:41 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] refs: fix interleaving hook calls with
 reference-transaction hook
Message-ID: <20200807182141.GA1307024@coredump.intra.peff.net>
References: <63fb363375b515b903ed1269d10124b727c1d1cc.1596783732.git.ps@pks.im>
 <20200807075837.GA32344@coredump.intra.peff.net>
 <20200807090412.GA1407904@tanuki.pks.im>
 <20200807093239.GA1228157@coredump.intra.peff.net>
 <20200807094946.GA1758126@tanuki.pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200807094946.GA1758126@tanuki.pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 07, 2020 at 11:49:46AM +0200, Patrick Steinhardt wrote:

> Yeah, it's also been my take that OS-level overhead is probably going to
> matter more than those access calls, and I argued such back when I
> proposed the hook. So I'm perfectly happy to see this caching mechanism
> go.
> 
> Should I re-post a v2 with your patch and my test?

Sure, that would be fine (to be clear, I'd also be OK with your original
patch, too; it was mostly just a curiosity to me).

-Peff
