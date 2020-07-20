Return-Path: <SRS0=kUNO=A7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2375C433E5
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 17:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEFBF20702
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 17:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389019AbgGTRmE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jul 2020 13:42:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:33564 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388142AbgGTRmE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jul 2020 13:42:04 -0400
Received: (qmail 23581 invoked by uid 109); 20 Jul 2020 17:42:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 20 Jul 2020 17:42:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14769 invoked by uid 111); 20 Jul 2020 17:42:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 20 Jul 2020 13:42:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 20 Jul 2020 13:42:03 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] upload-pack: do not lazy-fetch "have" objects
Message-ID: <20200720174203.GB2046890@coredump.intra.peff.net>
References: <xmqqk0z3gy5y.fsf@gitster.c.googlers.com>
 <20200716180950.2852753-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200716180950.2852753-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 16, 2020 at 11:09:50AM -0700, Jonathan Tan wrote:

> Differences from v1: OBJECT_INFO_QUICK is also used wherever
> OBJECT_INFO_SKIP_FETCH_OBJECT is added.
> 
> Using OBJECT_INFO_QUICK makes sense to me, so here's an updated patch.

Yeah, I think this is reasonable, and the patch looks good to me.

-Peff
