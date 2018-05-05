Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 066D3200B9
	for <e@80x24.org>; Sat,  5 May 2018 18:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751270AbeEESLM (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 May 2018 14:11:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:57164 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751206AbeEESLM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 May 2018 14:11:12 -0400
Received: (qmail 12283 invoked by uid 109); 5 May 2018 18:11:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 05 May 2018 18:11:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12006 invoked by uid 111); 5 May 2018 18:11:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 05 May 2018 14:11:14 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 05 May 2018 14:11:10 -0400
Date:   Sat, 5 May 2018 14:11:10 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pack-objects: validation and documentation about
 unreachable options
Message-ID: <20180505181109.GA17700@sigill.intra.peff.net>
References: <20180505084716.2345-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180505084716.2345-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 05, 2018 at 10:47:16AM +0200, Nguyễn Thái Ngọc Duy wrote:

> These options are added in [1] [2] [3]. All these depend on running
> rev-list internally which is normally true since they are always used
> with "--all --objects" which implies --revs. But let's keep this
> dependency explicit.
> 
> While at there, add documentation for them. These are mostly used
> internally by git-repack. But it's still good to not chase down the
> right commit message to know how they work.

Yeah, this all make sense to me. Thanks for documenting this.

-Peff
