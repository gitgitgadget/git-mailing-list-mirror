Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84ECECAAA1
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 05:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiJ1Fhi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 01:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJ1Fhh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 01:37:37 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE67714088
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 22:37:36 -0700 (PDT)
Received: (qmail 19422 invoked by uid 109); 28 Oct 2022 05:37:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 28 Oct 2022 05:37:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31589 invoked by uid 111); 28 Oct 2022 05:37:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 28 Oct 2022 01:37:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 28 Oct 2022 01:37:35 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        John Cai <johncai86@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 4/4] Documentation: add lint-fsck-msgids
Message-ID: <Y1tqn5qdSzeFwzug@coredump.intra.peff.net>
References: <pull.1369.v2.git.git.1666667864.gitgitgadget@gmail.com>
 <20221025224224.2352979-1-gitster@pobox.com>
 <20221025224224.2352979-5-gitster@pobox.com>
 <221026.867d0ncncu.gmgdl@evledraar.gmail.com>
 <Y1jG8p1aARb9+CV+@coredump.intra.peff.net>
 <221026.8635badbz5.gmgdl@evledraar.gmail.com>
 <08A5BC44-24D9-4C8F-A61A-41983A13553A@gmail.com>
 <221028.86k04k8wbk.gmgdl@evledraar.gmail.com>
 <xmqqk04kjyxd.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqk04kjyxd.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 27, 2022 at 10:32:30PM -0700, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> 
> > First, for the purposes of this thread I think Jeff and I are far off
> > into the weeds here :)
> 
> It is good to clearly separate where we would want to draw the line
> for this round, to get the already-worked-on-and-immediately-available
> improvement going, while we envision a future direction for the longer
> term.

Yeah, to be clear, I'm OK with your linting script in the near term. I
didn't look at it _too_ carefully, but if the linter passes, then I
think the proof is in the pudding, and we can consider the topic done
for now.

-Peff
