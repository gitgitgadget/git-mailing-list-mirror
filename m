Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABBAC433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 13:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B1176191C
	for <git@archiver.kernel.org>; Tue, 11 May 2021 13:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbhEKNXk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 09:23:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50666 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbhEKNXj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 09:23:39 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 16B78C0673;
        Tue, 11 May 2021 09:22:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=IHD45c5LPxFO
        r6lV3QlVDrBLjzskkGskN8ObThuwDs8=; b=DoqQbu8L8JfKxmLbGm6E2a/Rvm1S
        js2r2SGvrfMXpxe7CKAptLbafv2MRC0VzIOmz2gJOtWyzabkcLT+lgbONu3R00Li
        DlDpGsRRbRHxMGEMuaMr7s/sfpSolcNqqFD6pdYbFjBDM855LcSUB2Cnjp6dDgJ8
        Yx4qceOoNNGCEsw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0DD0AC0670;
        Tue, 11 May 2021 09:22:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 814FBC066C;
        Tue, 11 May 2021 09:22:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     Varun Varada <varuncvarada@gmail.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Subject: Re: [PATCH] doc: replace jargon word "impact" with "effect"/"affect"
References: <CAD2i4DDNZ+oOgtp8dcgqwUjtwaTYnNmg2E0oC88ZDW3LYMBiRw@mail.gmail.com>
        <CAD2i4DCtqxziTy5TPjG+U8EGC+8daJGXjpVgxoJwp8__t8fqxQ@mail.gmail.com>
        <20210428085838.GN6564@kitsune.suse.cz>
        <CAD2i4DASL-ZAsLm=_U53zvqMaAC_AOsGnTe-H=XQsfnftgb=rA@mail.gmail.com>
        <20210428184956.GS6564@kitsune.suse.cz>
        <CAD2i4DCLpvAuwp5UEDcPA0wzr4Eg_qhs_xXDW1eLiOwYkUvL1g@mail.gmail.com>
        <20210430075924.GB6564@kitsune.suse.cz>
        <CAD2i4DBSajgNFCwMMDv_tyQwuKDU095avmHs=BHcrAY1GbCqwA@mail.gmail.com>
        <20210510173502.GH12700@kitsune.suse.cz>
        <CAD2i4DBrERhtE5Br22s-bSt7C3SAvcHG62EZ=61COcnBGtUh-g@mail.gmail.com>
        <20210511104326.GJ12700@kitsune.suse.cz>
Date:   Tue, 11 May 2021 22:22:30 +0900
In-Reply-To: <20210511104326.GJ12700@kitsune.suse.cz> ("Michal =?utf-8?Q?S?=
 =?utf-8?Q?uch=C3=A1nek=22's?=
        message of "Tue, 11 May 2021 12:43:26 +0200")
Message-ID: <xmqq35utmmll.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F152DF40-B25B-11EB-94E1-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michal Such=C3=A1nek <msuchanek@suse.de> writes:

> Since you can look up the meaning of the word in a general purpose
> dictionary it should be an acceptable use even if it's less commonly
> used in some other English-speaking parts of the world.
> ...
> They are not confusing in the way they are used. That is 'does not
> impact' in the maning 'has no or negligible effect', and especially in
> the cases where the degree of effect is not considered and only there
> being an effect or not is discussed there is no room for confusion.
> ...
> ...
> This topic somewhat interests me so I was continuing this discussion
> in the hope that you either provide a specific very confusing use of th=
e
> word impact in the documentation that triggered creating this patch or
> some solid evidence that the general use of word 'impact' as synonym fo=
r
> affect/effect is in some way problematic but niether happened.
>
> I think this topic has been discussed sufficiently and there is nothing
> more to add.

Thanks.

As you said, lack of a specific example of what is universally
confusing, or at least confusing to a not-so-insignificant part of
the readership, was why this change didn't gain much support.  There
might be one or two such places where the updated text does read
better, but it is not a very good use of reviewers' time to find
such needles in 700+ line haystack of a patch.
