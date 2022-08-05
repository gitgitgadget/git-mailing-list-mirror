Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258E4C3F6B0
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 22:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241730AbiHEWWF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Aug 2022 18:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241819AbiHEWWD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Aug 2022 18:22:03 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BED1CB0A
        for <git@vger.kernel.org>; Fri,  5 Aug 2022 15:22:02 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C8DD412F75D;
        Fri,  5 Aug 2022 18:22:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=n2dwE8Yu+Q5T
        8ntcGgUdYK/DNvUYkzjqEHaxAkgCF6g=; b=NuTvTKYsYUMSVSx2w8R875TGhZlz
        R4UtJ6Xd1viSpoxMnml3456q0X/FXAWpNnhkk6UIo3Kh7YhTRC8sy4g57wVmnMAh
        N/8pHlR8+N/JuRTHeVrFWw3zo8ObqSP1JB8hIeF/+YM5HdM4aw793I3zzxH+6ETd
        fWLVHuGMtDShBas=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AB87612F75B;
        Fri,  5 Aug 2022 18:22:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E1C9812F75A;
        Fri,  5 Aug 2022 18:21:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     avarab@gmail.com, "tenglong.tl" <dyroneteng@gmail.com>
Cc:     git@jeffhostetler.com, git@vger.kernel.org,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v1 1/2] api-trace2.txt: print config key-value pair
References: <220722.86fsits91m.gmgdl@evledraar.gmail.com>
        <20220801122515.23146-1-tenglong.tl@alibaba-inc.com>
Date:   Fri, 05 Aug 2022 15:21:58 -0700
In-Reply-To: <20220801122515.23146-1-tenglong.tl@alibaba-inc.com> (tenglong
        tl's message of "Mon, 1 Aug 2022 20:25:15 +0800")
Message-ID: <xmqqa68iz5yx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0619091C-150D-11ED-B89B-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"tenglong.tl" <dyroneteng@gmail.com> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> I didn't notice this before, but this is an addition to a long section
> ...
> I refer to the previous sections, it's like the template is :
>
> <title>
>
>         <brief one-line description>
>
> <detailed multi-lines description>
>
> So, how about this like:
>
> diff --git a/Documentation/technical/api-trace2.txt b/Documentation/tec=
hnical/api-trace2.txt
> index 77a150b30e..38d0878d85 100644
> --- a/Documentation/technical/api-trace2.txt
> +++ b/Documentation/technical/api-trace2.txt
> @@ -1207,6 +1207,37 @@ at offset 508.

So, what is the outcome from this discussion?  It seems that this
subthread on [1/2] is blocking the two-patch series?

Thanks.
