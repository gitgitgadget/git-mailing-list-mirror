Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F9821F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 06:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404889AbfJQGco (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 02:32:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:50540 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2389397AbfJQGco (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 02:32:44 -0400
Received: (qmail 21373 invoked by uid 109); 17 Oct 2019 06:32:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 17 Oct 2019 06:32:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6291 invoked by uid 111); 17 Oct 2019 06:35:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 17 Oct 2019 02:35:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 17 Oct 2019 02:32:43 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, mh@glandium.org
Subject: Re: [PATCH 5/6] index-pack: make resolve_delta() assume base data
Message-ID: <20191017063243.GF10862@sigill.intra.peff.net>
References: <cover.1570663470.git.jonathantanmy@google.com>
 <6fcda102acd550818536c69c41c270a8058050a7.1570663470.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6fcda102acd550818536c69c41c270a8058050a7.1570663470.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 09, 2019 at 04:44:21PM -0700, Jonathan Tan wrote:

> A subsequent commit will make the quantum of work smaller, necessitating
> more locking. This commit allows resolve_delta() to be called outside
> the lock.

OK, that makes sense, I think.

-Peff
