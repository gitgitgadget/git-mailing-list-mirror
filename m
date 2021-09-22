Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E351AC433EF
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 19:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C46EB610A1
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 19:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237179AbhIVT0F (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 15:26:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55221 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbhIVT0D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 15:26:03 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 46D69FE546;
        Wed, 22 Sep 2021 15:24:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=w+vHQySEYq3BtwWfr5uFvz82/HqS2fhtkNHROh
        pl6+E=; b=ehv3OIphQ+qe6Ng40/HNDfMZYPAwIYgXqdpb/5DefOHnYPsE+K2D2V
        7iBG11yI6F1g09bzOARI3dhhBF7KX5aCuX5DKOrb502+f0Bh00VF2+LKvy1MMDeS
        VQihT1OcpvoDlS/lMfF4A8RgYMs7WAykcEB701LLYUUOUJ9/cCLCo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C625FE545;
        Wed, 22 Sep 2021 15:24:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9B4C3FE544;
        Wed, 22 Sep 2021 15:24:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH 0/3] Makefile: make "sparse" and "hdr-check" non-.PHONY
References: <cover-0.3-00000000000-20210921T224944Z-avarab@gmail.com>
        <YUqQzn5vFDpbF5dM@coredump.intra.peff.net>
        <c13b050c-abb9-c669-b92c-930f2b43ce10@ramsayjones.plus.com>
Date:   Wed, 22 Sep 2021 12:24:31 -0700
In-Reply-To: <c13b050c-abb9-c669-b92c-930f2b43ce10@ramsayjones.plus.com>
        (Ramsay Jones's message of "Wed, 22 Sep 2021 17:58:16 +0100")
Message-ID: <xmqq4kac76s0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B6DF4FD6-1BDA-11EC-B8D4-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

>> All three seem pretty reasonable to me.
>
> Heh, interesting. My initial reaction was completely negative! ;-P
> (and not just mildly negative either, but 'you must be kidding').
>
> However, I then thought 'I must be missing something, I'm being
> stupid and about to embarrass myself in public!'.

;-)  My thoughts, exactly.
