Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6253C433C1
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 11:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D27761A0F
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 11:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhCZLGb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 07:06:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:49786 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230022AbhCZLGD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 07:06:03 -0400
Received: (qmail 32200 invoked by uid 109); 26 Mar 2021 11:06:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 26 Mar 2021 11:06:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4727 invoked by uid 111); 26 Mar 2021 11:06:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 26 Mar 2021 07:06:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 26 Mar 2021 07:06:02 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] small doc make and lint fixes
Message-ID: <YF3AGsFFX3FQ1/ew@coredump.intra.peff.net>
References: <cover-0.6-00000000000-20210326T103454Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-0.6-00000000000-20210326T103454Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 26, 2021 at 11:36:45AM +0100, Ævar Arnfjörð Bjarmason wrote:

> A small stand-alone series of doc infrastructure fixes. 5/6 fixes an
> interesting bug that's been missed since doc-diff was introduced.

I'm not sure what you mean about doc-diff here. Patch 5 (of 5?) doesn't
seem related. Patch 4 is related only tangentially, in that you might
have more stuff in your Documentation directory.

That said...

>   Documentation/Makefile: make $(wildcard howto/*.txt) a var
>   Documentation/Makefile: make $(wildcard <doc deps>) a var
>   doc lint: Perl "strict" and "warnings" in lint-gitlink.perl

These three look obviously correct.

>   doc lint: fix bugs in, simplify and improve lint script
>   doc lint: lint and fix missing "GIT" end sections

These two seem fine, though I left some comments for possible
improvements.

-Peff
