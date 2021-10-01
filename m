Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFECC433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 21:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 976B6619F7
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 21:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355469AbhJAVyX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 17:54:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62071 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbhJAVyW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 17:54:22 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D6F0CF4955;
        Fri,  1 Oct 2021 17:52:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=b6a5Cxs6ydWZ
        oApO6yjLq3pohObtp9TyqXqnrVr71XE=; b=uNpUExrDtwWi030f65tULOyNrmKc
        FLvDbcdejgckriY9p9ESCnIZ7/t40nanMUy2hTAZ4P7J9JKHMl5TOugSOGvMn0VD
        MYInkcsqyrceII5G1FGnQOTvw9CPbRGrjHeIEI9qesAXvZMQ23NnnTh6havpvtRo
        53Qy1woakgB1FuU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CDC37F4954;
        Fri,  1 Oct 2021 17:52:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3953FF4952;
        Fri,  1 Oct 2021 17:52:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 00/11] fix bug, use existing enums
References: <cover-00.10-00000000000-20210928T130905Z-avarab@gmail.com>
        <cover-v2-00.11-00000000000-20211001T142631Z-avarab@gmail.com>
Date:   Fri, 01 Oct 2021 14:52:36 -0700
In-Reply-To: <cover-v2-00.11-00000000000-20211001T142631Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 1 Oct
 2021 16:29:06
        +0200")
Message-ID: <xmqqzgrs2z17.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E4398F7C-2301-11EC-B13F-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> This re-roll of the v1[1] should hopefully address all the feedback on
> that version, particularly the motivation for the enum-as-bitfield
> labeling, as expanded on in 02/11.

Other than [3] and [4] that I am not yet convinced is a good idea,
this round looks good to me.


