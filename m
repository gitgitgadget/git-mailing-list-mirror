Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2063ECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 20:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiH3UOR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 16:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiH3UOP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 16:14:15 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C49564F0
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 13:14:14 -0700 (PDT)
Received: (qmail 7610 invoked by uid 109); 30 Aug 2022 20:14:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Aug 2022 20:14:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29155 invoked by uid 111); 30 Aug 2022 20:14:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Aug 2022 16:14:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 30 Aug 2022 16:14:13 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] format-patch: allow forcing the use of in-body
 From: header
Message-ID: <Yw5vlTCJQCovVbAl@coredump.intra.peff.net>
References: <20220826213203.3258022-1-gitster@pobox.com>
 <20220829213837.13849-1-gitster@pobox.com>
 <20220829213837.13849-3-gitster@pobox.com>
 <Yw5t9mfaIi647Qbl@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yw5t9mfaIi647Qbl@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 30, 2022 at 04:07:18PM -0400, Jeff King wrote:

> All that said, I don't care _too_ strongly about it. I do suspect the
> feature might be better placed in send-email (or possibly in addition).
> If you are using send-email, then I think you're not supposed to use
> "--from" with format-patch at all, and you have no way of accessing this
> feature.

This "not supposed to" came from me looking at the documentation. But
this discussion implies that it's maybe not that big a deal:

  https://lore.kernel.org/git/xmqq8twlqwan.fsf@gitster.mtv.corp.google.com/

Apparently we were considering enabling "--from" by default, but I don't
think that ever happened.

-Peff
