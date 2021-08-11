Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3F9C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 21:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97D4D60F46
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 21:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhHKVCu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 17:02:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:44720 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229589AbhHKVCt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 17:02:49 -0400
Received: (qmail 23145 invoked by uid 109); 11 Aug 2021 21:02:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 11 Aug 2021 21:02:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14897 invoked by uid 111); 11 Aug 2021 21:02:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Aug 2021 17:02:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 11 Aug 2021 17:02:24 -0400
From:   Jeff King <peff@peff.net>
To:     Michael J Gruber <git@grubix.eu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Matthieu Moy <git@matthieu-moy.fr>
Subject: Re: [PATCH 6/7] stage: add 'diff' subcommand
Message-ID: <YRQ64HDKF4NgacAv@coredump.intra.peff.net>
References: <20210811045727.2381-1-felipe.contreras@gmail.com>
 <20210811045727.2381-7-felipe.contreras@gmail.com>
 <8034894f-a8dd-e1ee-1825-7cb172afdba3@gmail.com>
 <xmqqzgto9dkd.fsf@gitster.g>
 <YRQfx+Njj1WxOnyG@coredump.intra.peff.net>
 <162871314612.7067.6886805754107701040.git@grubix.eu>
 <YRQ11bYH5lV9D24D@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YRQ11bYH5lV9D24D@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 11, 2021 at 04:40:54PM -0400, Jeff King wrote:

> Agreed. At one point[1] I half-proposed a "git put" command that would
> move changes between those three places (and giving a concrete name for
> the index and working tree so they could be specified as sources or
> destinations).

I forgot my footnote. It's:

  https://lore.kernel.org/git/20110607200659.GA6177@sigill.intra.peff.net/

Not that I really think it's worth anybody's time to dig too far into
it.

-Peff
