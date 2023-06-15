Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D8FEB64DB
	for <git@archiver.kernel.org>; Thu, 15 Jun 2023 07:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244642AbjFOHQt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jun 2023 03:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244655AbjFOHQA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2023 03:16:00 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE2C2976
        for <git@vger.kernel.org>; Thu, 15 Jun 2023 00:13:15 -0700 (PDT)
Received: (qmail 19504 invoked by uid 109); 15 Jun 2023 07:13:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Jun 2023 07:13:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19541 invoked by uid 111); 15 Jun 2023 07:13:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Jun 2023 03:13:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 15 Jun 2023 03:13:14 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Teng Long <dyroneteng@gmail.com>, avarab@gmail.com,
        git@vger.kernel.org, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v9 4/6] notes.c: introduce
 '--separator=<paragraph-break>' option
Message-ID: <20230615071314.GC1460739@coredump.intra.peff.net>
References: <cover.1682671758.git.dyroneteng@gmail.com>
 <ed930ef4f795f30792bc14d9c1939484e4976db8.1682671758.git.dyroneteng@gmail.com>
 <xmqqh6ra26vq.fsf@gitster.g>
 <CAPig+cRzx2r34tqqi527sBcDXm3h_sLR1Y7_gX9R4uQ4KUKzFA@mail.gmail.com>
 <xmqq7cs623v9.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7cs623v9.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 13, 2023 at 07:07:38PM -0700, Junio C Hamano wrote:

> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
> > Is this the same issue Peff reported[1]? His proposed solution was a
> > bit different.
> >
> > [1]: https://lore.kernel.org/git/20230519005447.GA2955320@coredump.intra.peff.net/
> 
> Ah, I should have checked before merging the topic in 'next'.

I only found it after it was in 'next'. :)

It originally did not cause problems, but the switch to clang started
triggering it in CI (it was this case that motivated me to send those
patches CI patches).

I was not following the topic closely, but I think there is a v10 of
this series anyway, so you may want to eject it from 'next' in the
meantime (I had assumed you were going to do so as part of the
post-release rewind, but it looks like that happened already and it got
re-merged).

-Peff
