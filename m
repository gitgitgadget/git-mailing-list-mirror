Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7D9C433E2
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 17:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36336214F1
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 17:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgIKRII (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 13:08:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:54492 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbgIKPCE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 11:02:04 -0400
Received: (qmail 898 invoked by uid 109); 11 Sep 2020 14:01:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 11 Sep 2020 14:01:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2718 invoked by uid 111); 11 Sep 2020 14:01:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Sep 2020 10:01:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 11 Sep 2020 10:01:19 -0400
From:   Jeff King <peff@peff.net>
To:     Ondrej Pohorelsky <opohorel@redhat.com>
Cc:     git@vger.kernel.org
Subject: Re: Git doesn't honor NO_PROXY environment variable while cloning
Message-ID: <20200911140119.GA2072036@coredump.intra.peff.net>
References: <CA+B51BGRuLfF7FpiK93Wih0XhsC7rJLGjkF2CzrEsUkBEif+jw@mail.gmail.com>
 <20200911135928.GA1986935@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200911135928.GA1986935@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 11, 2020 at 09:59:28AM -0400, Jeff King wrote:

> So I dunno. This seems like a libcurl bug, but it's possible we're feeding
> it data wrong somehow.

I forgot to mention: I'm using libcurl 7.72.0 (the current in debian
unstable). But it also reproduces on my debian stable machine with
libcurl 7.64.0.

-Peff
