Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC065EB64DD
	for <git@archiver.kernel.org>; Sat, 24 Jun 2023 01:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbjFXBZ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jun 2023 21:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjFXBZ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2023 21:25:57 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACEA2735
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 18:25:56 -0700 (PDT)
Received: (qmail 13860 invoked by uid 109); 24 Jun 2023 01:25:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 24 Jun 2023 01:25:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8731 invoked by uid 111); 24 Jun 2023 01:25:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 23 Jun 2023 21:25:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 23 Jun 2023 21:25:55 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Subject: Re: bug in en/header-split-cache-h-part-3, was Re: What's cooking in
 git.git (Jun 2023, #05; Tue, 20)
Message-ID: <20230624012555.GD95358@coredump.intra.peff.net>
References: <xmqqedm5k7dx.fsf@gitster.g>
 <20230621085526.GA920315@coredump.intra.peff.net>
 <xmqqttv0hhjv.fsf@gitster.g>
 <20230621202642.GA1423@coredump.intra.peff.net>
 <xmqqjzvwfp6f.fsf@gitster.g>
 <CABPp-BEQ0_UfUbdeFetCsvAnpO_=mvmjQk8JS0trKJtCL=uh1A@mail.gmail.com>
 <xmqqr0q2b0cw.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr0q2b0cw.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 23, 2023 at 09:38:07AM -0700, Junio C Hamano wrote:

> Elijah Newren <newren@gmail.com> writes:
> 
> > Anyway, your rebase of en/header-split-cache-h-part-3, including
> > Dscho's and Peff's changes, all look good to me.
> >
> > Thanks everyone!
> 
> Thanks for confirming.  Let's merge it down to 'next' then.

I did a range-diff between en/header-split-cache-h-part-3{1} and the
current tip, and the changes look good to me. It might have been worth
mentioning the #ifndef changes in the commit message for e8cf8ef507
(setup: adopt shared init-db & clone code, 2023-05-16). But I see you
merged to 'next', and I don't think it's worth going back to change it
again.

It's nice when we can get everything in there, but I find that it's not
uncommon to sometimes dig extra details out of the list archive if I
don't understand part of a change when doing archaeology.

-Peff
