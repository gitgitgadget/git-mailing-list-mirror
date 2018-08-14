Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EEC81F404
	for <e@80x24.org>; Tue, 14 Aug 2018 02:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbeHNEp4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 00:45:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:54206 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725829AbeHNEp4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 00:45:56 -0400
Received: (qmail 26852 invoked by uid 109); 14 Aug 2018 02:01:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 Aug 2018 02:01:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15855 invoked by uid 111); 14 Aug 2018 02:01:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 13 Aug 2018 22:01:06 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Aug 2018 22:01:00 -0400
Date:   Mon, 13 Aug 2018 22:01:00 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] fsck: use oidset for skiplist
Message-ID: <20180814020100.GB27055@sigill.intra.peff.net>
References: <c1ea6be5-57f7-68f1-0215-b4dceb07603a@web.de>
 <54a5367f-f832-402c-f51b-3225c92b41ad@web.de>
 <20180811170248.GC27393@sigill.intra.peff.net>
 <20180811172350.GA2689@sigill.intra.peff.net>
 <8c5b2783-a08b-4ea4-3d69-8ae80582b5e3@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c5b2783-a08b-4ea4-3d69-8ae80582b5e3@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 13, 2018 at 07:15:19PM +0200, René Scharfe wrote:

> Getting sidetracked here, but the following patch helps both sides a bit:
> 
> -- >8 --
> Subject: [PATCH] cat-file: reuse strbuf in batch_object_write()
> 
> Avoid allocating and then releasing memory for constructing the output
> for each object by reusing the strbuf for all of them.

Thanks, this an easy and sensible optimization. I have a few patches to
send on top of my cat-file topic, so I'll pick this up there.

-Peff
