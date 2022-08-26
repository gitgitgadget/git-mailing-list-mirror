Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F0EECAAA3
	for <git@archiver.kernel.org>; Fri, 26 Aug 2022 07:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245644AbiHZHwJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Aug 2022 03:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245630AbiHZHwI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2022 03:52:08 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24401D3E67
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 00:52:07 -0700 (PDT)
Received: (qmail 18051 invoked by uid 109); 26 Aug 2022 07:52:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 26 Aug 2022 07:52:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4618 invoked by uid 111); 26 Aug 2022 07:52:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 26 Aug 2022 03:52:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 26 Aug 2022 03:52:06 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/2] git-compat-util.h: change UNUSED(var) to UNUSED
Message-ID: <Ywh7ppVFk6VK1Ybs@coredump.intra.peff.net>
References: <xmqq1qt4486e.fsf@gitster.g>
 <cover-0.2-00000000000-20220825T170709Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-0.2-00000000000-20220825T170709Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 25, 2022 at 07:09:47PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Ævar Arnfjörð Bjarmason (2):
>   git-compat-util.h: use "UNUSED", not "UNUSED(var)"
>   git-compat-util.h: use "deprecated" for UNUSED variables

So I don't love this, as I do find the resulting syntax harder to read.
But I don't really see a way around it to keep coccinelle functioning,
so it seems like the best (only?) path forward.

The patches themselves look OK to me (though I admit my eyes glazed over
halfway through the first one; I assume you used a regex. I'll have to
do the same for the other 100+ patches I have in reserve).

-Peff
