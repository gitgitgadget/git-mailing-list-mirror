Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B39C432C3
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 12:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E8B22075C
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 12:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbfKZMUY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Nov 2019 07:20:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:60990 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727615AbfKZMUY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Nov 2019 07:20:24 -0500
Received: (qmail 1011 invoked by uid 109); 26 Nov 2019 12:20:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 26 Nov 2019 12:20:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28287 invoked by uid 111); 26 Nov 2019 12:24:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 26 Nov 2019 07:24:26 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 26 Nov 2019 07:20:22 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, ryenus@gmail.com, stolee@gmail.com,
        szeder.dev@gmail.com, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 0/2] commit-graph: use start_delayed_progress()
Message-ID: <20191126122022.GB10290@sigill.intra.peff.net>
References: <pull.450.v4.git.1574351516.gitgitgadget@gmail.com>
 <pull.450.v5.git.1574717303.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.450.v5.git.1574717303.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 25, 2019 at 09:28:21PM +0000, Derrick Stolee via GitGitGadget wrote:

> Update in V5:
> 
> I took Peff's advice for using "env" to use this delay in the GC test.

Thanks. No further complaints from me. :)

There's an open issue to investigate unpack-trees sending progress to a
non-stderr tty (which you can see in the test suite by setting
GIT_PROGRESS_DELAY=0), but I think that should be handled separately.
My limited digging suggests that it goes back to 2007 or earlier.

-Peff
