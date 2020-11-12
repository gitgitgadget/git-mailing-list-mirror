Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20820C388F7
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 20:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA3CF21D91
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 20:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbgKLUti (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 15:49:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:56404 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727138AbgKLUti (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 15:49:38 -0500
Received: (qmail 22126 invoked by uid 109); 12 Nov 2020 20:49:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 12 Nov 2020 20:49:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1960 invoked by uid 111); 12 Nov 2020 20:49:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Nov 2020 15:49:37 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 12 Nov 2020 15:49:37 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 0/2] Retire git-parse-remote
Message-ID: <20201112204937.GB707750@coredump.intra.peff.net>
References: <xmqqwnyr4zv8.fsf@gitster.c.googlers.com>
 <20201112203155.3342586-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201112203155.3342586-1-gitster@pobox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 12, 2020 at 12:31:53PM -0800, Junio C Hamano wrote:

> This is based on Ævar's 5-patch series, which removed unused bits
> from git-parse-remote one by one, before finally moving the remnant
> to the only user to remove the file.
> 
> Earlier I suggested an alternative arrangement of the series to just
> lift what is still in use and then discard the rest without even
> splitting them out into separate commits---it is easy to see what's
> not used by grepping for names of the helper functions.

FWIW, this arrangement makes much more sense to me. But I am happy with
either (as long as the file is fully deleted in the end ;) ).

-Peff
