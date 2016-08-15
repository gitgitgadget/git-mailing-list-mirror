Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D1B41F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 20:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbcHOULg (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 16:11:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:55772 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932166AbcHOULg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 16:11:36 -0400
Received: (qmail 8472 invoked by uid 109); 15 Aug 2016 20:11:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Aug 2016 20:11:35 +0000
Received: (qmail 19344 invoked by uid 111); 15 Aug 2016 20:11:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Aug 2016 16:11:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Aug 2016 16:11:33 -0400
Date:	Mon, 15 Aug 2016 16:11:33 -0400
From:	Jeff King <peff@peff.net>
To:	Christian Couder <christian.couder@gmail.com>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC/PATCH 2/3] unpack-objects: add --max-input-size=<size>
 option
Message-ID: <20160815201132.73wls7gk5hquuib3@sigill.intra.peff.net>
References: <20160815195729.16826-1-chriscool@tuxfamily.org>
 <20160815195729.16826-3-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160815195729.16826-3-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 15, 2016 at 09:57:28PM +0200, Christian Couder wrote:

> When receiving a pack-file, it can be useful to abort the
> `git unpack-objects`, if the pack-file is too big.
> 
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>

Same remarks here as on the last patch, including strtoumax. :)

-Peff
