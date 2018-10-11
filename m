Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B91E81F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 13:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbeJKV0L (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 17:26:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:37192 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728193AbeJKV0L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 17:26:11 -0400
Received: (qmail 19135 invoked by uid 109); 11 Oct 2018 13:58:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 11 Oct 2018 13:58:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29774 invoked by uid 111); 11 Oct 2018 13:58:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 11 Oct 2018 09:58:01 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Oct 2018 09:58:51 -0400
Date:   Thu, 11 Oct 2018 09:58:51 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 3/7] test-reach: add rev-list tests
Message-ID: <20181011135850.GC27312@sigill.intra.peff.net>
References: <pull.25.v2.git.gitgitgadget@gmail.com>
 <pull.25.v3.git.gitgitgadget@gmail.com>
 <b0ceb960761329179d14e613343019e7ac207e4d.1537551564.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b0ceb960761329179d14e613343019e7ac207e4d.1537551564.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 21, 2018 at 10:39:30AM -0700, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The rev-list command is critical to Git's functionality. Ensure it
> works in the three commit-graph environments constructed in
> t6600-test-reach.sh. Here are a few important types of rev-list
> operations:
> 
> * Basic: git rev-list --topo-order HEAD
> * Range: git rev-list --topo-order compare..HEAD
> * Ancestry: git rev-list --topo-order --ancestry-path compare..HEAD
> * Symmetric Difference: git rev-list --topo-order compare...HEAD

Makes sense. I'll assume you filled out all those "expect" blocks
correctly.  ;)

-Peff
