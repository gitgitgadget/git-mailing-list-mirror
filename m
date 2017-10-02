Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC7F7202DD
	for <e@80x24.org>; Mon,  2 Oct 2017 05:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750878AbdJBFLV (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 01:11:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:57020 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750763AbdJBFLV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 01:11:21 -0400
Received: (qmail 5789 invoked by uid 109); 2 Oct 2017 05:11:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 05:11:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25063 invoked by uid 111); 2 Oct 2017 05:12:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 01:12:01 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Oct 2017 01:11:19 -0400
Date:   Mon, 2 Oct 2017 01:11:19 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] graph: use strbuf_addchars() to add spaces
Message-ID: <20171002051118.zuiwb4jvl6duq4pv@sigill.intra.peff.net>
References: <16d71d5b-6abf-4dcf-0a0b-c09fda7407f7@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16d71d5b-6abf-4dcf-0a0b-c09fda7407f7@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 01, 2017 at 04:45:45PM +0200, René Scharfe wrote:

> strbuf_addf() can be used to add a specific number of space characters
> by using the format "%*s" with an empty string and specifying the
> desired width.  Use strbuf_addchars() instead as it's shorter, makes the
> intent clearer and is a bit more efficient.

Nice. The result looks much clearer to me.

(I won't respond individually to the coccinelle transform patches you
posted earlier, but they also all look obviously correct to me).

-Peff
