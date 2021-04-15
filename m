Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C915AC433B4
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 10:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A197D61074
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 10:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbhDOKK2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 06:10:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:53268 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231482AbhDOKK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 06:10:26 -0400
Received: (qmail 10438 invoked by uid 109); 15 Apr 2021 10:10:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Apr 2021 10:10:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14924 invoked by uid 111); 15 Apr 2021 10:10:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Apr 2021 06:10:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 15 Apr 2021 06:10:02 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 0/3] trace2 docs: note that BUG() sends an "error"
 event
Message-ID: <YHgQ+usXZseTclLT@coredump.intra.peff.net>
References: <cover-0.5-00000000000-20210328T022343Z-avarab@gmail.com>
 <cover-0.3-00000000000-20210413T090603Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-0.3-00000000000-20210413T090603Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 13, 2021 at 11:08:18AM +0200, Ævar Arnfjörð Bjarmason wrote:

> A trivial update to the trace2 docs to fix an omission
> with "BUG()" not being listed alongside error(), die() etc.
> 
> v1 of this[1] added a non-fatal-but-logging bug() function, per the
> discussion on v1 that's now gone.

All three look reasonable to me. I left a few comments, but you may want
to just ignore them. ;)

-Peff
