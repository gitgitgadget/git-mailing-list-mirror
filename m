Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E19C433F5
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 04:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01F8961057
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 04:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhICEjf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Sep 2021 00:39:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52489 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhICEje (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Sep 2021 00:39:34 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 115E2F1A69;
        Fri,  3 Sep 2021 00:38:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=AtDth85XOBOG
        g4ZQgnNvI0eS3uVlmkp8A5VLuUWgxrE=; b=R0J6KBgLT4oeIjCQ4VI9VdtJdq7i
        sd3pL8XU9yhhQsOgMTKHnCFn9xPm9h4XAYG1m0OgwfbWgkBPguHiAuzv0Cp0yi6Z
        bg6728RsrWbm3jeaAfK4p4GntsXke4IfX5nxGD1IevKOGVK2muQuq51XI4jqhkm3
        81xmDoPb5dO6yyo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 09084F1A68;
        Fri,  3 Sep 2021 00:38:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8DB5EF1A67;
        Fri,  3 Sep 2021 00:38:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2021, #01; Thu, 2)
References: <xmqq35qmiofp.fsf@gitster.g>
        <4a8296e4-6650-67d9-4d42-20fd2e88b6e3@gmail.com>
Date:   Thu, 02 Sep 2021 21:38:33 -0700
In-Reply-To: <4a8296e4-6650-67d9-4d42-20fd2e88b6e3@gmail.com> (Philippe
        Blain's message of "Thu, 2 Sep 2021 20:59:19 -0400")
Message-ID: <xmqqk0jygto6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CC59BE7E-0C70-11EC-BAC4-D601C7D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> Hi Junio,
>
> Le 2021-09-02 =C3=A0 18:48, Junio C Hamano a =C3=A9crit=C2=A0:
>> * pb/test-use-user-env (2021-09-01) 3 commits
>>   - test-lib-functions: optionally keep HOME and TERM in 'debug'
>>   - test-lib-functions: optionally keep HOME, TERM and SHELL in 'test_=
pause'
>>   - test-lib-functions: use 'TEST_SHELL_PATH' in 'test_pause'
>>   Teach test_pause and test_debug to allow using the HOME and TERM
>>   environment variables the user usually uses.
>>   Will merge to 'next'?
>
> I'll send a v4 that clarifies/generalizes the warnings as you and Elija=
h
> suggested. I'll also tweak the 'debug' patch a bit. So I'd prefer this
> stays in seen until then.

Thanks, will do.
