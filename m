Return-Path: <SRS0=UYkv=ZZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104B9C432C3
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 15:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1AFC206EC
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 15:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfLCPjL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Dec 2019 10:39:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:37454 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725997AbfLCPjL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Dec 2019 10:39:11 -0500
Received: (qmail 9762 invoked by uid 109); 3 Dec 2019 15:39:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Dec 2019 15:39:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14251 invoked by uid 111); 3 Dec 2019 15:43:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Dec 2019 10:43:16 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 3 Dec 2019 10:39:10 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 0/2] Advice upon clone --recurse-submodules --reference
Message-ID: <20191203153910.GA6116@sigill.intra.peff.net>
References: <cover.1574731649.git.jonathantanmy@google.com>
 <cover.1575316490.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1575316490.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 02, 2019 at 11:57:50AM -0800, Jonathan Tan wrote:

> Thanks everyone! Here's an updated v2 following Peff's suggestions on
> how to write the advice part.

Thanks, this looks good to me.

I think Junio and I both wondered if the default should be flipped to
"info", but I don't feel strongly about it, and this seems like an
improvement in the meantime.

-Peff
