Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4930BC388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 19:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD7B8206B6
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 19:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbgKJTsZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 14:48:25 -0500
Received: from cloud.peff.net ([104.130.231.41]:53232 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbgKJTsY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 14:48:24 -0500
Received: (qmail 8936 invoked by uid 109); 10 Nov 2020 19:48:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 10 Nov 2020 19:48:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4434 invoked by uid 111); 10 Nov 2020 19:48:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 10 Nov 2020 14:48:23 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 10 Nov 2020 14:48:23 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] add-interactive.c: use correct names to load
 color.diff.* config
Message-ID: <20201110194823.GA1987088@coredump.intra.peff.net>
References: <313B8999-1E99-4695-A20D-E48840C30879@gmail.com>
 <20201106170345.GA174555@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2011101653330.18437@tvgsbejvaqbjf.bet>
 <20201110182833.GB1362803@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2011102015160.18437@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2011102015160.18437@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 10, 2020 at 08:17:04PM +0100, Johannes Schindelin wrote:

> If you don't mind, I'd like to integrate your work into mine and make you
> a co-author. Objections?

Nope, no problem at all (I was worried we might be duplicating, but I
thought maybe you'd have quit for the day already. Silly timezones).

-Peff
