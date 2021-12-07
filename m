Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFB5C433FE
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 21:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241837AbhLGV2a (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 16:28:30 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57592 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237258AbhLGV23 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 16:28:29 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 84DB6155F1E;
        Tue,  7 Dec 2021 16:24:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/JQTVfc/LZwd
        gg9Lw62Pey9uDMnLK6qhY85xAHjQQW0=; b=VIP9mWhR6G4XygcfAUv3cAcit7iy
        44lmTZNT2dO3Ef2gKevMQENk4dC0uBUp0JG86V/Y91OxHVSVgf4/SDpPpGyQLo4W
        iKlrIC278hTsvcC/vUntz75YVI+g5Kw33MkEXB90pnf4FbffjC68QvTDHGNzuvW7
        Vattwaoo4vVCdNw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7D94E155F1C;
        Tue,  7 Dec 2021 16:24:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 77367155F1A;
        Tue,  7 Dec 2021 16:24:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/6] usage API: Add and use die_message()
References: <cover-0.4-00000000000-20211206T165221Z-avarab@gmail.com>
        <cover-v2-0.6-00000000000-20211207T182419Z-avarab@gmail.com>
Date:   Tue, 07 Dec 2021 13:24:53 -0800
In-Reply-To: <cover-v2-0.6-00000000000-20211207T182419Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 7 Dec
 2021 19:26:28
        +0100")
Message-ID: <xmqqpmq85cre.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1ED2D5F4-57A4-11EC-8F56-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> A small set of fixes to usage.[ch]'s API use that will go towards
> enabling nicer things down the road. See [1] for the v1 summary
>
> I believe this should address all the feedback Junio had on the
> v1.

Thanks.  We need more reviewers, I guess, but in the meantime, you
need to make do with me ;-)

