Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A77C11F65
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 07:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DA6F61CD0
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 07:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbhF3He0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 03:34:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:37126 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233109AbhF3HeZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 03:34:25 -0400
Received: (qmail 23000 invoked by uid 109); 30 Jun 2021 07:31:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Jun 2021 07:31:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2809 invoked by uid 111); 30 Jun 2021 07:31:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Jun 2021 03:31:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 30 Jun 2021 03:31:55 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: Antw: [EXT] Re: git add --interactive patch improvement for
 split hunks
Message-ID: <YNwd6wmt4FTyySgH@coredump.intra.peff.net>
References: <60D45FE4020000A100041FCE@gwsmtp.uni-regensburg.de>
 <YNSnlhbE30xDfVMY@coredump.intra.peff.net>
 <60D9A01C020000A100042099@gwsmtp.uni-regensburg.de>
 <87eecmgrnx.fsf@evledraar.gmail.com>
 <YNvT+tUlW98dQY3B@coredump.intra.peff.net>
 <xmqq5yxvvq7k.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq5yxvvq7k.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 29, 2021 at 11:09:19PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >     It looks like Junio carried it in "What's Cooking" for almost a
> >     year, marked as "waiting for re-roll" to handle the squash, but then
> >     eventually discarded it as stale. :(
> 
> Heh, thanks for digging.
> 
> Is the moral of the story that we should merge down unfinished
> topics more aggressively (hoping that the untied loose ends would be
> tied after they hit released version), we should prod owners of
> stalled topics with sharper stick more often, or something else?

I'm not sure. I think the topic would have graduated if either you had
just applied the squash and merged it down, or if the original author
had checked back in over the intervening year to say "hey, what happened
to my patch" (either by reading "what's cooking" or manually).

I suspect drive-by contributors might not realize they need to do the
latter in some cases, but I wouldn't have counted 2014-era Ævar in that
boat. So I dunno.

-Peff
