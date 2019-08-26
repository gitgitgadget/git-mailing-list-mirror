Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1538C1F461
	for <e@80x24.org>; Mon, 26 Aug 2019 18:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbfHZSdS (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 14:33:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:56182 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727687AbfHZSdS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 14:33:18 -0400
Received: (qmail 6586 invoked by uid 109); 26 Aug 2019 18:33:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 26 Aug 2019 18:33:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22477 invoked by uid 111); 26 Aug 2019 18:34:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 26 Aug 2019 14:34:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 26 Aug 2019 14:33:17 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Andrey Portnoy <aportnoy@ucsd.edu>, Taylor Blau <me@ttaylorr.com>,
        Andrey Portnoy via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/1] banned.h: fix vsprintf warning
Message-ID: <20190826183317.GB23399@sigill.intra.peff.net>
References: <pull.322.git.gitgitgadget@gmail.com>
 <xmqqwoezj3o5.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwoezj3o5.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 26, 2019 at 09:24:10AM -0700, Junio C Hamano wrote:

> "Andrey Portnoy via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > Previously sprintf was the argument to the BANNED macro, where vsprintf is
> > expected.
> 
> Good eyes.  Thanks.

There's an identical patch in:

  https://public-inbox.org/git/cab687db8315dd4245e1703402a8c76218ee1115.1566762128.git.me@ttaylorr.com/

and both were inspired by:

  https://news.ycombinator.com/item?id=20793298

whose author has little info there, but I think is separate from either
submitter.

I don't know if we want to try to spread credit around via trailers.
"Racily-implemented-by:" ? :)

Anyway, the original bug is mine and the patch is obviously correct.

-Peff
