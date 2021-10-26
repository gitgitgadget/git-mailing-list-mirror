Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28461C433F5
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 21:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E5C160EB4
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 21:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237191AbhJZVbp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 17:31:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58391 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239625AbhJZVbh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 17:31:37 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4297AE7E83;
        Tue, 26 Oct 2021 17:29:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=n1jAUtWOT2GF
        n0KZx6gRtcOfFgBcqf92Fy3SR1I9pgc=; b=n8+5NddB/W5bYZIWnps04gBXYxpu
        zazhlPT/1lvjpBjd5ytRgolFFRW5D0mA8QpISPViYQsXpKbNiaPNqUM6F18m5ehi
        SOnHgUBoTXYIKnbjN+FUU1Sda5Jh8JOmCqRxSvPtGibVKHAcQPZzTFICC0NdGrkj
        z0IzovFqkq4/DiA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B01FFE7E80;
        Tue, 26 Oct 2021 17:29:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 01B9FE7E7F;
        Tue, 26 Oct 2021 17:29:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: What's cooking in git.git (Oct 2021, #06; Mon, 25)
References: <xmqq5ytkzbt7.fsf@gitster.g>
        <e9bc367e-ae51-da1c-558e-6836922b0d0d@gmail.com>
        <211026.86h7d3zvao.gmgdl@evledraar.gmail.com>
        <664f452a-e57e-bb19-78ea-1712f1d0de07@github.com>
Date:   Tue, 26 Oct 2021 14:29:02 -0700
In-Reply-To: <664f452a-e57e-bb19-78ea-1712f1d0de07@github.com> (Victoria Dye's
        message of "Tue, 26 Oct 2021 13:27:41 -0400")
Message-ID: <xmqqr1c7xyox.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BE51899E-36A3-11EC-A7F6-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Tue, Oct 26 2021, Derrick Stolee wrote:
>>=20
>>> On 10/25/2021 11:48 PM, Junio C Hamano wrote:
>>>
>>>> * vd/sparse-reset (2021-10-11) 8 commits
>>>> ...
>>>>  Various operating modes of "git reset" have been made to work
>>>>  better with the sparse index.
>>>>
>>>>  Needs review.
>
> I am planning to re-roll with that test update, but I wanted to give it=
 some
> time to see if other reviews came in. I'll send a new version tomorrow =
at
> the latest.

Thanks.  Will mark it as "Expecting a reroll".
