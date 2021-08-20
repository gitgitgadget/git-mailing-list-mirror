Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88D9C4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 18:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DB7561053
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 18:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235484AbhHTSBc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 14:01:32 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55092 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235319AbhHTSBb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 14:01:31 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 665A4140A94;
        Fri, 20 Aug 2021 14:00:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=If6LUjWgT73+
        oZ1KsDKIhCrF8u6G1HufDShiX85AqJ8=; b=WafcVlxS0JGgwbdrASAP65wud+sq
        fwahFPQ6bIutwCCOi50BfiD94A4hqHN0sTX6GjL/j5kjscZ24MuFtw+aLTuFHnQO
        ssKXCkMOj+F0xxZiWuoRFA/Tap4Xz3M7Q8XzoaLicUSwPjTr3ScflWh5cc6oN7D9
        UbekrcjS7dbaLFI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5C087140A92;
        Fri, 20 Aug 2021 14:00:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9F6FB140A8F;
        Fri, 20 Aug 2021 14:00:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Rafael Silva <rafaeloliveira.cs@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [GSoC] The Final Git Dev Blog(s)
References: <m2lf4wys5o.fsf@gmail.com>
Date:   Fri, 20 Aug 2021 11:00:48 -0700
In-Reply-To: <m2lf4wys5o.fsf@gmail.com> (Atharva Raykar's message of "Fri, 20
        Aug 2021 20:05:32 +0530")
Message-ID: <xmqq7dgguhbj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8DE836EC-01E0-11EC-AE47-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Atharva Raykar <raykar.ath@gmail.com> writes:

> This won't be the last time you will see me on the list, of course. I
> still have patches waiting to make it to the list, and other work
> undergoing review=E2=80=94the only difference now is that it won't be u=
nder the
> GSoC banner anymore.

I hoped everybody participated in this year's GSoC had a great time,
and you certainly seem to have.

Thanks for your participation. =20
