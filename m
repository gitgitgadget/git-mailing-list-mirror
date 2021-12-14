Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBF8C433F5
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 13:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbhLNNSE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 08:18:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:51372 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229952AbhLNNSE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 08:18:04 -0500
Received: (qmail 13573 invoked by uid 109); 14 Dec 2021 13:18:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Dec 2021 13:18:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24263 invoked by uid 111); 14 Dec 2021 13:18:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Dec 2021 08:18:03 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Dec 2021 08:18:02 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>
Subject: Re: [RFC/PATCH] Makefile: add test-all target
Message-ID: <YbiZiqLQnFkxLMAA@coredump.intra.peff.net>
References: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
 <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com>
 <CABPp-BGpe9Q5k22Yu8a=1xwu=pZYSeNQoqEgf+DN07cU4EB1ew@mail.gmail.com>
 <xmqq4k7nmksi.fsf@gitster.g>
 <211207.86ilw0matb.gmgdl@evledraar.gmail.com>
 <xmqqh7bi27o9.fsf@gitster.g>
 <xmqq8rwu278d.fsf_-_@gitster.g>
 <nycvar.QRO.7.76.6.2112110003530.90@tvgsbejvaqbjf.bet>
 <xmqqh7bcgaki.fsf@gitster.g>
 <YbiZKYFR8kilit+0@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YbiZKYFR8kilit+0@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 14, 2021 at 08:16:26AM -0500, Jeff King wrote:

> > There are projects that want to use libgit.a by binding us as a
> > submodule and without interacting with us very much.  And they are
> > on their own when we change the internals.  Do you mean that you
> > want to make scalar into the same status as they are?
> 
> I kind of thought that final paragraph was the plan, at least to start
> with.

Oh, and just to be clear: I am really OK with either direction. I'm only
claiming that I think both approaches are self-consistent and are making
a tradeoff (finding bugs earlier, versus shifting burden of bug-fixing
around).

-Peff
