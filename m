Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4422B1F453
	for <e@80x24.org>; Sat, 29 Sep 2018 06:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbeI2N0I (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 09:26:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:36056 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727393AbeI2N0H (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 09:26:07 -0400
Received: (qmail 7715 invoked by uid 109); 29 Sep 2018 06:58:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 29 Sep 2018 06:58:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4377 invoked by uid 111); 29 Sep 2018 06:58:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 29 Sep 2018 02:58:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 29 Sep 2018 02:58:49 -0400
Date:   Sat, 29 Sep 2018 02:58:49 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        jeffhost@microsoft.com
Subject: Re: [PATCH] config.txt: correct the note about
 uploadpack.packObjectsHook
Message-ID: <20180929065849.GA2174@sigill.intra.peff.net>
References: <20180929065056.9960-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180929065056.9960-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 29, 2018 at 08:50:56AM +0200, Nguyễn Thái Ngọc Duy wrote:

> Document for uploadpack.packObjectsHook is added in [1] and consists
> of two paragraphs, the second one is quite important about where this
> variable can stay.
> 
> When the paragraph about uploadpack.allowFilter is added in [2], it's
> added in between the two paragraphs. This makes the "this is non-repo
> level config" note incorrectly apply to allowFilter instead of
> packObjectsHook. Move allowFilter paragraph down to fix this.

Nice catch, and the patch looks obviously correct. Thanks.

-Peff
