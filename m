Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 016BD20951
	for <e@80x24.org>; Tue, 14 Mar 2017 21:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751113AbdCNV0R (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 17:26:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:44175 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750918AbdCNV0Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 17:26:16 -0400
Received: (qmail 2709 invoked by uid 109); 14 Mar 2017 21:26:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Mar 2017 21:26:15 +0000
Received: (qmail 14297 invoked by uid 111); 14 Mar 2017 21:26:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Mar 2017 17:26:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Mar 2017 17:26:12 -0400
Date:   Tue, 14 Mar 2017 17:26:12 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH] Move SHA-1 implementation selection into a header
 file
Message-ID: <20170314212612.webhzphavvislt4u@sigill.intra.peff.net>
References: <20170311222818.518541-1-sandals@crustytoothpaste.net>
 <20170314184126.GJ26789@aiede.mtv.corp.google.com>
 <20170314201424.vccij5z2ortq4a4o@sigill.intra.peff.net>
 <xmqq1stzio5b.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1stzio5b.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 14, 2017 at 01:44:48PM -0700, Junio C Hamano wrote:

> OK, then I'll queue this.  The selection still goes to BASIC_CFLAGS
> so the dependencies for re-compilation should be right, I'd think.

Yeah, I think that part should be fine.

> -- >8 --
> From: "brian m. carlson" <sandals@crustytoothpaste.net>
> Date: Sat, 11 Mar 2017 22:28:18 +0000
> Subject: [PATCH] hash.h: move SHA-1 implementation selection into a header file

Looks good to me.

Reviewed-by: Jeff King <peff@peff.net>

-Peff
