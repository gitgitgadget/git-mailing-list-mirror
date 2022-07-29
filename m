Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485ABC00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 19:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238385AbiG2TCa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 15:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbiG2TC1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 15:02:27 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6123187363
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 12:02:26 -0700 (PDT)
Received: (qmail 22118 invoked by uid 109); 29 Jul 2022 19:02:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 Jul 2022 19:02:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27809 invoked by uid 111); 29 Jul 2022 19:02:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 29 Jul 2022 15:02:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 29 Jul 2022 15:02:25 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/6] revisions API: fix more memory leaks
Message-ID: <YuQuwVRNrgfWB7SY@coredump.intra.peff.net>
References: <cover-0.6-00000000000-20220713T130511Z-avarab@gmail.com>
 <cover-v2-0.6-00000000000-20220729T082919Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-v2-0.6-00000000000-20220729T082919Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 29, 2022 at 10:31:02AM +0200, Ævar Arnfjörð Bjarmason wrote:

> A late re-roll of this set of revisions API and API user memory leak
> fixes. I think the much simpler code here in 4/6 should address the
> points Jeff King brought up in the v1 review.
> 
> Other than that I renamed the variable in 3/6 s/cp/pending/g, per
> Jeff's suggestion (FWIW "cp" = "copy").

Thanks (and for the explanation regarding t91xx; I did totally miss in
the v1 review that those were removing "FAIL" lines, not "PASS" ones).

I don't think there's anything incorrect here, but I did make a few
cosmetic / explanation suggestions.

-Peff
