Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564C0C05027
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 20:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjATUz1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 15:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjATUz0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 15:55:26 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128484B49E
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 12:55:25 -0800 (PST)
Received: (qmail 25972 invoked by uid 109); 20 Jan 2023 20:55:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 20 Jan 2023 20:55:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13856 invoked by uid 111); 20 Jan 2023 20:55:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Jan 2023 15:55:26 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 20 Jan 2023 15:55:24 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH] Makefile: suppress annotated leaks with certain ASan
 options
Message-ID: <Y8r/vIg3+UziR5X5@coredump.intra.peff.net>
References: <b1efe56ab5193d5505ccb9334f7d15e1795c27fb.1674240261.git.me@ttaylorr.com>
 <Y8r2Tn75g52YTIij@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y8r2Tn75g52YTIij@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 20, 2023 at 03:15:10PM -0500, Jeff King wrote:

> One problem UNLEAK() is that compile-time switch, but whether ASan does
> leak detection is a run-time choice. So you are stuck with either:

Er, this should be "one problem is that UNLEAK() is a compile-time
switch".

-Peff
