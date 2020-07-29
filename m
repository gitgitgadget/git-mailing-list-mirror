Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B7BC433DF
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 00:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FD14207FC
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 00:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730516AbgG2AGa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 20:06:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:40744 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730434AbgG2AG3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 20:06:29 -0400
Received: (qmail 31722 invoked by uid 109); 29 Jul 2020 00:06:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 29 Jul 2020 00:06:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31590 invoked by uid 111); 29 Jul 2020 00:06:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Jul 2020 20:06:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Jul 2020 20:06:28 -0400
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH 0/11] renaming argv_array
Message-ID: <20200729000628.GB1623001@coredump.intra.peff.net>
References: <20200728202124.GA1021264@coredump.intra.peff.net>
 <CA+P7+xqrV7yvQ2XihDnjuuT5Ro0_qvb4WS6tNH2GGn5DQzoLNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xqrV7yvQ2XihDnjuuT5Ro0_qvb4WS6tNH2GGn5DQzoLNw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 28, 2020 at 03:45:08PM -0700, Jacob Keller wrote:

> One thing I thought I would see but I guess we simply don't have one
> is a technical doc that details the strvec. I guess we just never had
> one for argv_array? Probably worth adding one at some point.

It all got moved into the header file in 971b1f24a2 (argv-array: move
doc to argv-array.h, 2019-11-17). It got the same s/argv_array/strvec/
as the code in patch 2. I think what's there is pretty reasonable, but
patches welcome if you have suggestions about what could be added. :)

-Peff
