Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA70C10F19
	for <git@archiver.kernel.org>; Wed, 16 Aug 2023 18:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345661AbjHPSw7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Aug 2023 14:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345672AbjHPSwc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2023 14:52:32 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DF026B7
        for <git@vger.kernel.org>; Wed, 16 Aug 2023 11:52:21 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DB82F1AE398;
        Wed, 16 Aug 2023 14:52:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=PFcK+JWGCAf4
        /ZKRK2ITt6eoM8zHRKQI0QgFYqqP5Ek=; b=x2N9HjlneJl+riHAdqKX4uE8OHB4
        mbcnR+MY+Bh6YSUSQwgWg8SPFO/DIGexOVmbXmKcqqHPyqJFH1gvsJd24lX3/283
        GZqU6BCHJulR5o4ZvWHLR/wJunZgasOYX5PTlzAA18gZNVzY5B2sd7PD8zIfXtHV
        UqNy7BVXHSAQkbU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D4F5A1AE38F;
        Wed, 16 Aug 2023 14:52:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4ED901AE38E;
        Wed, 16 Aug 2023 14:52:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 4/4] rev-list-options: fix typo in `--stdin` documentation
References: <cover.1692194193.git.martin.agren@gmail.com>
        <b1b3f1d10b64e63c62db0105957a4ad5e0295d34.1692194193.git.martin.agren@gmail.com>
        <xmqqzg2qesoq.fsf@gitster.g>
Date:   Wed, 16 Aug 2023 11:52:19 -0700
In-Reply-To: <xmqqzg2qesoq.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        16 Aug 2023 11:41:09 -0700")
Message-ID: <xmqqv8dees64.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 07638186-3C66-11EE-B2D8-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
>> With `--stdin`, we read *from* standard input, not *for*.
>
> True, and the name of the stream is "the standard input".

... but there are too numerous instances of unadorned "standard
input" in the documentation, let's leave it for now.

Thanks for these fixes.  Queued all four and will fast track.

>
>> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
>> ---
>>  Documentation/rev-list-options.txt | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-li=
st-options.txt
>> index e6468bf0eb..a4a0cb93b2 100644
>> --- a/Documentation/rev-list-options.txt
>> +++ b/Documentation/rev-list-options.txt
>> @@ -237,7 +237,7 @@ endif::git-rev-list[]
>> =20
>>  --stdin::
>>  	In addition to getting arguments from the command line, read
>> -	them for standard input as well. This accepts commits and
>> +	them from standard input as well. This accepts commits and
>>  	pseudo-options like `--all` and `--glob=3D`. When a `--` separator
>>  	is seen, the following input is treated as paths and used to
>>  	limit the result.
