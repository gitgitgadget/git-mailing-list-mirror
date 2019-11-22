Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F26C432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 12:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7874C20715
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 12:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbfKVMxg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 07:53:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:57938 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727090AbfKVMxg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 07:53:36 -0500
Received: (qmail 21019 invoked by uid 109); 22 Nov 2019 12:53:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 22 Nov 2019 12:53:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24617 invoked by uid 111); 22 Nov 2019 12:57:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 22 Nov 2019 07:57:27 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 22 Nov 2019 07:53:35 -0500
From:   Jeff King <peff@peff.net>
To:     "Szelp, A. Sz." <a.sz.szelp@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: How to fetch all tags in the history of selected branch, but
 only those tags?
Message-ID: <20191122125335.GA20732@sigill.intra.peff.net>
References: <CAGn30R_C0BDCF-v0Ok5ekto9LK9wHUfHaKQi94wrKbaWaX6ezw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGn30R_C0BDCF-v0Ok5ekto9LK9wHUfHaKQi94wrKbaWaX6ezw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 22, 2019 at 10:58:07AM +0100, Szelp, A. Sz. wrote:

> However doing `git fetch origin master` I do *not* get any tags. Doing
> `--tags` on the other hand fetches *all* of the tags, defying the
> benefit spelled out in " the effect is to fetch tags that point at
> branches that you are interested in".
> 
> What am I missing? Is this indeed a bug (either in implementation or
> in documentation), or am I missing something obvious. Also, how can I
> force the desired behaviour (fetch the tags in the history, but only
> those).

This was discussed recently in:

  https://public-inbox.org/git/alpine.LSU.2.20.1910021431130.32588@cpza.bfz-tzou.qr/

-Peff
