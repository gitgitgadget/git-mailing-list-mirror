Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA85C00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 19:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238813AbiG2TzD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 15:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbiG2TzB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 15:55:01 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B7F8052F
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 12:55:00 -0700 (PDT)
Received: (qmail 22334 invoked by uid 109); 29 Jul 2022 19:55:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 Jul 2022 19:55:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28596 invoked by uid 111); 29 Jul 2022 19:54:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 29 Jul 2022 15:54:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 29 Jul 2022 15:54:59 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] merge-file: fix build warning with gcc 4.8.5
Message-ID: <YuQ7E4qoac8YUpJ1@coredump.intra.peff.net>
References: <365e01e93dce582e9d926e83bdc6891310d22699.1659084832.git.congdanhqx@gmail.com>
 <xmqqbkt7api9.fsf@gitster.g>
 <YuQ60ZUPBHAVETD7@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YuQ60ZUPBHAVETD7@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 29, 2022 at 03:53:54PM -0400, Jeff King wrote:

>  # uninitialized warnings on gcc 4.9.2 in xdiff/xdiffi.c and config.c
>  # not worth fixing since newer compilers correctly stop complaining
> +#
> +# Likwise, gcc older than 4.9 complains about initializing a
> +# struct-within-a-struct using just "{ 0 }"

s/Lik/Like/

That's what I get for last-minute editing. :)

-Peff
