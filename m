Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 395AA1F42D
	for <e@80x24.org>; Sat, 12 May 2018 09:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750916AbeELJZD (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 05:25:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:37106 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750827AbeELJZC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 05:25:02 -0400
Received: (qmail 24717 invoked by uid 109); 12 May 2018 09:25:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 12 May 2018 09:25:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13704 invoked by uid 111); 12 May 2018 09:25:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 12 May 2018 05:25:07 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 12 May 2018 05:25:00 -0400
Date:   Sat, 12 May 2018 05:25:00 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 04/12] sequencer.c: use commit-slab to mark seen commits
Message-ID: <20180512092500.GE28279@sigill.intra.peff.net>
References: <20180512080028.29611-1-pclouds@gmail.com>
 <20180512080028.29611-5-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180512080028.29611-5-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 12, 2018 at 10:00:20AM +0200, Nguyễn Thái Ngọc Duy wrote:

> +define_commit_slab(commit_seen, int);

Yay, this one is nice and simple. :) This is what I had hoped for all
along with the slab concept.

-Peff
