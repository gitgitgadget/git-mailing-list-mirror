Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9742C0502A
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 15:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbiHaP1F (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 11:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbiHaP1D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 11:27:03 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA30D7D0B
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 08:27:01 -0700 (PDT)
Received: (qmail 14944 invoked by uid 109); 31 Aug 2022 15:27:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 31 Aug 2022 15:27:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14507 invoked by uid 111); 31 Aug 2022 15:27:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 31 Aug 2022 11:27:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 31 Aug 2022 11:27:00 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: jk/unused-annotation + ab/unused-annotation (was: What's cooking
 in git.git (Aug 2022, #10; Tue, 30))
Message-ID: <Yw99xMnkiv/Qjnst@coredump.intra.peff.net>
References: <xmqqilm9k0bc.fsf@gitster.g>
 <220831.86fshcal32.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220831.86fshcal32.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 31, 2022 at 10:00:50AM +0200, Ævar Arnfjörð Bjarmason wrote:

> I see you did this already in 4f464a7b54a (Revert "Merge branch
> 'jk/unused-annotation' into next", 2022-08-30), per [1] and [2] you &
> Jeff seemed to agree on my approach in [3] as a way forward.
> 
> The ab/unused-annotation in "seen" (not in this WC E-Mail) is a rebased
> version of 1/2 of that series. Without the 2/2 [4] it won't catch the
> accidental use of parameters.
> 
> Were you planning on picking that up, or would you like it submitted
> separately? I know there were reservations about (ab)using "deprecated"
> for this, but per the rationale in [4] and Jeff's [2] it seemed like
> there was consensus to go that route.

Yeah, I think we should use the deprecated attribute. Since the original
has been reverted, I think the next step would be for me to fix up the
patches to use that approach from the start, and re-submit.

I was dragging my feet a little hoping that we might get some coccinelle
parsing miracle in the interim.

-Peff
