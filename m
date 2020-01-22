Return-Path: <SRS0=mjbR=3L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2F0C32771
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 03:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2DA02071E
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 03:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgAVDws (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 22:52:48 -0500
Received: from cloud.peff.net ([104.130.231.41]:41780 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726605AbgAVDws (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 22:52:48 -0500
Received: (qmail 12510 invoked by uid 109); 22 Jan 2020 03:52:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 22 Jan 2020 03:52:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19173 invoked by uid 111); 22 Jan 2020 03:59:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 21 Jan 2020 22:59:43 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 21 Jan 2020 22:52:47 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 0/5] Documentation for common user misconceptions
Message-ID: <20200122035247.GB18266@coredump.intra.peff.net>
References: <20200122034543.18927-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200122034543.18927-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 22, 2020 at 03:45:38AM +0000, brian m. carlson wrote:

> This is v5 of a series improving the documentation to cover common user
> misconceptions.
> 
> Changes from v4:
> * Add a reference to git(1) for environment variables.
> * Remove duplicated text.
> * Add Peff's sign-off.

Thanks, just looking at the interdiff I think this addresses all of my
comments.

-Peff
