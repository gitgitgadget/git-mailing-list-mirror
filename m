Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C34C11F64
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 17:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC79A61220
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 17:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbhF1RkW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 13:40:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64578 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhF1RkW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 13:40:22 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D97CBC1DC7;
        Mon, 28 Jun 2021 13:37:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aZCQUQzLdxPGKZZnbwTQjiyiRWh1mPV1tKQCLb
        LfDss=; b=HOubF/NN32X+xnk7rZTqTdz0USkSFbI5n+eAguw5sBm1T1AyoUAMuV
        FZOubzPn1vFseNEUIjWJIav0/2Sb8RkbtWLRtP/rEuScYqNGC7pG9HKdMMg9tBpi
        GekIwWXmP8hROP4g7EYsSIdQlCidlOwOzRNos3K4hLe9bK0I1al1w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D0F74C1DC6;
        Mon, 28 Jun 2021 13:37:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 64DC8C1DC5;
        Mon, 28 Jun 2021 13:37:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v7] help: colorize man pages if man.color=true under
 less(1)
References: <xmqq4ke8pig9.fsf@gitster.g>
        <patch-1.1-a950ef49e28-20210621T083254Z-avarab@gmail.com>
        <xmqqfsxbika3.fsf@gitster.g> <87mtrj2faq.fsf@evledraar.gmail.com>
        <YNPKwIuZvpyWSNXH@coredump.intra.peff.net>
Date:   Mon, 28 Jun 2021 10:37:54 -0700
In-Reply-To: <YNPKwIuZvpyWSNXH@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 23 Jun 2021 19:58:56 -0400")
Message-ID: <xmqqlf6t7uvh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 924D8318-D837-11EB-A9A7-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I'm still entirely unconvinced that this should be in Git at all;
> pointing GIT_MAN_VIEWER or man.*.cmd at a color-man wrapper seems like
> it would be sufficient. But it feels like that conversation was not
> going anywhere productive; I mention it here only to indicate that my
> response above is not an endorsement of the concept.

I have the same reaction to the patch.
