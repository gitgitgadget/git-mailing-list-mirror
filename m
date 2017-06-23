Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6762820282
	for <e@80x24.org>; Fri, 23 Jun 2017 19:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754871AbdFWTfL (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 15:35:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:50992 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754773AbdFWTfK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 15:35:10 -0400
Received: (qmail 12944 invoked by uid 109); 23 Jun 2017 19:35:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 23 Jun 2017 19:35:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18247 invoked by uid 111); 23 Jun 2017 19:35:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Jun 2017 15:35:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Jun 2017 15:35:08 -0400
Date:   Fri, 23 Jun 2017 15:35:08 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 19/29] packed-backend: new module for handling packed
 references
Message-ID: <20170623193508.xjcyqvf32l7wmwzx@sigill.intra.peff.net>
References: <cover.1498200513.git.mhagger@alum.mit.edu>
 <0a7aba93b5f3378df5aa8a3ef342d36cac9d4c6e.1498200513.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0a7aba93b5f3378df5aa8a3ef342d36cac9d4c6e.1498200513.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 23, 2017 at 09:01:37AM +0200, Michael Haggerty wrote:

> Now that the interface between `files_ref_store` and
> `packed_ref_store` is relatively narrow, move the latter into a new
> module, "refs/packed-backend.h" and "refs/packed-backend.c". It still
> doesn't quite implement the `ref_store` interface, but it will soon.
> 
> This commit moves code around and adjusts its visibility, but doesn't
> change anything.

Looks good. Stefan will be happy to know that I used --color-moved to
look at it. ;)

-Peff
