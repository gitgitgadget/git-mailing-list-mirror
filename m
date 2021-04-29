Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892E4C433B4
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 20:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54BFC613E1
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 20:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbhD2UFE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 16:05:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:40288 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229960AbhD2UFE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 16:05:04 -0400
Received: (qmail 16161 invoked by uid 109); 29 Apr 2021 20:04:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 29 Apr 2021 20:04:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22277 invoked by uid 111); 29 Apr 2021 20:04:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 29 Apr 2021 16:04:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 29 Apr 2021 16:04:16 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 0/2] git: support separate arg for `--config-env`'s
 value
Message-ID: <YIsRQG7TFtt7MU2k@coredump.intra.peff.net>
References: <cover.1618847606.git.ps@pks.im>
 <cover.1619700731.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1619700731.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 29, 2021 at 02:55:25PM +0200, Patrick Steinhardt wrote:

> this is the second version of this series fixing inconsistencies with
> the `--config-env` parameter. It's only got a single change compared to
> v1, which is to replace `test_i18ngrep` with `grep` as pointed out by
> Ævar.

Thanks, this version looks good to me.

-Peff
