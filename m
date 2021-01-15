Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11770C433E0
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 19:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB181235F8
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 19:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387588AbhAOTwr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 14:52:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:57632 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727855AbhAOTwq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 14:52:46 -0500
Received: (qmail 3918 invoked by uid 109); 15 Jan 2021 19:52:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 15 Jan 2021 19:52:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 355 invoked by uid 111); 15 Jan 2021 19:52:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 Jan 2021 14:52:06 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 15 Jan 2021 14:52:05 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2021, #02; Fri, 8)
Message-ID: <YAHyZbJNhvZUowIq@coredump.intra.peff.net>
References: <xmqqk0sni68g.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk0sni68g.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 08, 2021 at 11:22:23AM -0800, Junio C Hamano wrote:

> * ps/config-env-pairs (2021-01-06) 8 commits
>  - config: allow specifying config entries via envvar pairs
>  - environment: make `getenv_safe()` a public function
>  - config: parse more robust format in GIT_CONFIG_PARAMETERS
>  - config: store "git -c" variables using more robust format
>  - config: extract function to parse config pairs
>  - quote: make sq_dequote_step() a public function
>  - config: add new way to pass config via `--config-env`
>  - git: add `--super-prefix` to usage string
> 
>  Introduce two new ways to feed configuration variable-value pairs
>  via environment variables, and tweak the way GIT_CONFIG_PARAMETERS
>  encodes variable/value pairs to make it more robust.
> 
>  Ready for 'next'?

I looked over the first 7, and noticed two of the patches are flipped in
roder (I sent a separate reply in the thread, but I wanted to catch your
attention, since I guess this may be on the list for integrating today).

I didn't see any problems in the code of the 8th one, but I didn't spend
a lot of brain power thinking about the overall design. I feel like that
was hashed out pretty well in the early discussions, though.

-Peff
