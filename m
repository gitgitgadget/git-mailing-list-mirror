Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E9771F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbeJ0PJF (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:09:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:56836 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726672AbeJ0PJF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:09:05 -0400
Received: (qmail 23316 invoked by uid 109); 27 Oct 2018 06:29:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 27 Oct 2018 06:29:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3984 invoked by uid 111); 27 Oct 2018 06:28:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 27 Oct 2018 02:28:25 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 27 Oct 2018 02:29:09 -0400
Date:   Sat, 27 Oct 2018 02:29:09 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH 2/3] ewok_rlw.h: add missing 'inline' to function
 definition
Message-ID: <20181027062909.GB16664@sigill.intra.peff.net>
References: <1a465da6-d139-5880-72ff-c612b42c3b8f@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1a465da6-d139-5880-72ff-c612b42c3b8f@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 27, 2018 at 02:52:05AM +0100, Ramsay Jones wrote:

> The 'ewok_rlw.h' header file contains the rlw_get_run_bit() function
> definition, which is marked as 'static' but not 'inline'. At least when
> compiled by gcc, with the default -O2 optimization level, the function
> is actually inlined and leaves no static version in the ewah_bitmap.o
> and ewah_rlw.o object files. Despite this, add the missing 'inline'
> keyword to better describe the intended behaviour.

Yep, this makes sense. Thanks!

-Peff
