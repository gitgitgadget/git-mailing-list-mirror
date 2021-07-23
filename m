Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E5DC4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 10:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F4F360EE2
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 10:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbhGWKH1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 06:07:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:55730 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231519AbhGWKH1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 06:07:27 -0400
Received: (qmail 11285 invoked by uid 109); 23 Jul 2021 10:48:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 23 Jul 2021 10:48:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24284 invoked by uid 111); 23 Jul 2021 10:48:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 23 Jul 2021 06:48:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 23 Jul 2021 06:47:59 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Kristof Provost <Kristof@provost-engineering.be>,
        Taylor Blau <me@ttaylorr.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v3 0/5] Makefile: "make tags" fixes & cleanup
Message-ID: <YPqeX/edrMfYbURa@coredump.intra.peff.net>
References: <cover-0.5-0000000000-20210629T110837Z-avarab@gmail.com>
 <cover-0.5-00000000000-20210721T231900Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-0.5-00000000000-20210721T231900Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 22, 2021 at 01:23:01AM +0200, Ævar Arnfjörð Bjarmason wrote:

> The big win here is that none of the tags targets depend on "FORCE"
> anymore, so we'll only re-generate them if our sources change.
> 
> For v2, see
> https://lore.kernel.org/git/cover-0.5-0000000000-20210629T110837Z-avarab@gmail.com/
> 
> This fixes the series per feedback from Jeff King and Ramsay Jones,
> i.e:
> 
>  * In v2 the 3/5 broke things in a way that 4/5 fixed, that's now
>    re-arranged and fixed.

Thanks. Aside from some cscope appending arcana I found, these look good
to me. I have no opinion on "cscope*" versus "cscope.out", except that
it is not worth anybody's time to argue about. :)

-Peff
