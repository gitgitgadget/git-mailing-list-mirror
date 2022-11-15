Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B07C433FE
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 19:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiKOTgQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 14:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiKOTgO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 14:36:14 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67D495BC
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 11:36:13 -0800 (PST)
Received: (qmail 18978 invoked by uid 109); 15 Nov 2022 19:36:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 15 Nov 2022 19:36:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24874 invoked by uid 111); 15 Nov 2022 19:36:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 15 Nov 2022 14:36:13 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 15 Nov 2022 14:36:12 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org,
        Christian Couder <chriscool@tuxfamily.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 00/11] Turn git-bisect to be builtin
Message-ID: <Y3PqLMzC8DBPjp10@coredump.intra.peff.net>
References: <cover.1668097286.git.congdanhqx@gmail.com>
 <cover.1668097962.git.congdanhqx@gmail.com>
 <Y27Hrkruh6++7NkO@nand.local>
 <Y3PmAP24GPAhXPOm@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y3PmAP24GPAhXPOm@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 15, 2022 at 02:18:24PM -0500, Taylor Blau wrote:

> Hmm. Looks like there is a small breakage in the last commit "Turn `git
> bisect` into a full built-in":
> 
>     $ make check-builtins
>     ./check-builtins.sh
>     bisect is builtin but git-bisect.sh still exists
>     make: *** [Makefile:3561: check-builtins] Error 1
> 
> Seeing that this is on 'next', it would be nice to see a fix in the near
> future, certainly before we graduate this down to 'master'. Am I correct
> in assuming that there is no reason to keep git-bisect.sh around after
> that commit?

Yeah, see:

  https://lore.kernel.org/git/patch-1.1-7be23b6faa0-20221115T093130Z-avarab@gmail.com/

-Peff
