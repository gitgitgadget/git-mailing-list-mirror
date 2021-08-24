Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07660C4320A
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 19:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE417613AB
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 19:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234674AbhHXTMr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 15:12:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53844 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234649AbhHXTMq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 15:12:46 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 09138F0BBC;
        Tue, 24 Aug 2021 15:12:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=OORX5U0Oydb7
        r8zdpJbLef4uRS/kyWTrJ5heQyk0ClY=; b=drdiuszUgmsHK1Dk+riC/Hi6sOlP
        V/oITewgdAnZhm1JyhgbTppyzMlfatO6i3PVVFPQrHb7z0UFgMDKKUmEykGlOYdF
        SFsGym0NaCNRsk6ymiA4RUJae/z5H1b1d6tPERxOVism8xzgSdi7UnnO7IFCLHM8
        p10z762u3LeJWuI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C3DE7F0BBB;
        Tue, 24 Aug 2021 15:12:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0D4CFF0BBA;
        Tue, 24 Aug 2021 15:12:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Krzysztof =?utf-8?Q?=C5=BBelecho?= =?utf-8?Q?wski?= 
        <giecrilj@stegny.2a.pl>, git@vger.kernel.org
Subject: Re: git log --encoding=HTML is not supported
References: <9896630.2IqcCWsCYL@localhost.localdomain>
        <22496693-cf63-a278-c85e-d9e4376e2a59@gmail.com>
        <2197959.ZqlxZjeC1n@localhost.localdomain>
        <05ffcc36-f473-14f3-d7df-1efa0dcfcade@gmail.com>
Date:   Tue, 24 Aug 2021 12:11:59 -0700
In-Reply-To: <05ffcc36-f473-14f3-d7df-1efa0dcfcade@gmail.com> (Bagas Sanjaya's
        message of "Tue, 24 Aug 2021 17:46:28 +0700")
Message-ID: <xmqqeeaiodxc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2851863A-050F-11EC-8F60-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On 24/08/21 17.33, Krzysztof =C5=BBelechowski wrote:
>> Dnia wtorek, 24 sierpnia 2021 12:31:14 CEST Bagas Sanjaya pisze:
>>=20
>>> Please speak English here (in other words, re-submit git-bugreport
>>> without l10n).
>> How do I do that?
>
> You need to set locale to English when executing `git bugreport`:
>
> ```
> LANGUAGE=3Den_US.UTF-8 LC_ALL=3Den_US.UTF-8 /path/to/git bugreport
> ```

Emily, what's your take on this exchange?

I recall that many people (me included) went for "user friendlyness"
by pushing to localize the questionnaire, but here, it seems to be
backfiring at us.

I personally think that it is OK to give a localized questionnaire
and let volunteers who can speak the language help non-English
speakers, but at the same time, it may be a good idea to hint that
filling in the answers in English would give a better chance for
their problems to be looked at (in a localized message).

