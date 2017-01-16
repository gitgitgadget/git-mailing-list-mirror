Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B90A120756
	for <e@80x24.org>; Mon, 16 Jan 2017 08:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751348AbdAPIKR (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jan 2017 03:10:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:39681 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751288AbdAPIKQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2017 03:10:16 -0500
Received: (qmail 23010 invoked by uid 109); 16 Jan 2017 08:10:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Jan 2017 08:10:10 +0000
Received: (qmail 7925 invoked by uid 111); 16 Jan 2017 08:11:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Jan 2017 03:11:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jan 2017 03:10:08 -0500
Date:   Mon, 16 Jan 2017 03:10:08 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        pclouds@gmail.com, sbeller@google.com
Subject: Re: [PATCH 00/27] Revamp the attribute system; another round
Message-ID: <20170116081008.jqaenoe4x5ho25cv@sigill.intra.peff.net>
References: <20170112235354.153403-1-bmwill@google.com>
 <xmqq37gjdgxn.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq37gjdgxn.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 15, 2017 at 03:47:16PM -0800, Junio C Hamano wrote:

> This one unfortunately clashes with jk/nofollow-attr-ignore where
> Peff adds sanity to refuse following symbolic links when reading
> .gitignore and .gitattributes; I'll eject jk/nofollow-attr-ignore
> topic for now and see how well this topic fits together with the
> remainder of the topics in flight.

Yeah, that's a good plan. I think my re-roll of the nofollow stuff will
be pretty major, and may not end up touching the attribute code directly
at all.

-Peff
