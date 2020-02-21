Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BFCC11D24
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 05:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 647E8208C4
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 05:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgBUF0e (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Feb 2020 00:26:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:50056 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725800AbgBUF0e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Feb 2020 00:26:34 -0500
Received: (qmail 15729 invoked by uid 109); 21 Feb 2020 05:26:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 21 Feb 2020 05:26:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16109 invoked by uid 111); 21 Feb 2020 05:35:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Feb 2020 00:35:36 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Feb 2020 00:26:33 -0500
From:   Jeff King <peff@peff.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 1/2] submodule--helper: use C99 named initializer
Message-ID: <20200221052633.GA1280313@coredump.intra.peff.net>
References: <20200221031027.204486-1-emilyshaffer@google.com>
 <20200221031027.204486-2-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200221031027.204486-2-emilyshaffer@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 20, 2020 at 07:10:26PM -0800, Emily Shaffer wrote:

> Start using a named initializer list for SUBMODULE_UPDATE_CLONE_INIT, as
> the struct is becoming cumbersome for a typical struct initializer list.

Much nicer. :) I manually compared the struct declaration to the
existing initializer to double-check that you counted the offsets
correctly, and all looks good.

-Peff
