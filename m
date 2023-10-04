Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C908E7B611
	for <git@archiver.kernel.org>; Wed,  4 Oct 2023 13:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242548AbjJDNNT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Oct 2023 09:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbjJDNNS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2023 09:13:18 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B754A1
        for <git@vger.kernel.org>; Wed,  4 Oct 2023 06:13:15 -0700 (PDT)
Received: (qmail 7246 invoked by uid 109); 4 Oct 2023 13:13:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 04 Oct 2023 13:13:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4849 invoked by uid 111); 4 Oct 2023 13:13:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 04 Oct 2023 09:13:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 4 Oct 2023 09:13:14 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2] builtin/repack.c: avoid making cruft packs preferred
Message-ID: <20231004131314.GB607079@coredump.intra.peff.net>
References: <19d9aae08eab05c6b5dda4c2090236b1c3f62998.1696349955.git.me@ttaylorr.com>
 <035393935108d02aaf8927189b05102f4f74f340.1696370003.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <035393935108d02aaf8927189b05102f4f74f340.1696370003.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 03, 2023 at 05:54:19PM -0400, Taylor Blau wrote:

> A small re-roll of the original patch, removing a few paragraphs from
> the proposed log message that are irrelevant and impossible to produce
> in today's git.git.
> 
> For more details, see <ZRyNHRf+tQwV+T6P@nand.local>.

Thanks, this looks good to me, and the explanation in the linked message
makes sense.

-Peff
