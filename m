Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E132AC433ED
	for <git@archiver.kernel.org>; Sat, 15 May 2021 09:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA711613DB
	for <git@archiver.kernel.org>; Sat, 15 May 2021 09:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbhEOJkn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 May 2021 05:40:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:55466 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231132AbhEOJkj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 May 2021 05:40:39 -0400
Received: (qmail 23446 invoked by uid 109); 15 May 2021 09:39:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 15 May 2021 09:39:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8357 invoked by uid 111); 15 May 2021 09:39:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 15 May 2021 05:39:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 15 May 2021 05:39:24 -0400
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 01/11] doc: allow the user to provide ASCIIDOC_EXTRA
Message-ID: <YJ+WzATLCM8SW2GH@coredump.intra.peff.net>
References: <20210514121435.504423-1-felipe.contreras@gmail.com>
 <20210514121435.504423-2-felipe.contreras@gmail.com>
 <YJ+VGKUa0Kk3BRWQ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YJ+VGKUa0Kk3BRWQ@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 15, 2021 at 05:32:08AM -0400, Jeff King wrote:

> On Fri, May 14, 2021 at 07:14:25AM -0500, Felipe Contreras wrote:
> 
> > Without `override` all additions will be ignored by make.
> 
> That's true of all of our Makefile variables. Is there a particular
> reason to give this one special treatment?

To go into further detail: usually we distinguish variables we use
internally from user-facing ones, and include the latter in the former.
I see a later patch wants to start passing ASCIIDOC_EXTRA on the
command-line, and we'd use two variables for that.

-Peff
