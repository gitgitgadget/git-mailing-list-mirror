Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795D8C433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 15:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55A4620657
	for <git@archiver.kernel.org>; Mon, 18 May 2020 15:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbgERPmR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 11:42:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:49590 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726958AbgERPmR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 11:42:17 -0400
Received: (qmail 20190 invoked by uid 109); 18 May 2020 15:42:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 18 May 2020 15:42:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3058 invoked by uid 111); 18 May 2020 15:42:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 May 2020 11:42:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 18 May 2020 11:42:16 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] ci/config: correct instruction for CI preferences
Message-ID: <20200518154216.GA41356@coredump.intra.peff.net>
References: <20200518145234.20424-1-congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200518145234.20424-1-congdanhqx@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 18, 2020 at 09:52:34PM +0700, Đoàn Trần Công Danh wrote:

> From e76eec3554 (ci: allow per-branch config for GitHub Actions,
> 2020-05-07), we started to allow contributors decide which branch
> they want to build with GitHub Actions
> by checking for a file named "ci/config/allow-ref".
> 
> In order to assist those contributors,
> we provided a sample in "ci/config/allow-refs.sample",
> and instructed them to drop the ".sample",
> then commit that file to their repository.
> 
> We've misspelt the filename in that change.
> Let's fix the spelling.
> 
> While we're at it, also instruct our contributors introduce that new
> file to Git before commit, in case of they've never told Git before.
> 
> Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
> ---
> 
> This is a merge from:
> <20200508180047.GD637136@coredump.intra.peff.net>
> <20200509012304.GB2111@danh.dev>
> 
> It's slipped over the crack.

Yep, looks good. thanks for tying up this loose end.

> Hence, it may need Peff's SoB.
> Cc: Jeff King <peff@peff.net>

Signed-off-by: Jeff King <peff@peff.net>

-Peff
