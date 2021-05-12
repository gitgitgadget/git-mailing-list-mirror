Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2B5C433ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 20:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E096611AB
	for <git@archiver.kernel.org>; Wed, 12 May 2021 20:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384611AbhELUiV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 16:38:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:52700 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343541AbhELTyS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 15:54:18 -0400
Received: (qmail 29105 invoked by uid 109); 12 May 2021 19:53:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 May 2021 19:53:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8748 invoked by uid 111); 12 May 2021 19:53:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 May 2021 15:53:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 12 May 2021 15:53:08 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: make PERL_DEFINES recursively expanded
Message-ID: <YJwyJKxXJ5Oe+EYD@coredump.intra.peff.net>
References: <xmqqr1idn41e.fsf@gitster.g>
 <patch-1.1-92571a8cf7-20210512T094803Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.1-92571a8cf7-20210512T094803Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 12, 2021 at 11:49:44AM +0200, Ævar Arnfjörð Bjarmason wrote:

> Since 07d90eadb50 (Makefile: add Perl runtime prefix support,
> 2018-04-10) PERL_DEFINES has been a simply-expanded variable, let's
> make it recursively expanded instead.
> 
> This change doesn't matter for the correctness of the logic. Whether
> we used simply-expanded or recursively expanded didn't change what we
> wrote out in GIT-PERL-DEFINES, but being consistent with other rules
> makes this easier to understand.

Thanks for following up on this. I think it's worth doing.

-Peff
