Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D390C433E2
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 19:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 763BD207DF
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 19:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgH1Tvc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 15:51:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:44066 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbgH1Tva (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 15:51:30 -0400
Received: (qmail 29012 invoked by uid 109); 28 Aug 2020 19:51:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 28 Aug 2020 19:51:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12011 invoked by uid 111); 28 Aug 2020 19:51:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 28 Aug 2020 15:51:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 28 Aug 2020 15:51:28 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH] midx: traverse the local MIDX first
Message-ID: <20200828195128.GA2187386@coredump.intra.peff.net>
References: <20200828180621.GA9036@nand.nand.local>
 <20200828185039.GA2171353@coredump.intra.peff.net>
 <20200828185531.GB2171353@coredump.intra.peff.net>
 <80ba7515-dc6c-3acd-4b53-c60cbdab1633@gmail.com>
 <20200828190752.GD19328@nand.nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200828190752.GD19328@nand.nand.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 28, 2020 at 03:07:52PM -0400, Taylor Blau wrote:

> Ditto. Peff and I crossed emails, so I was talking about tidying up his
> earlier patch before I even had seen the second one.
> 
> Peff -- any objections to me squashing this into mine and sending that
> for queueing?

Nope, please do (and feel free to forge my signoff).

-Peff
