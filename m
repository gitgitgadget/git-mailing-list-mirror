Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6578C4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 15:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAC9260F94
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 15:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237006AbhHCPpm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 11:45:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:37030 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236749AbhHCPpl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 11:45:41 -0400
Received: (qmail 1239 invoked by uid 109); 3 Aug 2021 15:45:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 03 Aug 2021 15:45:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14723 invoked by uid 111); 3 Aug 2021 15:45:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Aug 2021 11:45:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 3 Aug 2021 11:45:28 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v4 0/9] Final optimization batch (#15): use memory pools
Message-ID: <YQlkmLfO+eDWE9SJ@coredump.intra.peff.net>
References: <pull.990.v3.git.1627645664.gitgitgadget@gmail.com>
 <pull.990.v4.git.1627752458.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.990.v4.git.1627752458.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 31, 2021 at 05:27:29PM +0000, Elijah Newren via GitGitGadget wrote:

> Changes since v3, as per Peff's feedback:
> 
>  * Don't only remove the extra complexity from the USE_MEMORY_POOL #define;
>    also remove the original bookkeeping complexity needed to track
>    individual frees when not using a memory pool.

Thanks. I skimmed over the changes in patch 9, under the assumption that
they were mostly what I showed before. ;)

The whole thing looks good to me.

-Peff
