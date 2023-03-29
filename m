Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD492C74A5B
	for <git@archiver.kernel.org>; Wed, 29 Mar 2023 23:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjC2XTI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Mar 2023 19:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjC2XTH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2023 19:19:07 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA75F658D
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 16:18:28 -0700 (PDT)
Received: (qmail 17178 invoked by uid 109); 29 Mar 2023 23:18:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 29 Mar 2023 23:18:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12413 invoked by uid 111); 29 Mar 2023 23:18:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 Mar 2023 19:18:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 29 Mar 2023 19:18:26 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2023, #06; Wed, 29)
Message-ID: <20230329231826.GA2314218@coredump.intra.peff.net>
References: <xmqqv8ij5g83.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv8ij5g83.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 29, 2023 at 03:45:48PM -0700, Junio C Hamano wrote:

> * jk/chainlint-fixes (2023-03-28) 4 commits
>  - tests: skip test_eval_ in internal chain-lint
>  - tests: drop here-doc check from internal chain-linter
>  - tests: replace chainlint subshell with a function
>  - tests: run internal chain-linter under "make test"
> 
>  Test framework fix.
> 
>  Comments?
>  source: <20230328202043.GA1241391@coredump.intra.peff.net>

Happy for more review, of course, but note that I'll also be sending a
re-roll with Eric's chainlint.pl patch in the middle.

> * jk/document-pack-redundant-deprecation (2023-03-28) 1 commit
>   (merged to 'next' on 2023-03-29 at cb64256b97)
>  + pack-redundant: document deprecation
> 
>  Document that we have marked "pack-redundant" as deprecated.
> 
>  Will merge to 'master'.
>  source: <20230328190641.GF18558@coredump.intra.peff.net>

The application of the patch missed out on --scissors, I think.
(I also expected it on top of jk/really-deprecate-pack-redundant, and
for them to graduate together, but I don't think that matters much
either way).

-Peff
