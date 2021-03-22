Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773EEC433C1
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 04:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B98961968
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 04:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhCVE00 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 00:26:26 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55822 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhCVEZz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 00:25:55 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ADD71112052;
        Mon, 22 Mar 2021 00:25:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yWzg6NYakCbiuuNTc5NLMvyKdPk=; b=VW962q
        WJ9jzIj70Ou3sA36r/iWwFNO3S28iQpx8Ju5ephZgKjUUilXRoSMRmviuDTJvq4Y
        yAhcrtKU0LHGOFhwOzrm6oRX+mxisxeZyqCiEJe4TQ7IRXORJragZScVgWA5Q95O
        TWsS+Q8PyqdH/cz/DBT/0ztU7CzUFdhLiSbds=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BCgQ5ERwZyNiDck90roFgDy+LLs1N1Ud
        MegCNhKbHs1MlJ5XyDKBJYBsQb9D4/krXNIEvm6HCxt7B4Ddpt0Ry+iOQyHBi79z
        bTOXTbjmR/WNBYLRfStukUFhgylAY3fz59RO0Beu4k6UjvCHXjJBPYDxxlIi6q0z
        pOk6EMGCvIg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A7A27112050;
        Mon, 22 Mar 2021 00:25:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F21D111204F;
        Mon, 22 Mar 2021 00:25:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Georgios Kontaxis" <geko1702+commits@99rst.org>
Cc:     "Georgios Kontaxis via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3] gitweb: redacted e-mail addresses feature.
References: <pull.910.v2.git.1616297564158.gitgitgadget@gmail.com>
        <pull.910.v3.git.1616347731514.gitgitgadget@gmail.com>
        <xmqqzgyw9wn3.fsf@gitster.g>
        <dfb1fe6cdf78788250009abe8e1489c8.squirrel@mail.kodaksys.org>
        <xmqqmtuw884f.fsf@gitster.g>
        <14d3cda766b0212ca9d8204eba35aa4d.squirrel@mail.kodaksys.org>
Date:   Sun, 21 Mar 2021 21:25:50 -0700
In-Reply-To: <14d3cda766b0212ca9d8204eba35aa4d.squirrel@mail.kodaksys.org>
        (Georgios Kontaxis's message of "Sun, 21 Mar 2021 23:14:14 -0000")
Message-ID: <xmqqft0n95m9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AFA7871A-8AC6-11EB-A42A-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Georgios Kontaxis" <geko1702+commits@99rst.org> writes:

>> Quite honestly, if a site claims to offer a 'patch' download UI but
>> returns corrupt data back, I would say it is much worse than not
>> offering the service at all.  Perhaps disabling the 'patch' feature
>> in repositories that enable 'privacy' feature may be a much better
>> approach.
>>
> Good point. I think I'll try that.

Alternatively, we could add 'captcha' to stop crawlers, perhaps?
