Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FD7C433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 14:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CC0961A6C
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 14:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237596AbhKPO5b (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 09:57:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:60048 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233685AbhKPO5a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 09:57:30 -0500
Received: (qmail 20292 invoked by uid 109); 16 Nov 2021 14:54:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Nov 2021 14:54:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29601 invoked by uid 111); 16 Nov 2021 14:54:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Nov 2021 09:54:33 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Nov 2021 09:54:32 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Carlo Arenas <carenas@gmail.com>
Subject: Re: [PATCH v2 1/1] git-compat-util: add a test balloon for C99
 support
Message-ID: <YZPGKHYE/9km1rH5@coredump.intra.peff.net>
References: <20211114212437.1466695-1-sandals@crustytoothpaste.net>
 <20211116021241.1565740-1-sandals@crustytoothpaste.net>
 <20211116021241.1565740-2-sandals@crustytoothpaste.net>
 <YZOh370ZMMqSADUE@coredump.intra.peff.net>
 <211116.86pmr0p82k.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211116.86pmr0p82k.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 16, 2021 at 01:54:27PM +0100, Ævar Arnfjörð Bjarmason wrote:

> But IMO this whole thing of trying to make this work on every compiler
> etc. just isn't worth it.
> 
> Let's just start using C99 features, and if anyone's compiler breaks on
> something like CentOS 6 document that they'll need to tweak a flag
> somewhere. We already know that works for all the other C99 features we
> have, there seems to just be this one exception of the ancient GCC
> version in this particular case.

Yeah, I definitely agree with this sentiment.

-Peff
