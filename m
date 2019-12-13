Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E59C7CFD2
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC4224741
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbfLMRjA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 12:39:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:46136 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728413AbfLMRjA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 12:39:00 -0500
Received: (qmail 2634 invoked by uid 109); 13 Dec 2019 17:38:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Dec 2019 17:38:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25313 invoked by uid 111); 13 Dec 2019 17:43:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 13 Dec 2019 12:43:27 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 13 Dec 2019 12:38:58 -0500
From:   Jeff King <peff@peff.net>
To:     Charles Diza <chdiza@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Regression in 2.24.1 wrt progress indication
Message-ID: <20191213173858.GA117158@coredump.intra.peff.net>
References: <20191213172835.GA2315@349209-PHI-GMNO-CLAHS>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191213172835.GA2315@349209-PHI-GMNO-CLAHS>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 13, 2019 at 12:28:35PM -0500, Charles Diza wrote:

> I reported a bug in progress display in git 2.23.0 earlier this year
> in August.  This bug got fixed:
> https://public-inbox.org/git/20191002154734.GC6116@sigill.intra.peff.net/
> 
> (See the earlier parts of that thread for the bug report.)
> 
> I am sorry to report that this bug has returned in 2.24.1.

The bug in question typically showed due to the server side of the
connection. Do you see it during a fetch (or pull) or push? If so, what
server are you using? Is it possible that that server upgraded recently,
and it has nothing to do with what version you're running on the client?

-Peff
