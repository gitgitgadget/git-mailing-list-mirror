Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7CBC3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 16:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5199206D9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 16:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbgEDQd1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 12:33:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:36018 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729643AbgEDQd0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 12:33:26 -0400
Received: (qmail 31974 invoked by uid 109); 4 May 2020 16:33:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 04 May 2020 16:33:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18581 invoked by uid 111); 4 May 2020 16:33:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 04 May 2020 12:33:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 4 May 2020 12:33:25 -0400
From:   Jeff King <peff@peff.net>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Danh Doan <congdanhqx@gmail.com>, clime <clime7@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] CodingGuidelines: drop arithmetic expansion advice to
 use "$x"
Message-ID: <20200504163325.GA18103@coredump.intra.peff.net>
References: <20200503090952.GA170768@coredump.intra.peff.net>
 <20200503091157.GA170902@coredump.intra.peff.net>
 <20200503114351.GA28680@danh.dev>
 <20200504151351.GC11373@coredump.intra.peff.net>
 <xmqqh7wviud9.fsf@gitster.c.googlers.com>
 <20200504160709.GB12842@coredump.intra.peff.net>
 <20200504162844.GE86805@Carlos-MBP>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200504162844.GE86805@Carlos-MBP>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 04, 2020 at 09:28:44AM -0700, Carlo Marcelo Arenas Belón wrote:

> On Mon, May 04, 2020 at 12:07:09PM -0400, Jeff King wrote:
> > -- >8 --
> > Subject: CodingGuidelines: drop arithmetic expansion advice to use "$x"
> > 
> > The advice to use "$x" rather than "x" in arithmetric expansion was
> > working around a dash bug fixed in 0.5.4. Even Debian oldstable has
> > 0.5.7 these days.
> 
> that would be oldoldstable, oldstable is actually in 0.5.8 ;)

Oh, you're right. I forgot they're doing an extra layer these days. It
will officially become obsolete in less than 2 months. :)

-Peff
