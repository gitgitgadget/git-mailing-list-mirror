Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DF4C433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 19:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8196860F92
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 19:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbhJ1TY5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 15:24:57 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61257 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbhJ1TY5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 15:24:57 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DEDE7154BDA;
        Thu, 28 Oct 2021 15:22:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ECkudZftBrOh
        lh8h73+VTeQx7zZMqpRghBXG4kPcgYM=; b=WQ8lxC4z0z4lGomlh1rOTkypQTjJ
        wbrdmfQXsni+0f05pQUm7dq0PowulEGePuLZVpPTCOysyPe2Ckybqt+tkqL6dK24
        Lt7/8v7DlaqF7eygyFxl/uOHwfyPVpcAoFSEoiR2vKF3EOEPeUVzprLDiK99T2VC
        zHaEg5iV2XFPvw4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D5CBA154BD9;
        Thu, 28 Oct 2021 15:22:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2E5B8154BD8;
        Thu, 28 Oct 2021 15:22:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH v2 0/9] doc: fix grammar rules in commands' syntax
References: <pull.1066.git.1635261072531.gitgitgadget@gmail.com>
        <pull.1066.v2.git.1635438124.gitgitgadget@gmail.com>
Date:   Thu, 28 Oct 2021 12:22:26 -0700
In-Reply-To: <pull.1066.v2.git.1635438124.gitgitgadget@gmail.com>
 (=?utf-8?Q?=22Jean-No=C3=ABl?=
        Avila via GitGitGadget"'s message of "Thu, 28 Oct 2021 16:21:55
        +0000")
Message-ID: <xmqqv91hq7il.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 62F85424-3824-11EC-B97C-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jean-No=C3=ABl Avila via GitGitGadget"  <gitgitgadget@gmail.com> writes:

> There are command expressions which do not follow the grammar syntax ru=
les.
>
> According to the coding guidelines, the placeholders must:
>
>  * be in small letters
>  * enclosed in angle brackets
>  * use hyphens as spaces
>
> They also must represent tokens' meaning as atomic entities.
>
> Some fixups for git-credential, git-ls-files, git-init and git-http-pus=
h.
>
> changes since v1:
>
>  * split changes across simpler commits
>
> Signed-off-by: Jean-No=C3=ABl Avila jn.avila@free.fr
>
> Jean-No=C3=ABl Avila (9):
>   doc: fix git credential synopsis
>   doc: split placeholders as individual tokens
>   doc: express grammar placeholders between angle brackets
>   doc: use only hyphens as word separators in placeholders
>   doc: git-ls-files: express options as optional alternatives
>   doc: use three dots for indicating repetition instead of star
>   doc: uniformize <URL> placeholders' case
>   doc: git-http-push: describe the refs as pattern pairs
>   doc: git-init: clarify file modes in octal.

Thanks.  All looked good to me.
