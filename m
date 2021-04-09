Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDE3C433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 15:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B019610A7
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 15:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbhDIPNg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 11:13:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:46248 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233915AbhDIPNg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 11:13:36 -0400
Received: (qmail 31564 invoked by uid 109); 9 Apr 2021 15:13:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 09 Apr 2021 15:13:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12357 invoked by uid 111); 9 Apr 2021 15:13:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 09 Apr 2021 11:13:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 9 Apr 2021 11:13:22 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/3] config: rename `git_etc_config()`
Message-ID: <YHBvErq/5GfiHFSN@coredump.intra.peff.net>
References: <a23382059bb57022dd1e40d1c2c9a11307b0ff3b.1617891426.git.ps@pks.im>
 <cover.1617975637.git.ps@pks.im>
 <da0b8ce6f02d9d182446671cc06b9ee1cda77785.1617975637.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <da0b8ce6f02d9d182446671cc06b9ee1cda77785.1617975637.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 09, 2021 at 03:43:21PM +0200, Patrick Steinhardt wrote:

> The `git_etc_gitconfig()` function retrieves the system-level path of
> the configuration file. We're about to introduce a way to override it
> via an environment variable, at which point the name of this function
> would start to become misleading.
> 
> Rename the function to `git_system_config()` as a preparatory step.

Looks good. This name has been a minor annoyance for years. :)

-Peff
