Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE00C433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 21:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40DA461247
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 21:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355607AbhJAVyv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 17:54:51 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60222 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbhJAVyt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 17:54:49 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AD3191647EC;
        Fri,  1 Oct 2021 17:53:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=BQEafnCh5Jlm
        BY7Iui6UKjttMn/WTjAH2QQWcIBZnLk=; b=PIEALVRSUyuAswJJDeJ7KY4cdiHs
        6LQ6mFo0TlwlXHEEsBM6gIZpn+LRxPEkGpZmdIN/0BNYR3xYtenJe1VDBAZ8VPuM
        tc5wY6qDcZmlHOewnr1E1HH9TRUDTuAAO06PithbLXTJtRt9w/RPw957qyjdkw99
        /sruBz5QtieL7ys=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A6CE21647EB;
        Fri,  1 Oct 2021 17:53:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 216161647E9;
        Fri,  1 Oct 2021 17:53:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 00/11] fix bug, use existing enums
References: <cover-00.10-00000000000-20210928T130905Z-avarab@gmail.com>
        <cover-v2-00.11-00000000000-20211001T142631Z-avarab@gmail.com>
        <xmqqzgrs2z17.fsf@gitster.g>
Date:   Fri, 01 Oct 2021 14:53:01 -0700
In-Reply-To: <xmqqzgrs2z17.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        01 Oct 2021 14:52:36 -0700")
Message-ID: <xmqqv92g2z0i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F3107CB8-2301-11EC-9A20-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> This re-roll of the v1[1] should hopefully address all the feedback on
>> that version, particularly the motivation for the enum-as-bitfield
>> labeling, as expanded on in 02/11.
>
> Other than [3] and [4] that I am not yet convinced is a good idea,
> this round looks good to me.

Not 3&4, but 4&5.
