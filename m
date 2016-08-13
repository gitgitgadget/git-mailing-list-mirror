Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CD8F2018E
	for <e@80x24.org>; Sat, 13 Aug 2016 12:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752384AbcHMMYz (ORCPT <rfc822;e@80x24.org>);
	Sat, 13 Aug 2016 08:24:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:54757 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752117AbcHMMYy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2016 08:24:54 -0400
Received: (qmail 13618 invoked by uid 109); 13 Aug 2016 12:24:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 Aug 2016 12:24:53 +0000
Received: (qmail 2773 invoked by uid 111); 13 Aug 2016 12:24:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 Aug 2016 08:24:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Aug 2016 08:24:51 -0400
Date:	Sat, 13 Aug 2016 08:24:51 -0400
From:	Jeff King <peff@peff.net>
To:	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:	Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: introduce set_merge_remote_desc()
Message-ID: <20160813122451.vrqqjjpqicqtz2uj@sigill.intra.peff.net>
References: <57AEE4F7.7090804@web.de>
 <20160813092330.vmy2hip4papyuula@sigill.intra.peff.net>
 <57AF0D8E.6040309@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <57AF0D8E.6040309@web.de>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Aug 13, 2016 at 02:07:42PM +0200, René Scharfe wrote:

> So let's turn this dish into a full menu:
> 
>   commit: use xstrdup() in get_merge_parent()
>   commit: factor out set_merge_remote_desc()
>   merge-recursive: fix verbose output for multiple base trees
>   commit: use FLEX_ARRAY in struct merge_remote_desc

Very nice. Four patches seems like a lot for such a small fix, but each
one is so trivial and easy to understand, I think it's worth it.

They all look good to me.

-Peff
