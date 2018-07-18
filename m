Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A366A1F597
	for <e@80x24.org>; Wed, 18 Jul 2018 22:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbeGRXdl (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 19:33:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:52002 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727635AbeGRXdl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 19:33:41 -0400
Received: (qmail 24198 invoked by uid 109); 18 Jul 2018 22:53:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 18 Jul 2018 22:53:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5121 invoked by uid 111); 18 Jul 2018 22:53:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 18 Jul 2018 18:53:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jul 2018 18:53:34 -0400
Date:   Wed, 18 Jul 2018 18:53:34 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/3] check_replace_refs: rename to read_replace_refs
Message-ID: <20180718225334.GC21451@sigill.intra.peff.net>
References: <20180718204424.GA1483@sigill.intra.peff.net>
 <20180718204519.GB31816@sigill.intra.peff.net>
 <xmqqh8kwi2p7.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh8kwi2p7.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 18, 2018 at 03:44:36PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > This was added as a NEEDSWORK in 3c36d7de2 (replace-object:
> 
> I'll do s/3c36d7de2/c&/; while queuing.

Oops, vi strikes again, I think.

> Like you, I do not think one is vastly better than the other between
> these two names, but since a patch has been written, so ...

:)

-Peff
