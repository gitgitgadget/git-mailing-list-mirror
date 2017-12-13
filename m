Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 941201F406
	for <e@80x24.org>; Wed, 13 Dec 2017 00:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753153AbdLMAtR (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 19:49:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:38440 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752943AbdLMAtP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 19:49:15 -0500
Received: (qmail 22785 invoked by uid 109); 13 Dec 2017 00:49:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Dec 2017 00:49:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20475 invoked by uid 111); 13 Dec 2017 00:49:33 -0000
Received: from pool-74-108-117-248.nycmny.fios.verizon.net (HELO sigill.intra.peff.net) (74.108.117.248)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Tue, 12 Dec 2017 19:49:33 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Dec 2017 19:49:07 -0500
Date:   Tue, 12 Dec 2017 19:49:07 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] transport: remove unused "push" in vtable
Message-ID: <20171213004907.GA10984@sigill.intra.peff.net>
References: <20171212231056.256585-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171212231056.256585-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 12, 2017 at 03:10:56PM -0800, Jonathan Tan wrote:

> After commit 0d0bac67ce3b ("transport: drop support for git-over-rsync",
> 2016-02-01), no transport in Git populates the "push" entry in the
> transport vtable. Remove this entry.

Yay. Thanks for cleaning this up.

-Peff
