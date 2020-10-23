Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB876C388F9
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 08:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A2E72192A
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 08:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S375722AbgJWI1n (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 04:27:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:40272 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S374624AbgJWI1n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 04:27:43 -0400
Received: (qmail 27417 invoked by uid 109); 23 Oct 2020 08:27:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 23 Oct 2020 08:27:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17407 invoked by uid 111); 23 Oct 2020 08:27:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 23 Oct 2020 04:27:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 23 Oct 2020 04:27:41 -0400
From:   Jeff King <peff@peff.net>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] documentation symlink restrictions for .git* files
Message-ID: <20201023082741.GC4012156@coredump.intra.peff.net>
References: <20201005071751.GA2290770@coredump.intra.peff.net>
 <20201005121609.GA2907272@coredump.intra.peff.net>
 <6c0a0036-e217-a334-2a74-dd59a4592c1f@iee.email>
 <20201023081711.GB4012156@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201023081711.GB4012156@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 23, 2020 at 04:17:11AM -0400, Jeff King wrote:

> Subject: [PATCH] documentation symlink restrictions for .git* files

Oops, that should be "document symlink" of course.

-Peff
