Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9432AC433E6
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 06:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ACF522D6E
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 06:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbhAFGGM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 01:06:12 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59179 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbhAFGGL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 01:06:11 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 40C70AEE4C;
        Wed,  6 Jan 2021 01:05:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=9cJFzD4zxZzUosMP2cIpyuXHJ
        es=; b=G+vxAs1APox8jlP0ELbzjE5cL0dg/GQeWTLaOU+XFCJGKSYmZUuUAXMl3
        H1PBkg7p5XkimXmtx7GmmuMVvTtP+QSJGrcnuytPhx2igklwOJotdGOaSLOaOp2P
        RoltwORTqxKoJA6ToGevk5RNhnAdWsogFab9yFTVBtnwELodWg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=uFF7GN6AheyYDcf7RmN
        y9e0LeONOQHh9hdqPN2an1mcErvw09WNXCgN+ABS4IY1+Q2GnWw+CWnIxY64aS61
        rVa8VlmpKqLXzWu698xkq/YqJPkw9WktX6G8zOGBmmGSo3/5h02TDL66f+DH9h+3
        WnbwFs/jP7jwU5eLeizgyXb0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 375DBAEE4B;
        Wed,  6 Jan 2021 01:05:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A6694AEE4A;
        Wed,  6 Jan 2021 01:05:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Thomas Ackermann via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Thomas Ackermann <th.acker@arcor.de>
Subject: Re: [PATCH v2] doc: fix some typos
References: <pull.831.git.1609609214040.gitgitgadget@gmail.com>
        <pull.831.v2.git.1609683950823.gitgitgadget@gmail.com>
        <CAN0heSrxMTEzt+vCaRYAe6YeORhQb5+eBa0S=6q7Wctd__EtoA@mail.gmail.com>
Date:   Tue, 05 Jan 2021 22:05:28 -0800
Message-ID: <xmqq35zevbvb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2D0EC186-4FE5-11EB-9615-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> Hi Thomas,
>
> On Sun, 3 Jan 2021 at 15:25, Thomas Ackermann via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Thomas Ackermann <th.acker@arcor.de>
>>
>> Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
>> ---
>>     doc: fix some typos
>>
>>     Changed since v1:
>>
>>      * Removed changes in non-doc file contrib/buildsystems/CMakeLists=
.txt
>>        from the patch. Thanks to Martin and Felipe for pointing this o=
ut.
>
> This looks good to me.
>
> Martin

Thanks, all.

