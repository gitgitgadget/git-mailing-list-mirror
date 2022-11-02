Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C4CC433FE
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 09:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiKBJVF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 05:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbiKBJUj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 05:20:39 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68352BB
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 02:18:30 -0700 (PDT)
Received: (qmail 9861 invoked by uid 109); 2 Nov 2022 09:18:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 02 Nov 2022 09:18:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4148 invoked by uid 111); 2 Nov 2022 09:18:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 02 Nov 2022 05:18:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 2 Nov 2022 05:18:29 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 2/2] t5551: be less strict about the number of
 credential warnings
Message-ID: <Y2I15UY/a7OAZUtm@coredump.intra.peff.net>
References: <pull.1399.git.1667245638.gitgitgadget@gmail.com>
 <RFC-patch-1.1-0266485bc6c-20221031T204149Z-avarab@gmail.com>
 <Y2CFRJLFRXvGwFBC@coredump.intra.peff.net>
 <221101.86a65b5q9q.gmgdl@evledraar.gmail.com>
 <Y2GHjnuyuwGpY3II@nand.local>
 <Y2ItZWx+kBmTreGQ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2ItZWx+kBmTreGQ@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 02, 2022 at 04:42:13AM -0400, Jeff King wrote:

> As I said, I had tried to mostly leave patch 2 alone to avoid derailing
> Dscho's attempt to fix things. But somehow things got derailed anyway,
> so maybe we can just all agree on this patch and move on with our lives?

By the way, I think you (or somebody?) mentioned elsewhere in the thread
that it's possible the first patch fixes things by itself. I would also
be content to just apply the first one and see if CI improves.

Of course, when I just pushed all this out to CI, it flaked
independently on both osx (looks like racy p4 stuff) and fedora (network
dropout failed to set up the container). Sigh.

-Peff
