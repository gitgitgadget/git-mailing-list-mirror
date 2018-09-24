Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 939061F453
	for <e@80x24.org>; Mon, 24 Sep 2018 18:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbeIYAWz (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Sep 2018 20:22:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:57550 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728455AbeIYAWy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Sep 2018 20:22:54 -0400
Received: (qmail 5379 invoked by uid 109); 24 Sep 2018 18:19:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Sep 2018 18:19:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28813 invoked by uid 111); 24 Sep 2018 18:19:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 24 Sep 2018 14:19:13 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Sep 2018 14:19:28 -0400
Date:   Mon, 24 Sep 2018 14:19:28 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git help: promote 'git help -av'
Message-ID: <20180924181927.GB25341@sigill.intra.peff.net>
References: <20180922174707.16498-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180922174707.16498-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 22, 2018 at 07:47:07PM +0200, Nguyễn Thái Ngọc Duy wrote:

> When you type "git help" (or just "git") you are greeted with a list
> with commonly used commands and their short description and are
> suggested to use "git help -a" or "git help -g" for more details.
> 
> "git help -av" would be more friendly and inline with what is shown
> with "git help" since it shows list of commands with description as
> well, and commands are properly grouped.

I agree that "help -av" is likely to be more friendly. I kind of wonder
if it should just be the default for "-a". Do we have any obligation not
to change the format of that output?

Assuming we want to keep "-a" and "-av" as-is, your patch seems quite
sensible to me.

-Peff
