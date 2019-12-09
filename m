Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9EFC43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 07:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B1AD20721
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 07:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfLIHHS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 02:07:18 -0500
Received: from cloud.peff.net ([104.130.231.41]:41768 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727007AbfLIHHS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 02:07:18 -0500
Received: (qmail 18384 invoked by uid 109); 9 Dec 2019 07:07:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 09 Dec 2019 07:07:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18424 invoked by uid 111); 9 Dec 2019 07:11:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Dec 2019 02:11:34 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Dec 2019 02:07:16 -0500
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v3 6/9] csum-file: introduce hashfile_total()
Message-ID: <20191209070716.GF40570@coredump.intra.peff.net>
References: <20191115141541.11149-1-chriscool@tuxfamily.org>
 <20191115141541.11149-7-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191115141541.11149-7-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 15, 2019 at 03:15:38PM +0100, Christian Couder wrote:

> From: Jeff King <peff@peff.net>
> 
> We will need this helper function in a following commit
> to give us total number of bytes fed to the hashfile so far.

Yep, makes sense.

-Peff
