Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F73C83005
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 03:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA778206D9
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 03:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgD1DgM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 23:36:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:41778 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726047AbgD1DgM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 23:36:12 -0400
Received: (qmail 17748 invoked by uid 109); 28 Apr 2020 03:36:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 28 Apr 2020 03:36:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30605 invoked by uid 111); 28 Apr 2020 03:47:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 27 Apr 2020 23:47:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 27 Apr 2020 23:36:11 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [DRAFT] What's cooking in git.git
Message-ID: <20200428033611.GB2369457@coredump.intra.peff.net>
References: <xmqq5zdk5rym.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5zdk5rym.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 27, 2020 at 06:17:37PM -0700, Junio C Hamano wrote:

> * jk/build-with-right-curl (2020-04-05) 3 commits
>  - Makefile: avoid running curl-config unnecessarily
>  - Makefile: use curl-config --cflags
>  - Makefile: avoid running curl-config multiple times
> 
>  The build procedure did not use the libcurl library and its include
>  files correctly for a custom-built installation.
> 
>  On hold.
>  cf. <20200404145829.GB679473@coredump.intra.peff.net>

I think this can be un-held; we had a conversation after the linked
message:

  https://lore.kernel.org/git/xmqqzhbc4e0s.fsf@gitster.c.googlers.com/

-Peff
