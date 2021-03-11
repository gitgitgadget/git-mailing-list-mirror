Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42634C433DB
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 19:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1F4564F05
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 19:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhCKTRl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 14:17:41 -0500
Received: from cloud.peff.net ([104.130.231.41]:60824 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229789AbhCKTR1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 14:17:27 -0500
Received: (qmail 16848 invoked by uid 109); 11 Mar 2021 19:17:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 Mar 2021 19:17:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12957 invoked by uid 111); 11 Mar 2021 19:17:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Mar 2021 14:17:27 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 11 Mar 2021 14:17:25 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: What's cooking in git.git (Mar 2021, #03; Wed, 10)
Message-ID: <YEpsxUhVmYLK0ZK8@coredump.intra.peff.net>
References: <xmqqmtvafl62.fsf@gitster.g>
 <87r1klhq3y.fsf@evledraar.gmail.com>
 <xmqqy2etczqi.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy2etczqi.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 11, 2021 at 10:27:33AM -0800, Junio C Hamano wrote:

> >> * ab/tests-cleanup-around-sha1 (2021-03-10) 4 commits
> >>  - tests: get rid of $_x05 from the test suite
> >>  - shortlog tests: rewrite to get rid of --abbrev=35 hardcoding
> >>  - test-lib: remove unused $_x40 and $_z40 variables
> >>  - git-bisect: remove unused SHA-1 $x40 shell variable
> >
> > FWIW (mostly for other readers) I suggested in
> > https://lore.kernel.org/git/87tupigf02.fsf@evledraar.gmail.com/ just now
> > that we drop 4/4.
> 
> I do not trust myself; we need to get 2&3 reviewed independently
> before we can move beyond discarding the $_x05 step.

Patch 2 looks obviously correct to me (along with 1).

I responded to patch 3. Mostly with nitpicks, though I tend to agree
that the "1-41" magic at least deserves a comment.

I didn't look at patch 4, since it seemed scary and you suggested
dropping it. ;)

-Peff
