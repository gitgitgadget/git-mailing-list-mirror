Return-Path: <SRS0=6g9E=62=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72454CA90AF
	for <git@archiver.kernel.org>; Tue, 12 May 2020 19:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5922B2494F
	for <git@archiver.kernel.org>; Tue, 12 May 2020 19:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730496AbgELTIe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 15:08:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:44532 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725554AbgELTIe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 May 2020 15:08:34 -0400
Received: (qmail 30820 invoked by uid 109); 12 May 2020 19:08:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 12 May 2020 19:08:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9191 invoked by uid 111); 12 May 2020 19:08:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 May 2020 15:08:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 May 2020 15:08:31 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] t5551: test that GIT_TRACE_CURL redacts password
Message-ID: <20200512190831.GA54565@coredump.intra.peff.net>
References: <cover.1589218693.git.jonathantanmy@google.com>
 <bee4fc7241596a6b4206fa8b52dfdaea88180f37.1589218693.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bee4fc7241596a6b4206fa8b52dfdaea88180f37.1589218693.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 11, 2020 at 10:43:09AM -0700, Jonathan Tan wrote:

> Verify that when GIT_TRACE_CURL is set, Git prints out "Authorization:
> Basic <redacted>" instead of the base64-encoded authorization details.

Yeah, it's definitely worth testing this. The patch looks good to me.

-Peff
