Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1834C20248
	for <e@80x24.org>; Wed,  6 Mar 2019 04:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbfCFE4o (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 23:56:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:40504 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727089AbfCFE4o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 23:56:44 -0500
Received: (qmail 5090 invoked by uid 109); 6 Mar 2019 04:56:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Mar 2019 04:56:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9618 invoked by uid 111); 6 Mar 2019 04:57:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 05 Mar 2019 23:57:01 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Mar 2019 23:56:42 -0500
Date:   Tue, 5 Mar 2019 23:56:42 -0500
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v4 0/2] setup: fix memory leaks with `struct
 repository_format`
Message-ID: <20190306045642.GD6664@sigill.intra.peff.net>
References: <20190226174655.GE19606@sigill.intra.peff.net>
 <cover.1551385992.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1551385992.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 28, 2019 at 09:36:26PM +0100, Martin Ågren wrote:

> This is a follow-up to v3 [1] from about a month ago. Patch 1 is
> unchanged; patch 2 provides some additional documentation of the
> initialization that is required, plus I've gotten rid of the compound
> literal. Range-diff below.

Thanks, this version looks good to me.

-Peff
