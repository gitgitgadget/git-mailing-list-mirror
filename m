Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB18C433E0
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 17:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10FA864FC6
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 17:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbhCJRJR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 12:09:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:58758 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232335AbhCJRI5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 12:08:57 -0500
Received: (qmail 6491 invoked by uid 109); 10 Mar 2021 17:08:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Mar 2021 17:08:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23472 invoked by uid 111); 10 Mar 2021 17:08:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Mar 2021 12:08:56 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 10 Mar 2021 12:08:55 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6 00/39] SHA-256, part 3/3
Message-ID: <YEj9J5I7eInl3BAx@coredump.intra.peff.net>
References: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
 <20200729231428.3658647-1-sandals@crustytoothpaste.net>
 <8735x3i59m.fsf@evledraar.gmail.com>
 <CABPp-BFFLichkBY6Jh2qzE-=Md2eU5tZzHm4aVQVnVpJFD7b0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BFFLichkBY6Jh2qzE-=Md2eU5tZzHm4aVQVnVpJFD7b0w@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 10, 2021 at 08:36:15AM -0800, Elijah Newren wrote:

> Honestly not sure it's worth bothering fixing filter-branch at this
> point, given the strong WARNINGs we added to it.  If anything, I'd
> just add another warning to the pile for this issue.  If folks really
> still want/need filter-branch once SHA-256 is the only option, I'm
> sure they'll be motivated to make the necessary fixes (or just use/fix
> filter-repo's filter-branch-ish).

You're probably right that it's not a good use of time, but I just sent
a series fixing it. It was one of those cases where I was like "oh, it's
probably just X". And then "no, wait...", and before I knew it I had
wasted an hour fixing filter-branch. ;)

-Peff
