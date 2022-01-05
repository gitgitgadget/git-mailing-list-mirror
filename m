Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F51CC433F5
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 21:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244501AbiAEVcb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 16:32:31 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63835 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244504AbiAEVbt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 16:31:49 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 83F1F1003E5;
        Wed,  5 Jan 2022 16:31:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=uYUiiooRHva5
        Piuu112klu5hsMKzx2VHc8qf0QH/Z8o=; b=HjZOAKAN6MJzei8UfyP7T+AB8kBF
        rlDnLFJrE573K/lpZZDvlEVNApKjgdlq8OD+H/l3+WXnhnffp1Bh63QED4+xSkVF
        YsJHUADCO/3AMyYWsCnhqywxEM1+M0aDMKlY++diL2GTkJPmzlzIU58kJLS8Auvi
        /3u29W3qJ4ti8JI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A8671003E4;
        Wed,  5 Jan 2022 16:31:48 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DD9F31003E2;
        Wed,  5 Jan 2022 16:31:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH v5 00/11] Factorization of messages with similar meaning
References: <pull.1088.v4.git.1641143745.gitgitgadget@gmail.com>
        <pull.1088.v5.git.1641412944.gitgitgadget@gmail.com>
        <478ed4c7-467d-384d-b6d9-68956dc39c41@kdbg.org>
Date:   Wed, 05 Jan 2022 13:31:46 -0800
In-Reply-To: <478ed4c7-467d-384d-b6d9-68956dc39c41@kdbg.org> (Johannes Sixt's
        message of "Wed, 5 Jan 2022 21:58:27 +0100")
Message-ID: <xmqqwnjdg98d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E338A7DA-6E6E-11EC-A9C0-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

>>  * Apply changes by Ren=C3=A9 on tag.c
>>  * cosmetic changes
>
> This round looks good to me, with one caveat: I am not a translator, no=
r
> do I use a translated version of Git. So, I haven't verified the claim
> that the number translatable strings was reduced greatly, nor whether
> there are any accidential duplicates due to typos. I infer the
> correctness only by looking at the changes.

Thanks, both.  Will queue with a touch-up for that doubled SP.
