Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22A9C19F28
	for <git@archiver.kernel.org>; Sun, 31 Jul 2022 00:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbiGaAfP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jul 2022 20:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiGaAfO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jul 2022 20:35:14 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EFC5FC8
        for <git@vger.kernel.org>; Sat, 30 Jul 2022 17:35:12 -0700 (PDT)
Received: (qmail 28125 invoked by uid 109); 31 Jul 2022 00:35:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 31 Jul 2022 00:35:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7990 invoked by uid 111); 31 Jul 2022 00:35:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 30 Jul 2022 20:35:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 30 Jul 2022 20:35:10 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 3/5] git.txt: remove redundant language
Message-ID: <YuXOPpww39EsOna4@coredump.intra.peff.net>
References: <pull.1274.v2.git.1657852722.gitgitgadget@gmail.com>
 <pull.1274.v3.git.1658255537.gitgitgadget@gmail.com>
 <c1c83c4284ba4b041694a521c3639f33561ac5e3.1658255537.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c1c83c4284ba4b041694a521c3639f33561ac5e3.1658255537.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 19, 2022 at 06:32:15PM +0000, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>
> 
> The documentation for GIT_ALLOW_PROTOCOL has a sentence that adds no
> value, since it repeats the meaning from the previous sentence (twice!).

I think the point the original was trying to make was emphasizing that
when the variable is set at all, then we operate in this new mode.

Maybe that's sufficiently conveyed in the first sentence, but perhaps
another way of expanding would be:

  If the variable is unset, it has no effect, and the normal
  configuration is respected.

But perhaps that is obvious enough from the previous sentence. Since I
was involved in drafting the original, I'm not sure I'm a good judge of
what is obvious and what is not. :)

-Peff
