Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0DEC433E0
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 06:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 040D064F69
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 06:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhCLGD6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 01:03:58 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59496 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhCLGDx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 01:03:53 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7B5BBB8D93;
        Fri, 12 Mar 2021 01:03:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=kB4vx4NOIdEG
        2x6OU4Ud1HGjI1A=; b=hJ7uoGvAgFnnF2EZkCCCtMSQCf4FeN41QEEWK+I1yUWL
        0uKpZGFDzifpieoVlYsua0tJnScDGemrQ/dQLCKGjvrKiSuh8dI83oO3CB4zAXXM
        iLlAyrTpqDSFFV6agZh2aHWDl3UcOFHYsJjv0WsaK929l39KQ9Jm1/yRObr4XTI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=dTQD+K
        p++D566SEeq9OMV8EaD1IzXJNIUc8L3VWObRYG42Ye1tE89PCmOkcf/Tcdr7k2Ex
        WiSa5rjKR+AYH/IkhldW+KHJWek8GThpCdqXfqtm3ebk9g5CGIVbE1hohXeqo24L
        /p/ixId5/TKNb3M+HMpSNloKnP+a7i5IX7L+M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 725DCB8D92;
        Fri, 12 Mar 2021 01:03:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F2006B8D91;
        Fri, 12 Mar 2021 01:03:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] po/README: document PO helper
References: <20210311125511.51152-1-bagasdotme@gmail.com>
        <20210311125511.51152-2-bagasdotme@gmail.com>
        <CANYiYbH_U=3gN+LH7e-LBdRdcE0geAuUzoBX4O09qego0xKX-Q@mail.gmail.com>
Date:   Thu, 11 Mar 2021 22:03:51 -0800
In-Reply-To: <CANYiYbH_U=3gN+LH7e-LBdRdcE0geAuUzoBX4O09qego0xKX-Q@mail.gmail.com>
        (Jiang Xin's message of "Fri, 12 Mar 2021 09:32:39 +0800")
Message-ID: <xmqqa6r8c3i0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B846F598-82F8-11EB-8568-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> Bagas Sanjaya <bagasdotme@gmail.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8811=
=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=888:56=E5=86=99=E9=81=93=EF=BC=
=9A
>>
>> Document about PO helper script (po-helper.sh). It covers about
>> installing the script and short usage examples.
>>
>> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
>> ---
>>  po/README | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>
>> diff --git a/po/README b/po/README
>> index efd5baaf1d..9beffc2954 100644
>> --- a/po/README
>> +++ b/po/README
>> @@ -286,3 +286,25 @@ Testing marked strings
>>
>>  Git's tests are run under LANG=3DC LC_ALL=3DC. So the tests do not ne=
ed be
>>  changed to account for translations as they're added.
>> +
>> +
>> +PO Helper
>> +---------
>> +
>> +To make maintaining XX.po file easier, the l10n coordinator created
>> +po-helper.sh script. It is wrapper to gettext suite, specifically
>
> It's better to rename the script to other name without the suffix
> ".sh", so we can reimplement it in other programming language. Maybe
> we can rename it to `git-po-helper`, and host this helper in a
> separate project on GitHub.

It might be a good move in the longer term, but if the po-helper.sh
is working well enough to fill the need of i18n/l10n team right now,
I think documenting the status quo would be a good way to help the
contributors immediately.

And when we reimplement it (if that is desirable---I have no opinion
myself), we certainly would want to update this part of the doc to
use the name of the rewritten tool.

In any case, I expect that you to be the main reviewer on this topic
and you will feed me the final commits, just like any other change
in the po/* area via a pull request.  In other words, I may have
input to the discussion on list, but I won't be applying the result
myself---I'll be pulling from git://github.com/git-l10n/git-po.git
repository instead.

Thanks.
