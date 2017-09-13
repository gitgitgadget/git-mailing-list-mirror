Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC687209B8
	for <e@80x24.org>; Wed, 13 Sep 2017 11:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752387AbdIMLGd (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 07:06:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:36458 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752317AbdIMLGc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 07:06:32 -0400
Received: (qmail 31539 invoked by uid 109); 13 Sep 2017 11:06:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Sep 2017 11:06:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12749 invoked by uid 111); 13 Sep 2017 11:07:07 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Sep 2017 07:07:07 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Sep 2017 07:06:30 -0400
Date:   Wed, 13 Sep 2017 07:06:30 -0400
From:   Jeff King <peff@peff.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: BUG: attempt to trim too many characters
Message-ID: <20170913110630.mi75i5eeevn5sqpj@sigill.intra.peff.net>
References: <CA+55aFxW3qcETiMrNk5SqZU+_jtM2Rxeb3mhF=J=c0ChdGm1tg@mail.gmail.com>
 <20170905215056.4wihyd6hrtvk52yd@sigill.intra.peff.net>
 <CA+55aFywhyELmbhAorgTjJZeuNxE-+j2qSP=3d3vqQXNM6p54A@mail.gmail.com>
 <20170905220300.isxbt5y5fd2scd6b@sigill.intra.peff.net>
 <CA+55aFyyHAjEPx6V3X4i7LV-0VGwu2n288ysnpftP1Bx53EX5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFyyHAjEPx6V3X4i7LV-0VGwu2n288ysnpftP1Bx53EX5g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 12, 2017 at 09:29:49PM -0700, Linus Torvalds wrote:

> Just reminding people that this issue would seem to still exist in
> current master..

Yeah, the fix is in 1d0538e4860, but it's still working it's way up
through the integration branches.

-Peff
