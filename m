Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0396A2022A
	for <e@80x24.org>; Tue,  8 Nov 2016 21:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754016AbcKHVs3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 16:48:29 -0500
Received: from cloud.peff.net ([104.130.231.41]:40347 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753391AbcKHVs2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 16:48:28 -0500
Received: (qmail 31650 invoked by uid 109); 8 Nov 2016 21:48:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Nov 2016 21:48:27 +0000
Received: (qmail 24476 invoked by uid 111); 8 Nov 2016 21:48:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Nov 2016 16:48:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Nov 2016 16:48:25 -0500
Date:   Tue, 8 Nov 2016 16:48:25 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: 2.11.0-rc1 will not be tagged for a few days
Message-ID: <20161108214825.yo37kvoqkeucuqgg@sigill.intra.peff.net>
References: <xmqqk2cgc95m.fsf@gitster.mtv.corp.google.com>
 <20161108004038.a7gyoe6wpucxjmvz@sigill.intra.peff.net>
 <65a1bb6d-e924-21aa-70d3-303ebdc499f1@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <65a1bb6d-e924-21aa-70d3-303ebdc499f1@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 08, 2016 at 07:25:26AM +0100, Johannes Sixt wrote:

> Am 08.11.2016 um 01:40 schrieb Jeff King:
> > In addition to J6t's fix in t0021, ...
> 
> Just to get things straight: Of my two patches, this one ("uniq -c
> variations")
> 
> https://public-inbox.org/git/c842e0a7-b032-e0c4-0995-f11d93c17c0a@kdbg.org/
> 
> is a bug fix in my environment, and I have a suspicion that it is also
> required in other less frequently tested environments (Solaris? BSD
> variants?)
> 
> The other one, which you most likely remember as dealing with "leading
> whitespace in wc -c"
> 
> https://public-inbox.org/git/b87ddffd-3de1-4481-b484-9f03a73b6ad1@kdbg.org/
> 
> is "only" an optimization. The link points at the final version.

Thanks for clarifying. I think it's probably worth applying both.

I'm collecting v2.11-rc1 topics in the "refs/heads/for-junio/" section
of git://github.com/peff/git.git.

I've also got proposed merges for "master" there, though note that none
of the topics has actually cooked at all in next (the fixes are trivial
enough that it may be OK, though).

-Peff
