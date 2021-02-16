Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE6DC433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 18:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80D6F64E42
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 18:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhBPSqb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 13:46:31 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54333 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbhBPSqa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 13:46:30 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 535A5119604;
        Tue, 16 Feb 2021 13:45:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IUVK2rxYB1Ys5UtRATC6zwMOpVw=; b=R049pn
        yDjxusa5JIvMqAgVpQC0OEyZQz3ryB8vm92hBdg0YMTOEi+zMKjLWtiP6xJmqpxR
        m6Js+nT9LtZRlAe+Swmg6/5i4mK9W74W3ICDqUS1ZMKW04MsKRTtVaIvt4yiJf0z
        kpcoC3dnA6E8UCBTTFiwhKeC0+B9tT53YAP44=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fAxpcblJXZhlEYeaodkYVdH3V/Ea5LP/
        Al1K0HZ+0GTcad2XB/VdxqIWYXED+YGEsnyQCpJvFiqzFY6kmvRUOwvSkMBXV1ry
        xKwfFn8MPBKupLlirUMPdiFJL+22doGTKW0O3q/WLkWrrCYOFKIu8LFzmxWov43i
        3pqJDldqUn8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4B9BD119603;
        Tue, 16 Feb 2021 13:45:48 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8CBA4119601;
        Tue, 16 Feb 2021 13:45:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Ryan Zoeller <rtzoeller@rtzoeller.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v5 0/2] difftool.c: learn a new way start at specified file
References: <pull.870.v4.git.1613308167239.gitgitgadget@gmail.com>
        <pull.870.v5.git.1613480198.gitgitgadget@gmail.com>
Date:   Tue, 16 Feb 2021 10:45:43 -0800
In-Reply-To: <pull.870.v5.git.1613480198.gitgitgadget@gmail.com> (ZheNing Hu
        via GitGitGadget's message of "Tue, 16 Feb 2021 12:56:35 +0000")
Message-ID: <xmqqblcjrgvc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2DC8B830-7087-11EB-9D58-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Junio C Hamano (1):
>   diff: --{rotate,skip}-to=<path>

That's not part of your series (didn't I ask you not to include it)?

> ZheNing Hu (1):
>   difftool.c: learn a new way start at specified file

Will see what I find, but I may not be able to get to it today.

Thanks.
