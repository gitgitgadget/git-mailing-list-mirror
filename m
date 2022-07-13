Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30DEC43334
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 22:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbiGMW2k (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 18:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbiGMW2i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 18:28:38 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1FF270E
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 15:28:35 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 093F1198BE8;
        Wed, 13 Jul 2022 18:28:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=QMEHXLUXuk9+
        PZ7TBqMvdhfMbUJBTx2+wmd/j3UyOEE=; b=pwYiDCaEnO0sSuGajc33RtiX2PGa
        jtF9o+4bqUHvy7vKwESSGlVnGIRDu9EDuEtheyp3qFPR82vi/P3YWB+/5ghzwGxJ
        MKVDWv+bkdT/qt9EPmXNv6TtsNrCzZdQZvfc/IuqCqk672XujMQKuqpTbe1nXrKF
        m0v5RoG1T3082Ko=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F18C8198BE7;
        Wed, 13 Jul 2022 18:28:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9E94B198BE6;
        Wed, 13 Jul 2022 18:28:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/3] Use "allowlist" and "denylist" tree-wide
References: <pull.1274.git.1657718450.gitgitgadget@gmail.com>
        <220713.86wncg3hnj.gmgdl@evledraar.gmail.com>
Date:   Wed, 13 Jul 2022 15:28:30 -0700
In-Reply-To: <220713.86wncg3hnj.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 13 Jul 2022 21:42:44 +0200")
Message-ID: <xmqqedyoabqp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 20152FF4-02FB-11ED-9B0D-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Wed, Jul 13 2022, Derrick Stolee via GitGitGadget wrote:
>
>> The terms "allowlist" and "denylist" are self-defining. One "allows" t=
hings
>> while the other "denies" things.
>
> I've got a preference for things that can be found in widely available
> dictionaries, these words seem to be tech neologisms.

FWIW, I share the same.  I suspect that "whitelist" may be found in
more dictionaries than "allowlist".

e.g.

    https://www.merriam-webster.com/dictionary/allowlist
    https://www.merriam-webster.com/dictionary/whitelist

A statement "We have audience who are not native English speakers,
and may not share cultural background" may not be incorrect at all,
but that does not justify s/whitelist/allowlist/.  We end up with
sentences written with non-words that these non-natives cannot even
look up in dictionary.

If we can rephrase without using these invented words, we should do
so, especially when the result becomes even easier to read than the
original that used "whitelist".  I've shown a few examples in my
other messages in this thread.

Thanks.

