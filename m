Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82ABFC07E97
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 10:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 552A261628
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 10:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhGCKwy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Jul 2021 06:52:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:40676 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230114AbhGCKwx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jul 2021 06:52:53 -0400
Received: (qmail 2463 invoked by uid 109); 3 Jul 2021 10:50:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 03 Jul 2021 10:50:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 515 invoked by uid 111); 3 Jul 2021 10:50:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 03 Jul 2021 06:50:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 3 Jul 2021 06:50:18 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] config: add default aliases
Message-ID: <YOBA6s7wXUVmh++d@coredump.intra.peff.net>
References: <20210702100506.1422429-1-felipe.contreras@gmail.com>
 <20210702100506.1422429-6-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210702100506.1422429-6-felipe.contreras@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 02, 2021 at 05:05:06AM -0500, Felipe Contreras wrote:

> These are all the aliases everyone agrees are essential.
> 
> Virtually all VCS in the world have aliases, except git, so let's change
> that.

For anyone reviewing or discussing, here's an older thread on the same
topic:

  https://lore.kernel.org/git/1379791221-29925-1-git-send-email-felipe.contreras@gmail.com/

(I don't mean to imply that we can't revisit old decisions; but some of
the thoughts there are worth considering as input).

-Peff
