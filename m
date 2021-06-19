Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3723AC2B9F4
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 07:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07D3D610FB
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 07:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbhFSHUf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Jun 2021 03:20:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53828 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbhFSHUf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Jun 2021 03:20:35 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AD950CB695;
        Sat, 19 Jun 2021 03:18:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qiSVTGWDY0XsNGrsDFAlu6lba453RJOte8xCRI
        CRmrE=; b=OibcKeBb16jKv7Dd+LJu7s6h8SiJqeq5VdwLUNgraP83CIw3ruKVbW
        Z5Tf6JGvp/kKHAwDM39LG85S8q4UuGsU+4hKc+OFJheG/Lk9jpWmqm3jY/9fya7P
        IrG0iCTeo4OWLe1aOyUIbhyfHmid3OUP/N4s5yxu88TdsYY1Miri0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A615DCB694;
        Sat, 19 Jun 2021 03:18:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 32530CB693;
        Sat, 19 Jun 2021 03:18:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2021, #06; Thu, 17)
References: <xmqqr1h1mc81.fsf@gitster.g>
        <YMvhoXVBoO08ziI1@camp.crustytoothpaste.net>
        <YMvofq5aSryQzpZQ@coredump.intra.peff.net>
Date:   Sat, 19 Jun 2021 16:18:23 +0900
In-Reply-To: <YMvofq5aSryQzpZQ@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 17 Jun 2021 20:27:42 -0400")
Message-ID: <xmqqmtrmjpa8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 88D1AB04-D0CE-11EB-9C43-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Hmm. I'm not sure if that's a good resolution here. I do think many
> people were positive in moving in that direction. If there's a
> contributor that people have trouble working with, I'm OK giving up on
> possible contributions they could make, even adaptations of their work.
>
> But if by working in an area they poison it for others (because there's
> no desire to work with them, but no desire to step on their toes) that
> doesn't seem like a workable long-term strategy.

You may lick a corner of a piece of cake and think that it would
repel other people enough to leave only you to consider eating it,
but no, in this project, you aren't allowed to lick a Makefile and
claim that you own it.  Also, if some contributors get too annoying
to be worth our time interacting with, it is OK to ignore them.

> I don't think this topic is particularly urgent, so I'm OK to drop it
> for now (and as always, it's your choice what you work on). But I'm
> worried about the general precedent / principle.
