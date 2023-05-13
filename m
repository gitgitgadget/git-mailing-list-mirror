Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F64C77B7F
	for <git@archiver.kernel.org>; Sat, 13 May 2023 00:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240642AbjEMAMC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 20:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjEMAMB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 20:12:01 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F354683
        for <git@vger.kernel.org>; Fri, 12 May 2023 17:11:59 -0700 (PDT)
Received: (qmail 15325 invoked by uid 109); 13 May 2023 00:11:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 13 May 2023 00:11:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27777 invoked by uid 111); 13 May 2023 00:11:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 12 May 2023 20:11:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 12 May 2023 20:11:58 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 2/2] builtin/pack-objects.c: introduce
 `pack.recentObjectsHook`
Message-ID: <20230513001158.GA3814811@coredump.intra.peff.net>
References: <cover.1683847221.git.me@ttaylorr.com>
 <2ce8a79fa4bf98947728da4e6e22304a2f203fac.1683847221.git.me@ttaylorr.com>
 <20230512212456.GA2495860@coredump.intra.peff.net>
 <20230512214542.GB2495860@coredump.intra.peff.net>
 <20230512220117.GA2971903@coredump.intra.peff.net>
 <xmqq4johnnjr.fsf@gitster.g>
 <20230513001117.GA2974285@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230513001117.GA2974285@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 12, 2023 at 08:11:18PM -0400, Jeff King wrote:

> So yeah, I think it may just be a curiosity that nobody noticed and
> bothered to optimize it. I am tempted to work the above into a proper
> patch. We even do something similar already for the reflog expiration
> variables.

Oh, and in case it was not clear: this is all well off Taylor's original
topic. Whatever we do (or don't do) should be its own series.

-Peff
