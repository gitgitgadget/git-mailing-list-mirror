Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B742C47089
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 02:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbiLFCFH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 21:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbiLFCFF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 21:05:05 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FBD233AE
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 18:05:04 -0800 (PST)
Received: (qmail 11376 invoked by uid 109); 6 Dec 2022 02:05:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 06 Dec 2022 02:05:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16290 invoked by uid 111); 6 Dec 2022 02:05:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 05 Dec 2022 21:05:04 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 5 Dec 2022 21:05:03 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, phillip.wood@dunelm.org.uk,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] test-lib.sh: discover "git" in subdirs of
 "contrib/buildsystems/out"
Message-ID: <Y46jT0i/7DhxHzfS@coredump.intra.peff.net>
References: <663b93ef-0c89-a5f6-1069-b4be97915d20@dunelm.org.uk>
 <patch-1.1-f27d8bd4491-20221201T162451Z-avarab@gmail.com>
 <xmqq5yeuspam.fsf@gitster.g>
 <87f22a55-ee84-2f76-7b9b-924a97f44f89@dunelm.org.uk>
 <221202.86sfhxg2ng.gmgdl@evledraar.gmail.com>
 <Y4qF3iHW2s+I0yNe@coredump.intra.peff.net>
 <221203.86pmd1dyqn.gmgdl@evledraar.gmail.com>
 <Y45/8WnuUnP9gOMo@nand.local>
 <Y46clyoKk9KzFiqj@coredump.intra.peff.net>
 <221206.86zgc1cnc3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221206.86zgc1cnc3.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 06, 2022 at 02:43:17AM +0100, Ævar Arnfjörð Bjarmason wrote:

> > I don't mind having it in-tree if I can ignore it (assuming the project
> > attitude is the "it's a side thing" from above). It's the CI failures
> > that make it hard to ignore.
> 
> ...but on this thread-at-large, I'd much rather see us focus on just
> reviewing the patches I have here than raising the burden of proof to
> whether we should get rid of it entirely.

Fair. In case it is not obvious, I have no interest in reviewing cmake
patches. ;) But I will at least stop making noise in the thread.

> If we make the CI failures "soft" failures or move it out-of-tree
> entirely it would still be useful to be able to run the cmake recipe on
> *nix.

Agreed.

-Peff
