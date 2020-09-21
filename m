Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E427CC35257
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 21:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9876923A5C
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 21:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WrvbjSJ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgIUVMS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 17:12:18 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50435 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgIUVMS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 17:12:18 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9EDC7FC17B;
        Mon, 21 Sep 2020 17:12:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VP1Cfa5FVT9B7iy3w4jT1E2Zh6U=; b=WrvbjS
        J5lU3MynjUfUgLLdzbptKwH90QjxVAFm6oguTdaPNNx3WXhswKIH2sCDaeMt59oJ
        MNGbWsexXMzWA7g3Rn7UMDq3woZXJFAtF9CaRlCybOvL38zm5hRZO79QQQckZYPs
        5nN1dDDN6DJIGDqizmE8qByBx12fmtTlXN1XI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JM2dzhqpdhsBz2mHEG0pj3DdwhfXzRfO
        WAGpt0AxCE9YuXy2XYONWltJpCP67Mu0KvxmAIXpIoAXZIdr/KqZWfyd7Cfh849O
        uP787JoIP6TiXnl7GS2SmmiT+gB8iPCIIOdvsEGskCPWw2vjgeFVg62aKftb8txR
        mL1sMLuvwXw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 980B3FC17A;
        Mon, 21 Sep 2020 17:12:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DFE10FC177;
        Mon, 21 Sep 2020 17:12:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/5] t/test-terminal: avoid non-inclusive language
References: <pull.734.git.1600279853.gitgitgadget@gmail.com>
        <3b4ae48d4a3a7e2d6aae259ead19b6643d2533e8.1600279853.git.gitgitgadget@gmail.com>
        <xmqqft7hwhyd.fsf@gitster.c.googlers.com>
        <xmqqo8m5v2g9.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2009201733510.5061@tvgsbejvaqbjf.bet>
Date:   Mon, 21 Sep 2020 14:12:12 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2009201733510.5061@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Sun, 20 Sep 2020 17:34:05 +0200
        (CEST)")
Message-ID: <xmqqsgbaeswj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1EE7540E-FC4F-11EA-9794-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Wed, 16 Sep 2020, Junio C Hamano wrote:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>> > "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
>> > writes:
>> >
>> >> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>> >>
>> >> In the ongoing effort to make the Git project a more inclusive place,
>> >> let's try to avoid names like "master" where possible.
>> >
>> > The two sides of a PTY are called 'master' and 'slave', and I
>> > understand there is a push to move away from these words, but
>> > calling one side with an invented name that is used by nobody else
>> > in the context of talking about PTY, while keeping the word used to
>> > call the other side, would lead to confusion.
>> >
>> > A better change is to drop "master_" altogether without replacing
>> > the word with anything, and call them just "input", "output" and
>> > "error".
>>
>> If we really want to use a replacement word for 'master' instead of
>> just dropping, I may be inclined to suggest 'parent', in the hope
>> that PTY implementors will start following what Python folks are
>> doing, at which time they will give us a synonym for 'slave' method
>> called 'child' we can use.
>
> Good idea!

It is unclear which one of the two you thought a good idea.

Hopefully both are good, but simply dropping "master_" without
attempting to replace would probably be better.

