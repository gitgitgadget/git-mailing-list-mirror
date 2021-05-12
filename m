Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B61C43603
	for <git@archiver.kernel.org>; Wed, 12 May 2021 23:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88AC8613FB
	for <git@archiver.kernel.org>; Wed, 12 May 2021 23:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238468AbhELXZu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 19:25:50 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54174 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349782AbhELWta (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 18:49:30 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 02C2712B010;
        Wed, 12 May 2021 18:48:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=5o9BjDblObte
        Oi9DenHqDyNf3LeTvo7bq9C6zy7sbgc=; b=JA8uAslG+gGiB9YIMTKnrfyFV22Z
        IK4V+wRxuaTp5jjQDThu2qaCFsrE3tn3xcxdmMnThou+MA3cXtoiBe4UEnKuPF9p
        ORJxHDDlVIFaETdM7LGR0aQIOHgEgN2rIH22568SCpoEpT6gGWGLmdgjM1Rao2Cc
        1ichBeOdMneDeiQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F09C512B00F;
        Wed, 12 May 2021 18:48:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 39F8812B00E;
        Wed, 12 May 2021 18:48:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Louis Sautier via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Louis Sautier <sautier.louis@gmail.com>
Subject: Re: [PATCH] pretty: fix a typo in the documentation for %(trailers)
References: <pull.1023.git.git.1620818283024.gitgitgadget@gmail.com>
Date:   Thu, 13 May 2021 07:48:16 +0900
In-Reply-To: <pull.1023.git.git.1620818283024.gitgitgadget@gmail.com> (Louis
        Sautier via GitGitGadget's message of "Wed, 12 May 2021 11:18:02
        +0000")
Message-ID: <xmqqv97nefgv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 24F4B738-B374-11EB-B116-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Louis Sautier via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Louis Sautier <sautier.louis@gmail.com>
>
> This just changes occurance to occurrence.
>
> Signed-off-by: Louis Sautier <sautier.louis@gmail.com>
> ---
>     pretty: fix a typo in the documentation for %(trailers)
>    =20
>     Hi,
>    =20
>     Here is a very minor change: occurance =E2=86=92 occurrence ?

Thanks.

> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-fo=
rmats.txt
> index cd697f508c53..ea9b26c3f734 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -271,7 +271,7 @@ endif::git-rev-list[]
>  			  `trailers` string may be followed by a colon
>  			  and zero or more comma-separated options.
>  			  If any option is provided multiple times the
> -			  last occurance wins.
> +			  last occurrence wins.
>  +
>  The boolean options accept an optional value `[=3D<BOOL>]`. The values
>  `true`, `false`, `on`, `off` etc. are all accepted. See the "boolean"
>
> base-commit: a0f521b56c724f4e21eef1cec2d456b1dbd72c10
