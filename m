Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 838BC1F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 08:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389398AbeKPTBl (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 14:01:41 -0500
Received: from cloud.peff.net ([104.130.231.41]:41832 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727413AbeKPTBl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 14:01:41 -0500
Received: (qmail 29264 invoked by uid 109); 16 Nov 2018 08:50:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 16 Nov 2018 08:50:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25348 invoked by uid 111); 16 Nov 2018 08:49:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 16 Nov 2018 03:49:40 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Nov 2018 03:50:17 -0500
Date:   Fri, 16 Nov 2018 03:50:17 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, larsxschneider@gmail.com,
        sandals@crustytoothpaste.net, me@ttaylorr.com, jrnieder@gmail.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH v3 00/11] fast export and import fixes and features
Message-ID: <20181116085016.GA20828@sigill.intra.peff.net>
References: <20181114002600.29233-1-newren@gmail.com>
 <20181116075956.27047-1-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181116075956.27047-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 15, 2018 at 11:59:45PM -0800, Elijah Newren wrote:

> This is a series of small fixes and features for fast-export and
> fast-import, mostly on the fast-export side.
> 
> Changes since v2 (full range-diff below):
>   * Dropped the final patch; going to try to use Peff's suggestion of
>     rev-list and diff-tree to get what I need instead
>   * Inserted a new patch at the beginning to convert pre-existing sha1
>     stuff to oid (rename sha1_to_hex() -> oid_to_hex(), rename
>     anonymize_sha1() to anonymize_oid(), etc.)
>   * Modified other patches in the series to add calls to oid_to_hex() rather
>     than sha1_to_hex()

Thanks, these changes all look good to me. I have no more nits to pick.
:)

-Peff
