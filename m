Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52515C433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 21:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A28E60F38
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 21:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbhIKV73 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 17:59:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:45254 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229800AbhIKV73 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 17:59:29 -0400
Received: (qmail 13546 invoked by uid 109); 11 Sep 2021 21:58:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 11 Sep 2021 21:58:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25137 invoked by uid 111); 11 Sep 2021 21:58:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 11 Sep 2021 17:58:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 11 Sep 2021 17:58:14 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Andrei Rybak <rybak.a.v@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>,
        "Tom G . Christensen" <tgc@jupiterrise.com>,
        Mischa POSLAWSKY <git@shiar.nl>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v4 2/5] http: drop support for curl < 7.16.0
Message-ID: <YT0mdus+OFCve6MU@coredump.intra.peff.net>
References: <cover-v3-0.7-00000000000-20210730T092843Z-avarab@gmail.com>
 <cover-v4-0.5-00000000000-20210730T175650Z-avarab@gmail.com>
 <patch-v4-2.5-fb308258e2b-20210730T175650Z-avarab@gmail.com>
 <1b18309a-93e8-60cc-1bd3-61857b1da819@gmail.com>
 <YTy+GH0I2KPnBCUY@coredump.intra.peff.net>
 <xmqqzgsilrkm.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzgsilrkm.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 11, 2021 at 02:39:53PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So the patch is indeed wrong, but the series overall ends up correct.
> 
> I guess that bisectability in a documentation topic does not matter,
> so we can take the end result ;-)

Yes (well, not quite documentation, but it only matters if you have very
specific antique versions of curl). But also, this is in the older
series that already hit master.  So while I would actually fix it up if
it were currently in flight, the breakage is already enshrined in
history.

-Peff
