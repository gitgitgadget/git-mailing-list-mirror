Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 410A01FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 23:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752001AbdBHXCE (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 18:02:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:51887 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751966AbdBHXCD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 18:02:03 -0500
Received: (qmail 4573 invoked by uid 109); 8 Feb 2017 23:01:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Feb 2017 23:01:48 +0000
Received: (qmail 10663 invoked by uid 111); 8 Feb 2017 23:01:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Feb 2017 18:01:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Feb 2017 18:01:45 -0500
Date:   Wed, 8 Feb 2017 18:01:45 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] rev-list-options.txt: update --all about HEAD
Message-ID: <20170208230145.eayyz7fdj2ha6guo@sigill.intra.peff.net>
References: <20170207133850.14056-1-pclouds@gmail.com>
 <20170208060641.13793-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170208060641.13793-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 08, 2017 at 01:06:41PM +0700, Nguyễn Thái Ngọc Duy wrote:

> This is the document patch for f0298cf1c6 (revision walker: include a
> detached HEAD in --all - 2009-01-16).
> 
> Even though that commit is about detached HEAD, as Jeff pointed out,
> always adding HEAD in that case may have subtle differences with
> --source or --exclude. So the document mentions nothing about the
> detached-ness.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  v2 drops "detached".

Thanks. Seems like an obvious improvement to me.

-Peff
