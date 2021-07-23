Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82415C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 16:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AEAD60725
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 16:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235671AbhGWPUc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 11:20:32 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60621 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235568AbhGWPUb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 11:20:31 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D0C88138B6C;
        Fri, 23 Jul 2021 12:01:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=LQVXR8fS7ljf
        o5zEU+KX3Tn9qTAEplEbw+V8NTSEgBY=; b=YMERMGk/rXd6LKkmcA+Jma3Lm7+0
        vHn1IbTpVEjf8T9cZ3xZzJUPK5Rr6i+wK07T+boF4+pkmPZEKON2FcK/ANw2Ga1+
        oo40GYqQnTweGI7tlyX/1/PKXSL4KSNL7q/TcC9IXPkbJdbu7I/PUkSFnQkndAvB
        693DStkTE/YRxDA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C8156138B6B;
        Fri, 23 Jul 2021 12:01:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F0E14138B69;
        Fri, 23 Jul 2021 12:01:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: What's cooking in git.git (Jul 2021, #05; Wed, 21)
References: <xmqqo8av9j7f.fsf@gitster.g> <87a6mevkrx.fsf@evledraar.gmail.com>
        <xmqqbl6u7z68.fsf@gitster.g> <87eebptr7i.fsf@evledraar.gmail.com>
Date:   Fri, 23 Jul 2021 09:01:00 -0700
In-Reply-To: <87eebptr7i.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 23 Jul 2021 09:32:23 +0200")
Message-ID: <xmqqsg05ow8z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2D8EC440-EBCF-11EB-8A30-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> v3 only has the discussion about the "lock OID" being passed in, which
> Han-Wen replied to (you and me CC'd) in saying:
> https://lore.kernel.org/git/CAFQ2z_PuNJ_KtS_O9R2s0jdGbNNKnKdS3=3D_-nEu6=
367pteCxwA@mail.gmail.com/
>
>     Reftable could easily read the current OID for the reference, if ne=
cessary.=20
>
> Except that last lore.kernel.org link doesn't work since that reply has
> an HTML part. Will reply there.

OK.  I couldn't figure out what Han-wen wanted to say there, but
will see what happens in the thread.  Thanks.
