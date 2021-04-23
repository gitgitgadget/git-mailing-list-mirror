Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EAEC433B4
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 14:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AC7461406
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 14:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239670AbhDWO2C (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 10:28:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:33422 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231220AbhDWO2C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 10:28:02 -0400
Received: (qmail 7517 invoked by uid 109); 23 Apr 2021 14:27:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 23 Apr 2021 14:27:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8994 invoked by uid 111); 23 Apr 2021 14:27:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 23 Apr 2021 10:27:24 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 23 Apr 2021 10:27:24 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 4/6] object-store.h: move read_loose_object() below
 'struct object_info'
Message-ID: <YILZTDzMoOVgy6El@coredump.intra.peff.net>
References: <cover-0.6-00000000000-20210328T025618Z-avarab@gmail.com>
 <cover-0.6-00000000000-20210413T093734Z-avarab@gmail.com>
 <patch-4.6-81fffefcf99-20210413T093734Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-4.6-81fffefcf99-20210413T093734Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 13, 2021 at 11:43:07AM +0200, Ævar Arnfjörð Bjarmason wrote:

> Move the definition of read_loose_object() below "struct
> object_info". In the next commit we'll add a "struct object_info *"
> parameter to it, moving it will avoid a forward declaration of the
> struct.

This is a declaration, not a definition, no?

Not a huge deal, I just expected to see the function body moving when I
read the patch, but didn't.

-Peff
