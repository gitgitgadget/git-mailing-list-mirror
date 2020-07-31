Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB2BC433E0
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 20:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72A2821744
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 20:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbgGaUk7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 16:40:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:44328 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729177AbgGaUk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 16:40:59 -0400
Received: (qmail 24607 invoked by uid 109); 31 Jul 2020 20:40:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 31 Jul 2020 20:40:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31032 invoked by uid 111); 31 Jul 2020 20:40:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 31 Jul 2020 16:40:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 31 Jul 2020 16:40:57 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>, git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 3/3] ref-filter: add support for %(contents:size)
Message-ID: <20200731204057.GA1440890@coredump.intra.peff.net>
References: <20200710164739.6616-1-chriscool@tuxfamily.org>
 <20200716121940.21041-1-chriscool@tuxfamily.org>
 <20200716121940.21041-4-chriscool@tuxfamily.org>
 <21bb2dad-5845-8cee-8f6a-1089ef7cae3b@gmail.com>
 <20200731174547.GC843002@coredump.intra.peff.net>
 <CAP8UFD15+p+xKwJ=B9WVsrc+2TvLHKmu78SBCLUFZVSYoTtbbg@mail.gmail.com>
 <xmqqa6zf2zs4.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa6zf2zs4.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 31, 2020 at 01:30:19PM -0700, Junio C Hamano wrote:

> > Yeah, I copied a suggestion from Junio in the last iteration without
> > properly checking it. Sorry about that and thanks for spotting and
> > fixing it.
> 
> I probably should stop giving "perhaps along the lines of this"
> suggestion too lightly and/or when I do not have enough time to
> apply and test myself.  Sorry for the gotcha.

I dunno. I appreciate getting them, especially in patch form. It's often
a more precise description than hand-wavy English, and being a patch
makes it easy to apply into my tree as a starting point. The real trick
is that the receiver needs to know enough to distrust the suggestion and
take ownership of it. Maybe you just need a bigger disclaimer. ;)

(Only half-joking; I do try to say "not tested" or "not even compiled"
when that is the case in stuff I sent out, but I'm sure I'm not
consistent).

-Peff
