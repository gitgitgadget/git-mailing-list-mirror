Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F31DF1FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 13:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751677AbdFSNU2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 09:20:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:44290 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751590AbdFSNU2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 09:20:28 -0400
Received: (qmail 1850 invoked by uid 109); 19 Jun 2017 13:14:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 19 Jun 2017 13:14:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26861 invoked by uid 111); 19 Jun 2017 13:20:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 19 Jun 2017 09:20:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Jun 2017 09:20:26 -0400
Date:   Mon, 19 Jun 2017 09:20:26 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Joel Teichroeb <joel@teichroeb.net>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v4 5/5] stash: implement builtin stash
Message-ID: <20170619132025.z42iuqqqskynu64u@sigill.intra.peff.net>
References: <20170608005535.13080-1-joel@teichroeb.net>
 <20170608005535.13080-6-joel@teichroeb.net>
 <xmqqvanvv9be.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1706191516350.57822@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1706191516350.57822@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 19, 2017 at 03:16:48PM +0200, Johannes Schindelin wrote:

> And if you disagree with this assessment, you should point out the same
> issues in literally all of my patches, as I always put initialized
> variables first, uninitialized last.

Yeah, I am scratching my head here. If we do have a convention for
ordering, I'd have thought it is that (and I'd probably put statics even
above initialized variables).

-Peff
