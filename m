Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F96B1FC96
	for <e@80x24.org>; Tue, 29 Nov 2016 21:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756357AbcK2Vmr (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Nov 2016 16:42:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:48767 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756325AbcK2Vmq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2016 16:42:46 -0500
Received: (qmail 17535 invoked by uid 109); 29 Nov 2016 21:42:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Nov 2016 21:42:45 +0000
Received: (qmail 15655 invoked by uid 111); 29 Nov 2016 21:43:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Nov 2016 16:43:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Nov 2016 16:42:43 -0500
Date:   Tue, 29 Nov 2016 16:42:43 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.11.0
Message-ID: <20161129214243.uunmdc5omlogipso@sigill.intra.peff.net>
References: <xmqqmvgidlsg.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmvgidlsg.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 29, 2016 at 01:21:51PM -0800, Junio C Hamano wrote:

> The latest feature release Git v2.11.0 is now available at the
> usual places.  It is comprised of 673 non-merge commits since
> v2.10.0, contributed by 74 people, 15 of which are new faces.
> [...]
> Jeff King (117):
> [...]
>       common-main: stop munging argv[0] path

Oh, I didn't expect this to go in at the last minute. The regression was
actually in 2.10.0, so I figured it would just end up as part of 2.11.1.

I think it's an obviously correct patch, though (famous last words). :)

-Peff
