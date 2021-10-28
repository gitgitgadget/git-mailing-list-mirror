Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C873C433FE
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 19:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EE91610FD
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 19:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbhJ1TjB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 15:39:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56714 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbhJ1TjA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 15:39:00 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 12D58F8E1B;
        Thu, 28 Oct 2021 15:36:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=qTQKUvCcDS2i
        G/sJyQwbryF7C5ciuqzJtl4nRhW+LJg=; b=gj0s0YVNSmghR7eEGPnbAcuSGC9K
        f5Ex0DOtPm4yHp7yyEtlQhY4j1jwKGEKJEBLJD+HQI84erxEkN/McGP/ixOR1DKx
        3xukb9U6qm5AaeOsE+BlFoqI1j+iDvo6gTV36w/vhkxdQ+3tPjcw1Sdi6PlENp40
        5a3AlrPzD5voVxY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 09C90F8E1A;
        Thu, 28 Oct 2021 15:36:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 64B60F8E19;
        Thu, 28 Oct 2021 15:36:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget 
        <gitgitgadget@gmail.com>, Git List <git@vger.kernel.org>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH v2 3/9] doc: express grammar placeholders between angle
 brackets
References: <pull.1066.git.1635261072531.gitgitgadget@gmail.com>
        <pull.1066.v2.git.1635438124.gitgitgadget@gmail.com>
        <4d2d198f57294d8307453bda784bf5efe5905f45.1635438124.git.gitgitgadget@gmail.com>
        <CAPig+cR4j_jPLJs-sQAAuNQ5cEqbO0ibck-czOBy=difgi50VQ@mail.gmail.com>
Date:   Thu, 28 Oct 2021 12:36:31 -0700
In-Reply-To: <CAPig+cR4j_jPLJs-sQAAuNQ5cEqbO0ibck-czOBy=difgi50VQ@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 28 Oct 2021 13:46:17 -0400")
Message-ID: <xmqqa6itq6v4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5AC34BF4-3826-11EC-9140-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Thu, Oct 28, 2021 at 12:22 PM Jean-No=C3=ABl Avila via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> doc: express grammar placeholders between angle brackets
>>
>> This rules discerns user inputs from verbatim options in the
>> synopsis.
>
> Maybe: s/rules//
>
>> Signed-off-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>
>> ---
>> diff --git a/Documentation/git-config.txt b/Documentation/git-config.t=
xt
>> @@ -145,7 +145,7 @@ See also <<FILES>>.
>> --f config-file::
>> +-f <config-file>::
>>  --file config-file::
>
> You need to fix the `--file` item as well (mentioned in my v1 review):
>
>     --file <config-file>::

Will amend locally.
Thanks.
