Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F64C433FE
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 19:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57C4761107
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 19:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347157AbhITTe1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 15:34:27 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64077 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245509AbhITTc0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 15:32:26 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B2E1C148990;
        Mon, 20 Sep 2021 15:30:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DV1mUZfB7sduH8Yn7uBrWblMOYMCkQ6eWk26Af
        eeZKI=; b=Gm8wHSlSx0Gj9OqYPXnJ2kt030Ip19t/NcU5BsBMGzI2ZEzL0mKs6G
        BFVhkZLmrvtyrdB329LBLZ8+Pz9h4FuqcpswKnHUT5KQKNA0eI0X8HsMYO8XA8qB
        /keULNZgxyjgY4XM/TteoREQuGHqJ5WIla7gPNXQnLxfLvFChjZIE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AABA814898F;
        Mon, 20 Sep 2021 15:30:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DFCDC14898E;
        Mon, 20 Sep 2021 15:30:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, liu.denton@gmail.com
Subject: Re: [PATCH] ls-files: use imperative mood for -X and -z option
 description
References: <20210920121940.905549-1-bagasdotme@gmail.com>
        <YUij2Aj04B1Q1tRV@nand.local>
Date:   Mon, 20 Sep 2021 12:30:54 -0700
In-Reply-To: <YUij2Aj04B1Q1tRV@nand.local> (Taylor Blau's message of "Mon, 20
        Sep 2021 11:08:08 -0400")
Message-ID: <xmqqee9javtd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 467F1B64-1A49-11EC-AD11-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Your patch looks fine to me. I don't think it's urgent to change, but it
> looks correct nonetheless.
>
>> Cc: Jeff King <peff@peff.net>
>> Cc: <liu.denton@gmail.com>
>
> These Cc trailers can be removed. (They're not entirely unprecedented,
> but I can only find ~200 examples in git.git's history).

Yup, "can" and probably "should".  It is meant for consumption by
your e-mail software.

>>  		OPT_SET_INT('z', NULL, &line_terminator,
>> -			N_("paths are separated with NUL character"), '\0'),
>> +			N_("separate paths with NUL character"), '\0'),
>
> The text before your patch should include an article so it reads "with
> [the] NUL character" instead of "with NUL character".
>
> So I think the right post-image would be: "separate paths with the NUL
> character".

Correct.  Grammar fixes are very much appreciated, especially in an
international project like this one.

Thanks.
