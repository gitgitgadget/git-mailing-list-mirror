Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BAB420951
	for <e@80x24.org>; Fri, 17 Mar 2017 17:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751284AbdCQRx2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 13:53:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:46070 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751115AbdCQRx0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 13:53:26 -0400
Received: (qmail 16558 invoked by uid 109); 17 Mar 2017 17:45:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Mar 2017 17:45:53 +0000
Received: (qmail 5368 invoked by uid 111); 17 Mar 2017 17:46:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Mar 2017 13:46:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Mar 2017 13:45:49 -0400
Date:   Fri, 17 Mar 2017 13:45:49 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH 0/3] Git integration update for DC-SHA1
Message-ID: <20170317174549.54jci3jpw6maj2xt@sigill.intra.peff.net>
References: <20170317111814.tkzeqfyr3aiyxsxr@sigill.intra.peff.net>
 <20170317170938.20593-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170317170938.20593-1-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 17, 2017 at 10:09:35AM -0700, Junio C Hamano wrote:

> Here are three patches to replace the last two patches from your
> series.
> 
>  - The Makefile knob is named DC_SHA1, not USE_SHA1DC; this is to
>    keep it consistent with existing BLK_SHA1 and PPC_SHA1.
> 
>  - The CPP macro is called SHA1_DC, not SHA1_SHA1DC; again this is
>    for consistency with SHA1_BLK and SHA1_PPC.
> 
>  - Switch the default from OpenSSL's implementation to DC_SHA1.
>    Those who want OpenSSL's one can ask with OPENSSL_SHA1.

OK. DC_SHA1 exposed tothe user does look a little funny to me, but it is
at least consistent with the other names. The patches themselves look
obviously fine.

-Peff
