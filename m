Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFB091F424
	for <e@80x24.org>; Sat, 31 Mar 2018 10:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753120AbeCaKNu (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Mar 2018 06:13:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:49888 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753070AbeCaKNu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Mar 2018 06:13:50 -0400
Received: (qmail 7167 invoked by uid 109); 31 Mar 2018 10:13:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 31 Mar 2018 10:13:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3678 invoked by uid 111); 31 Mar 2018 10:14:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 31 Mar 2018 06:14:49 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 31 Mar 2018 06:13:48 -0400
Date:   Sat, 31 Mar 2018 06:13:47 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Wong <e@80x24.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 10/13] pack-objects: clarify the use of
 object_entry::size
Message-ID: <20180331101347.GA32290@sigill.intra.peff.net>
References: <20180318142526.9378-1-pclouds@gmail.com>
 <20180324063353.24722-1-pclouds@gmail.com>
 <20180324063353.24722-11-pclouds@gmail.com>
 <20180330210416.GH14782@sigill.intra.peff.net>
 <CACsJy8AQ7yRK65rYqMkR+QJn2KUJ=Y+9E_=k3aBU78xF=LBQjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8AQ7yRK65rYqMkR+QJn2KUJ=Y+9E_=k3aBU78xF=LBQjw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 31, 2018 at 06:35:40AM +0200, Duy Nguyen wrote:

> On Fri, Mar 30, 2018 at 11:04 PM, Jeff King <peff@peff.net> wrote:
> > The subject says "clarify" so I was a little surprised to see code
> > changes. It looks like we're just avoiding reassigning on top of the
> > value repeatedly, which is part of that clarification. It looks like a
> > noop to me.
> 
> Oh well... I was counting on the new name (in_pack_size, which follows
> in_pack_type naming convention) to emphasize it (and the new "delta
> size" comment to point out where in_pack_size contains a delta size.

Just to be clear, my final "it looks like a noop" means "good, it looks
like it is a pure cosmetic change and no change to the behavior."

-Peff
