Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7A5C4332D
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 16:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5759F2072D
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 16:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgCSQe0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 12:34:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:44042 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727655AbgCSQe0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 12:34:26 -0400
Received: (qmail 26042 invoked by uid 109); 19 Mar 2020 16:34:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Mar 2020 16:34:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28673 invoked by uid 111); 19 Mar 2020 16:44:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 19 Mar 2020 12:44:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 19 Mar 2020 12:34:25 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/6] fix test failure with busybox
Message-ID: <20200319163425.GH3513282@coredump.intra.peff.net>
References: <cover.1584625896.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1584625896.git.congdanhqx@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 19, 2020 at 09:00:01PM +0700, Đoàn Trần Công Danh wrote:

> Despite some non-compiance from busybox's sh(1), grep(1), diff(1),
> Alpine Linux is still a popular choice for container these days.
> 
> Fix false-positive failure in testsuite when run in Alpine Linux.

Thanks, these all looked like sensible directions. I left a few small
comments that I think are worth addressing.

-Peff
