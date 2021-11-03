Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42DEC433EF
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 16:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B40260F58
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 16:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbhKCQbS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 12:31:18 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51068 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbhKCQbR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 12:31:17 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2A539170B8A;
        Wed,  3 Nov 2021 12:28:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=OCeNaUWEXcqK
        zJcu2jMSFrwNW2bYCGvYwypdIufph10=; b=KrV01XOHI3t6u2qIdwzst7npHg3Y
        67O5nw2oK3ui+H18HDp38aFN9rXloWrKL8lcP/EUowDfGqjOS7X9e2ErKassTSzJ
        /L/i+Jshl4NikMup4j+Y1OOeMh9z2tOgOwP2rqIlN1VSwR7eoIAB+uZ57CtD44m/
        OaOJXBM8ccVmMrg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2232D170B89;
        Wed,  3 Nov 2021 12:28:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AE7AC170B88;
        Wed,  3 Nov 2021 12:28:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= Avila <avila.jn@gmail.com>
Cc:     =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
        =?utf-8?Q?Jean-N?= =?utf-8?Q?o=C3=ABl?= Avila via
         GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Eli Schwartz <eschwartz@archlinux.org>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 4/9] doc: use only hyphens as word separators in
 placeholders
References: <pull.1066.git.1635261072531.gitgitgadget@gmail.com>
        <984b6d687a2e779c775de6ea80536afe6ecc0aaf.1635438124.git.gitgitgadget@gmail.com>
        <ee376004-a4dd-539d-28b3-3fc5baa6fe00@archlinux.org>
        <2803948.JoDkH9avOM@cayenne> <xmqqmtmocqz4.fsf@gitster.g>
        <0b404448-cd4b-8614-2c49-c4683b56879f@gmail.com>
Date:   Wed, 03 Nov 2021 09:28:36 -0700
In-Reply-To: <0b404448-cd4b-8614-2c49-c4683b56879f@gmail.com>
 (=?utf-8?Q?=22Jean-No=C3=ABl?=
        Avila"'s message of "Wed, 3 Nov 2021 13:46:39 +0100")
Message-ID: <xmqqlf258aq3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 18FF75AC-3CC3-11EC-B9CF-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-No=C3=ABl Avila <avila.jn@gmail.com> writes:

> Junio C Hamano wrote:
>> Jean-No=C3=ABl AVILA <jn.avila@free.fr> writes:
>>
>>> The choices here may be awkward; no problem to propose even more desc=
riptive=20
>>> names.
>>>
>>>>   Similarly "the 'format:<format-string>' format" feels highly
>>>>   redundant, I expect the reader knows that <string> contains a form=
at
>>>>   inside it as it's mentioned immediately before *and* after.
>>>>
>>> The fact that it is a string doesn't tell you much about what you can=
 do with=20
>>> it. For me, this isn't a problem that the explanation is redundant.
>> I agree that --format:<string> is quite poor, as type alone does not
>> give readers any information on what it means and how it is supposed
>> to look like.  Calling it <format-string> does make quite a lot of
>> sense.
>>
>> It is a bit less obvious how much value we get out of <bool-value>,
>> though.  In --opt=3D<arg> scheme of things, what comes after '=3D' are
>> all <value>s, so <bool-value> does not clarify over <bool> like the
>> way <format-string> clarifies over <string>.
>>
> Agreed. Should reroll the patch series?

I guess another (hopefully the final) reroll would not hurt (but we
are not in hurry---this may be among the topics that graduate early
in the next cycle, but not during this cycle).

Thanks.
