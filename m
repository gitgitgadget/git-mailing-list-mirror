Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B96C433F5
	for <git@archiver.kernel.org>; Mon, 11 Apr 2022 19:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238650AbiDKTPo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Apr 2022 15:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235610AbiDKTPm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Apr 2022 15:15:42 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05FD21247
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 12:13:27 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ADAF4110610;
        Mon, 11 Apr 2022 15:13:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gZdDOQs9Dfk6K/qj/R8ROJmDAdc+7h6mvI1Gsi
        B0itc=; b=txjhJRt9anWxU7qhUIZZzElKOaRHZLGoenOP0MbC1O9qhEdQXZzYgF
        qX/4pvOhc7llXPbY/EJo8XkSEKFneed1TiBowT4JavDEDaCmioX2hNdh5KKwobkI
        9sB4ubE8XQTQkCdsoPAaHSTUH7NWZIvZTJ/jJ6CGkSqJmk0c9VJkU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A26E111060F;
        Mon, 11 Apr 2022 15:13:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AC23711060E;
        Mon, 11 Apr 2022 15:13:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tao Klerks <tao@klerks.biz>
Cc:     Joel Holdsworth <jholdsworth@nvidia.com>, git@vger.kernel.org,
        Luke Diamand <luke@diamand.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
Subject: Re: [PATCH v5 00/22] git-p4: Various code tidy-ups
References: <20220401142504.58995-1-jholdsworth@nvidia.com>
        <CAPMMpoh769htwJZ65FRHeLx=KEbxGPKo8CFJCQ5phCXNaNEhDQ@mail.gmail.com>
Date:   Mon, 11 Apr 2022 12:13:24 -0700
In-Reply-To: <CAPMMpoh769htwJZ65FRHeLx=KEbxGPKo8CFJCQ5phCXNaNEhDQ@mail.gmail.com>
        (Tao Klerks's message of "Sun, 10 Apr 2022 09:32:29 +0200")
Message-ID: <xmqqpmlnh1rf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 76629A14-B9CB-11EC-86FD-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tao Klerks <tao@klerks.biz> writes:

> On Fri, Apr 1, 2022 at 5:04 PM Joel Holdsworth <jholdsworth@nvidia.com> wrote:
>>
>> This patch set contains multiple patches to improve consistency and
>> tidyness of the git-p4 script's code style.
>>
>
> I'm not sure my review counts for much, but everything I see in this
> patch makes sense to me, and I've tested it under python2 and python3.
>
> Reviewed-by: Tao Klerks <tao@klerks.biz>

Thanks.
