Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB86C433FE
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 09:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiKBJQf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 05:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbiKBJQS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 05:16:18 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB9629341
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 02:15:03 -0700 (PDT)
Received: (qmail 9807 invoked by uid 109); 2 Nov 2022 09:15:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 02 Nov 2022 09:15:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4129 invoked by uid 111); 2 Nov 2022 09:15:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 02 Nov 2022 05:15:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 2 Nov 2022 05:15:02 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 2/2] t5551: be less strict about the number of
 credential warnings
Message-ID: <Y2I1FsYyIRCCwh30@coredump.intra.peff.net>
References: <pull.1399.git.1667245638.gitgitgadget@gmail.com>
 <RFC-patch-1.1-0266485bc6c-20221031T204149Z-avarab@gmail.com>
 <Y2CFRJLFRXvGwFBC@coredump.intra.peff.net>
 <221101.86a65b5q9q.gmgdl@evledraar.gmail.com>
 <Y2GHjnuyuwGpY3II@nand.local>
 <Y2ItZWx+kBmTreGQ@coredump.intra.peff.net>
 <CAPig+cSj78Mh8v6mN3BtyHJ+NxOvT2H_NW6SPFSAce0op2DfjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cSj78Mh8v6mN3BtyHJ+NxOvT2H_NW6SPFSAce0op2DfjA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 02, 2022 at 04:49:37AM -0400, Eric Sunshine wrote:

> > Note that the tests for the "die" mode don't need adjusted. They die
> 
> s/adjusted/adjustment --or -- s/need/& to be/

https://english.stackexchange.com/questions/5407/central-pennsylvanian-english-speakers-what-are-the-limitations-on-the-needs-w

Don't stomp on my linguistic heritage. :)

-Peff
