Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93CEC433B4
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 00:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B2EE613F7
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 00:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhD3As0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 20:48:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50791 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhD3AsZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 20:48:25 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1EBD0C09D2;
        Thu, 29 Apr 2021 20:47:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=+zMGAplcQ8dk
        gv9je9gERIGi8KiW53n6IQj0eTubb08=; b=c5iqLNf68K0lrndgqTjSq9xM6+uf
        bo3Mrsm+jlHosnma+fpTd61lgWEVutRa9uPvRy0Yd7OXbqUpxMj5XvJlzZn/9ZZc
        ftZ2yagRI/zNuMiYwQSWjkE3W+zN4mrfyhwrfsMuTQH/FhlBuXXZiEfgp25gIrDD
        npJa3/Fef1q8XNI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 11D6DC09D1;
        Thu, 29 Apr 2021 20:47:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 26A17C09D0;
        Thu, 29 Apr 2021 20:47:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v2 0/2] git: support separate arg for `--config-env`'s
 value
References: <cover.1618847606.git.ps@pks.im> <cover.1619700731.git.ps@pks.im>
        <YIsRQG7TFtt7MU2k@coredump.intra.peff.net>
Date:   Fri, 30 Apr 2021 09:47:36 +0900
In-Reply-To: <YIsRQG7TFtt7MU2k@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 29 Apr 2021 16:04:16 -0400")
Message-ID: <xmqqwnskegyf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A8A3741A-A94D-11EB-B6DB-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Apr 29, 2021 at 02:55:25PM +0200, Patrick Steinhardt wrote:
>
>> this is the second version of this series fixing inconsistencies with
>> the `--config-env` parameter. It's only got a single change compared t=
o
>> v1, which is to replace `test_i18ngrep` with `grep` as pointed out by
>> =C3=86var.
>
> Thanks, this version looks good to me.
>
> -Peff

Thanks, will replace.
