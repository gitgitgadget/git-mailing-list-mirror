Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16479C47254
	for <git@archiver.kernel.org>; Fri,  8 May 2020 13:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFE0B208CA
	for <git@archiver.kernel.org>; Fri,  8 May 2020 13:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbgEHNIe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 May 2020 09:08:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:41548 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729619AbgEHNId (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 May 2020 09:08:33 -0400
Received: (qmail 9184 invoked by uid 109); 8 May 2020 13:08:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 May 2020 13:08:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27765 invoked by uid 111); 8 May 2020 13:08:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 08 May 2020 09:08:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 8 May 2020 09:08:31 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christopher Warrington via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christopher Warrington <chwarr@microsoft.com>
Subject: Re: [PATCH] bisect: fix replay of CRLF logs
Message-ID: <20200508130831.GB631018@coredump.intra.peff.net>
References: <pull.629.git.1588886980377.gitgitgadget@gmail.com>
 <20200507222510.GA42822@coredump.intra.peff.net>
 <xmqq5zd72vjp.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5zd72vjp.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 07, 2020 at 04:07:54PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The simplest fix is probably to clean up "$file" into another tempfile,
> > and then read from that.
> 
> Or just tell the users do not break the log file (or they can keep
> both halves)?

I am OK with that, too. :)

-Peff
