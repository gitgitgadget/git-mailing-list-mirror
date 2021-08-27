Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BAFC4320E
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 18:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9473C60FDA
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 18:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhH0SeR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 14:34:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:60832 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229909AbhH0SeN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 14:34:13 -0400
Received: (qmail 9102 invoked by uid 109); 27 Aug 2021 18:33:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 27 Aug 2021 18:33:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15521 invoked by uid 111); 27 Aug 2021 18:33:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 27 Aug 2021 14:33:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 27 Aug 2021 14:33:22 -0400
From:   Jeff King <peff@peff.net>
To:     Krzysztof =?utf-8?Q?=C5=BBelechowski?= <giecrilj@stegny.2a.pl>
Cc:     git@vger.kernel.org
Subject: Re: git log --encoding=HTML is not supported
Message-ID: <YSkv8jTgR8nxZ+QZ@coredump.intra.peff.net>
References: <9896630.2IqcCWsCYL@localhost.localdomain>
 <YSWVi8uLHZCTtG0l@coredump.intra.peff.net>
 <1790169.Z4XVHNUiN4@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1790169.Z4XVHNUiN4@localhost.localdomain>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 26, 2021 at 01:00:44AM +0200, Krzysztof Żelechowski wrote:

> Dnia środa, 25 sierpnia 2021 02:57:47 CEST Jeff King pisze:
> > As far as what you're trying to accomplish, HTML-escaping isn't
> > something Git supports. You'll have to run the output through an
> > external escaping mechanism.
> 
> Have you looked at the format?  It is a HTML fragment with placeholders to be 
> filled by git log.  I cannot run the output through an external escaping 
> mechanism because it will kill the markup that is already there.

Right, what I mean is that you'd have to pull the output out of Git, and
then format (and escape) it separately.

-Peff
