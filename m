Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73485C49361
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 15:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50EB4613D6
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 15:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbhFQP4b (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 11:56:31 -0400
Received: from vps.thesusis.net ([34.202.238.73]:55546 "EHLO vps.thesusis.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231641AbhFQP42 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 11:56:28 -0400
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id 4C95F31924; Thu, 17 Jun 2021 11:53:49 -0400 (EDT)
References: <cover-0.6-00000000000-20210615T161330Z-avarab@gmail.com>
 <60c8db3558fb8_1296f208ac@natae.notmuch>
 <871r93ym8q.fsf@evledraar.gmail.com>
 <60ca6586607f5_602720852@natae.notmuch>
User-agent: mu4e 1.5.13; emacs 27.1
From:   Phillip Susi <phill@thesusis.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH 0/6] doc: replace "alice" and "bob" examples
Date:   Thu, 17 Jun 2021 11:48:00 -0400
In-reply-to: <60ca6586607f5_602720852@natae.notmuch>
Message-ID: <87pmwkh4he.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Felipe Contreras <felipe.contreras@gmail.com> writes:

> I have not read cryptography documentation, so for me Alice and Bob are
> simply two illustrative colleagues.

I have read cryptography documentation and seen Alice and Bob used
commonly.  Am I supposed to be confused if I see those names used in
documentation for non cryptographic software?  If Alice and Bob work
there, why should they not be used here?  Am I missing something?

>> And as argued in 1/6 for those users who /are/ aware of "Alice and Bob"
>> it's needless distraction. Maybe it's just me, but whenever I read
>> references to them I keep waiting for the cryptography angle to be
>> introduced. None of the uses in our documentation reflect that canonical
>> usage.
>
> It's probably not just you, but the vast majority of readers are
> likely not aware of any cryptographic reference.

I find it surprising that anyone would be upset that the names Alice and
Bob were being used in a non cryptographic context.

>> There's also just weird things in our documentation fixed by this
>> series, such as referring to a random file tracked by git as "bob"
>> instead of the more obvious "file.txt".
>
> OK, _that_ I agree it's unequivocally an improvement.

Yea, a file probably shouldn't be called bob... I would probably have
gone with "foo.txt" ( but file.txt is just fine too ).

