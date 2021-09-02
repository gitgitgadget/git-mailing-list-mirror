Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BB2C432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 09:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ADD460F42
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 09:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbhIBJOt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 05:14:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:37242 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233511AbhIBJOt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 05:14:49 -0400
Received: (qmail 21797 invoked by uid 109); 2 Sep 2021 09:13:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Sep 2021 09:13:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22810 invoked by uid 111); 2 Sep 2021 09:13:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 02 Sep 2021 05:13:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 2 Sep 2021 05:13:49 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Carlo Arenas <carenas@gmail.com>, phillip.wood@dunelm.org.uk,
        mackyle@gmail.com, sunshine@sunshineco.com
Subject: Re: [PATCH] gettext: remove optional non-standard parens in N_()
 definition
Message-ID: <YTCVzUKfjQTBFmr5@coredump.intra.peff.net>
References: <YS9RieTeJSFmd6M7@coredump.intra.peff.net>
 <patch-1.1-d24f1df5d49-20210901T112248Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.1-d24f1df5d49-20210901T112248Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 01, 2021 at 01:25:52PM +0200, Ævar Arnfjörð Bjarmason wrote:

> I don't care how this lands exactly, but thin (eye of the beholder and
> all that) that the commit message above is better. Carlo: Feel free to
> steal it partially or entirely, I also made this a "PATCH" instead of
> "RFC PATCH" in case Junio feels like queuing this, then you could
> build your DEVOPTS=pedantic by default here on top.

FWIW, I think it is better, too. :)

One small typo (in addition to the one Eric noted):

> Remove the USE_PARENS_AROUND_GETTEXT_N compile-time option which was
> meant to catch an inadvertent mistakes which is too obscure to
> maintain this facility.

s/mistakes/mistake/

-Peff
