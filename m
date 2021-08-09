Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB263C4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 16:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A509F60F38
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 16:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbhHIQom (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 12:44:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56843 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbhHIQol (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 12:44:41 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4A517EB08E;
        Mon,  9 Aug 2021 12:44:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=WKbrzzNHszcv
        yxz7cOk6zyBi8ItM4jxAyKfE5BrJ5+g=; b=rBX9IPVBGT1zvbUxYRvSVmTWuCXW
        li/dIhuOgimTmedVI+z98s9XC5fYlBPMgeKAPkjCNh7A/S1tNiPwQzjBmeZI9fG0
        lULNfaANIDHUr7sqQnt0wlE2YMxTLpf0bE6yAnKFxfYFtHHOdPNa3wIZJRvlTbtt
        lmpktUWMEb8qPgw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4186EEB08D;
        Mon,  9 Aug 2021 12:44:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A87A7EB08C;
        Mon,  9 Aug 2021 12:44:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, e@80x24.org
Subject: Re: [PATCH/RFC 0/3] pedantic errors in next
References: <CAPUEsphf9F1+=zOMKx3j=jH8xqDwQX99+9uHiYUpXhFE1nervg@mail.gmail.com>
        <20210809013833.58110-1-carenas@gmail.com>
Date:   Mon, 09 Aug 2021 09:44:18 -0700
In-Reply-To: <20210809013833.58110-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Sun, 8 Aug 2021 18:38:30 -0700")
Message-ID: <xmqqtujyftzx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0AEEC4E8-F931-11EB-A16C-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> Building next with pedantic enabled shows the following 2 issues that
> were originally in ew/many-alternate-optim, apologies for not catching
> them earlier.

This of course affects 'master'.

The first two look trivially correct and I am tempted to take them
in -rc2; the last one, from my cursory look, I didn't see anything
wrong in it, but is not all that urgent, either.

> the second one could be skipped, and has indeed another similar case
> already in seen which will be send separately.

Thanks.
