Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA88FECAAD3
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 18:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiISStO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 14:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiISStM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 14:49:12 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9500A46D9E
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 11:49:11 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DC2BC14F1E5;
        Mon, 19 Sep 2022 14:49:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3TIA+taDUKmNE/JSYd7nqt1QW4wGCZv1J6MLqU
        X3HGY=; b=KSweCP2VnxAyvS4l08IU7goCzD3FjiFn3LmdHR1L8D+Cnz6o6wY8JD
        XdSH6u0xn+Hpc2jidDBMEDfSbCvmngKkiV9bKAjtUEA+KblEgjm6kT2aQqKaHv4l
        5LdxxdMGgOQ/PkHlj0O/CpyT4cIHYJCBgLE30TQ1gZYQrrBgPArOs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D480C14F1E4;
        Mon, 19 Sep 2022 14:49:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3CB8C14F1E1;
        Mon, 19 Sep 2022 14:49:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Force Charlie via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Force Charlie <charlieio@outlook.com>
Subject: Re: [PATCH] unicode: update the width tables to Unicode 15
References: <pull.1333.git.git.1663388320380.gitgitgadget@gmail.com>
        <xmqqo7vbb810.fsf@gitster.g>
Date:   Mon, 19 Sep 2022 11:49:09 -0700
In-Reply-To: <xmqqo7vbb810.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        19 Sep 2022 10:15:07 -0700")
Message-ID: <xmqqczbr9p3u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BF5E30DA-384B-11ED-B6BB-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Force Charlie via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Force Charlie <charlieio@outlook.com>
>>
>> Unicode 15 Released[0] and including several additional zero/double
>> width characters.
>>
>> [0] https://home.unicode.org/announcing-the-unicode-standard-version-15-0/
>>
>> Signed-off-by: Force Charlie <charlieio@outlook.com>
>> ---
> Thanks.
>
> Where are you getting the information to update these ranges from,
> among 4489 new characters?  Is there a readily accessible URL that
> is more suitable than the announcement of the whole collection?

Ah, it would probably is a good idea to say what you did to prepare
this patch in this case, like:

    Unicode 15 that was released recentry [0] includes several
    additional zero/double width characters.

    Update unicode-width.h table by cd'ing to contrib/update-unicode/
    and running update_unicode.sh script there.

    [0] https://home.unicode.org/announcing-the-unicode-standard-version-15-0/

or something, I guess.

Thanks.
