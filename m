Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9D5C4741F
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 01:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 103E020789
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 01:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730790AbgKJBDt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 20:03:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:52318 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729661AbgKJBDs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 20:03:48 -0500
Received: (qmail 5340 invoked by uid 109); 10 Nov 2020 01:03:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 10 Nov 2020 01:03:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29656 invoked by uid 111); 10 Nov 2020 01:03:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Nov 2020 20:03:46 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Nov 2020 20:03:46 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Nov 2020, #02; Mon, 9)
Message-ID: <20201110010346.GA1269097@coredump.intra.peff.net>
References: <xmqq7dqu9jwh.fsf@gitster.c.googlers.com>
 <CABPp-BGtO5bgoinmjc3=WwW+w7G4Js14iGvO_qQ6oF3EcQt7xQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BGtO5bgoinmjc3=WwW+w7G4Js14iGvO_qQ6oF3EcQt7xQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 09, 2020 at 04:44:17PM -0800, Elijah Newren wrote:

> > * en/strmap (2020-11-06) 15 commits
> [...]
> >  Will merge to 'next'?
> 
> Yes, please.  Peff went over the series in detail and said it looked
> good to him as of v4 (he also seemed fine with the extra change in v5
> that I made in response to your request).  I'm not aware of any issues
> or further requests, and believe it is done.  I'll CC Peff just in
> case he wants to change his mind and request any more changes here...

I actually forgot to look over your strset_add() function carefully, so
thanks for the reminder. :) It all looks good to me. Obviously the
boolean return is flipped from my strset_check_and_add(), but I can't
really think of a reason to prefer one over the other.

-Peff
