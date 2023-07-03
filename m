Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9DEEB64DC
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 05:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjGCFNT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 01:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjGCFNR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 01:13:17 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF69AA7
        for <git@vger.kernel.org>; Sun,  2 Jul 2023 22:13:16 -0700 (PDT)
Received: (qmail 4666 invoked by uid 109); 3 Jul 2023 05:13:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 Jul 2023 05:13:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1971 invoked by uid 111); 3 Jul 2023 05:13:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Jul 2023 01:13:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Jul 2023 01:13:15 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 01/16] refs.c: rename `ref_filter`
Message-ID: <20230703051315.GA3502534@coredump.intra.peff.net>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1687270849.git.me@ttaylorr.com>
 <c12def5a30a671590835b70ee3dbd158d1eb5e61.1687270849.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c12def5a30a671590835b70ee3dbd158d1eb5e61.1687270849.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 20, 2023 at 10:21:00AM -0400, Taylor Blau wrote:

> From: Jeff King <peff@peff.net>
> 
> The refs machinery has its own implementation of a `ref_filter` (used by
> `for-each-ref`), which is distinct from the `ref-filler.h` API (also
> used by `for-each-ref`, among other things).

Small typo here: s/filler/filter/

-Peff
