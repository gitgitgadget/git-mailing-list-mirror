Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9321C433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 17:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D387B61251
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 17:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345239AbhIXR4e (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 13:56:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57289 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345157AbhIXR42 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 13:56:28 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1160ED0813;
        Fri, 24 Sep 2021 13:54:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/RJEsI0fHuST
        y090qGmqFPs3ot8tira9z1/UxxNFvXE=; b=gQG4rmz1/CDnAg/rAMXepezKKYzq
        sJ6NhZqk+jmD8eeoDAdPxGW6wyx6zeAWCdfIHuJMaXl/6Tzy4cPvTPZOs0n2P/E2
        dRt9VT6BXZCuIrBa267DDJ55B7JgyugdcSMAl1byexBLAg/ade6+S8EwRkyzKy9D
        yNqRVyG/fktpv/c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0890AD0810;
        Fri, 24 Sep 2021 13:54:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5D6ABD080F;
        Fri, 24 Sep 2021 13:54:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 01/15] scalar: create a rudimentary executable
References: <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com>
        <pull.1005.v4.git.1631630356.gitgitgadget@gmail.com>
        <852ec003109b8244e2f9360ec64749779989c4a2.1631630356.git.gitgitgadget@gmail.com>
        <87sfxu2kyc.fsf@evledraar.gmail.com>
Date:   Fri, 24 Sep 2021 10:54:52 -0700
In-Reply-To: <87sfxu2kyc.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 24 Sep 2021 14:52:55 +0200")
Message-ID: <xmqqy27lvoyb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8569D0B6-1D60-11EC-B03E-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> ... the
> usage.c API, which is generally being phased out.

That is news to me.  Any reason why you think so?
