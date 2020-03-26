Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9483FC43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 08:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FE8120772
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 08:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgCZIVm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 04:21:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:51860 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727717AbgCZIVm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 04:21:42 -0400
Received: (qmail 1236 invoked by uid 109); 26 Mar 2020 08:21:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 26 Mar 2020 08:21:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12116 invoked by uid 111); 26 Mar 2020 08:31:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Mar 2020 04:31:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 26 Mar 2020 04:21:40 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 2/5] t/lib-gpg.sh: stop pretending to be a stand-alone
 script
Message-ID: <20200326082140.GC2200716@coredump.intra.peff.net>
References: <pull.728.git.git.1584968990.gitgitgadget@gmail.com>
 <pull.728.v2.git.git.1585114881.gitgitgadget@gmail.com>
 <c1811d54190a62e3d35505e2b806c89238b56de8.1585114881.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c1811d54190a62e3d35505e2b806c89238b56de8.1585114881.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 25, 2020 at 05:41:18AM +0000, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> It makes no sense to call `./lib-gpg.sh`. Therefore the hash-bang line
> is unnecessary.

I wondered if it might be useful to identify the file for editors, etc.
But "*.sh" is quite sufficient, and we already stripped most of these
out long ago in b54a31243b (t/lib-*.sh: drop executable bit,
2020-03-26).

There's some other related cleanup. I'll prepare a separate series.

-Peff
