Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1505920281
	for <e@80x24.org>; Thu, 21 Sep 2017 04:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751387AbdIUEuS (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 00:50:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:45588 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750795AbdIUEuR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 00:50:17 -0400
Received: (qmail 1866 invoked by uid 109); 21 Sep 2017 04:50:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Sep 2017 04:50:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19083 invoked by uid 111); 21 Sep 2017 04:50:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Sep 2017 00:50:54 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Sep 2017 00:50:14 -0400
Date:   Thu, 21 Sep 2017 00:50:14 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revision: replace "struct cmdline_pathspec" with
 argv_array
Message-ID: <20170921045014.yuln2edqybwusyrk@sigill.intra.peff.net>
References: <1505936846-2195-4-git-send-email-martin.agren@gmail.com>
 <20170920202552.kkwhigmv7lq6cj3y@sigill.intra.peff.net>
 <20170920203659.xqy76bg5nfabvbfx@sigill.intra.peff.net>
 <20170920224826.GH27425@aiede.mtv.corp.google.com>
 <20170921030424.akqaou7tqj2updgr@sigill.intra.peff.net>
 <20170921044112.GB91069@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170921044112.GB91069@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 20, 2017 at 09:41:12PM -0700, Jonathan Nieder wrote:

> > Well, no...the idea is that this is a function which leaks a bunch of
> > memory, and we shouldn't have to think hard about how often its leak can
> > be triggered or how severe it is. We should just fix it.
> 
> I forgot to say: thanks for writing such a pleasant patch.
> 
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

You're welcome. :)

> Here's such a patch.
>
> -- 8< --
> Subject: pathspec doc: parse_pathspec does not maintain references to args
> [...]

Yay!

This looks great to me. I think the whole pathspec API could use better
documentation, but this is certainly a good start.

-Peff
