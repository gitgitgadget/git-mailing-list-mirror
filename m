Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0097BC433F5
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 15:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236885AbiC2QB2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 12:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236624AbiC2QBY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 12:01:24 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119541FA54
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 08:59:40 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 38E83108DB4;
        Tue, 29 Mar 2022 11:59:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=gED6C6881D+z
        xWxBFROxE9QXvsfq6L9YIcJYID2foIs=; b=mRe/sxyc6e4NPsZBBa/1SLxJaDwv
        q4GTBE0Nx2q51zZTHd+NtovGKGLlkaCy1AmWEq9gSlqHaO1GN+nRbhollWSZMe3V
        hBzfuoI8rDFEMwmZg71ZvalqeKxBIMHMduN/K/IXhzUkNwhbGffC3IC0Zfcp8MKt
        FNvRG24vwTpZ3Do=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2F51E108DB3;
        Tue, 29 Mar 2022 11:59:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7F785108DB0;
        Tue, 29 Mar 2022 11:59:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH] reftable: make assignments portable to AIX xlc v12.01
References: <c052b97e-e788-f63a-15c5-b1fbb6a480e8@web.de>
        <patch-1.1-98267695418-20220328T190642Z-avarab@gmail.com>
        <CAFQ2z_PBk57smzqDMVGN7YO3TvutrpaXERfKU4Mp45RfWkwcuQ@mail.gmail.com>
Date:   Tue, 29 Mar 2022 08:59:38 -0700
In-Reply-To: <CAFQ2z_PBk57smzqDMVGN7YO3TvutrpaXERfKU4Mp45RfWkwcuQ@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Tue, 29 Mar 2022 14:12:05 +0200")
Message-ID: <xmqq5ynwyck5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3D4454C2-AF79-11EC-B088-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> On Mon, Mar 28, 2022 at 9:10 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> Change the assignment syntax introduced in 66c0dabab5e (reftable: make
>> reftable_record a tagged union, 2022-01-20) to be portable to AIX xlc
>> v12.1:
>
> LGTM.

Thanks; queued.
