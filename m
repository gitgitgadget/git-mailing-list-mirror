Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B12C433F5
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 17:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345980AbiDGRNZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 13:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiDGRNY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 13:13:24 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B2B1EC62E
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 10:11:17 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2FC3817C884;
        Thu,  7 Apr 2022 13:11:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=h/Y6eB2vuTaO
        Sb1x/QnxbxLww//ZqeRG+l4lWqF+69M=; b=QFsw5Cy4tBQlGBNztc/UcdcBXCNa
        WLaxxjYONNl3wS26YeK/bVMgX2psk/QXKAbW+RWKROK4QB6HOKrxgJ7+yaWAG+KS
        zEbJuRWpR1vK1op8NKH3tkTLM2+sguT/QBji9fmGK9Ts6x0/tmEkIzJjOH9MhZxP
        +nu4Kj+6GE+kszE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2878417C883;
        Thu,  7 Apr 2022 13:11:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5EA2817C87C;
        Thu,  7 Apr 2022 13:11:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH] git-ls-tree.txt: fix the name of "%(objectsize:padded)"
References: <20220407155231.2528221-1-martin.agren@gmail.com>
Date:   Thu, 07 Apr 2022 10:11:11 -0700
In-Reply-To: <20220407155231.2528221-1-martin.agren@gmail.com> ("Martin
        =?utf-8?Q?=C3=85gren=22's?= message of "Thu, 7 Apr 2022 17:52:31 +0200")
Message-ID: <xmqq8rsgu8cw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B9BA92DC-B695-11EC-AB65-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> Commit 455923e0a1 ("ls-tree: introduce "--format" option", 2022-03-23)
> introduced `--format` and the various placeholders it can take, such as
> %(objectname) and %(objectsize).
>
> At some point when that patch was being developed, those placeholders
> had shorter names, e.g., %(name) and %(size), which can be seen in the
> commit message of 455923e0a1. One instance of "%(size:padded)" also
> managed to enter the documentation in the final version of the patch.
> Correct it to "%(objectsize:padded)".
>
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---
>  Documentation/git-ls-tree.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks.


> diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.=
txt
> index 43aebb9938..8f31e2ee9d 100644
> --- a/Documentation/git-ls-tree.txt
> +++ b/Documentation/git-ls-tree.txt
> @@ -156,7 +156,7 @@ objectname::
>  	The name of the object.
>  objectsize[:padded]::
>  	The size of the object ("-" if it's a tree).
> -	It also supports a padded format of size with "%(size:padded)".
> +	It also supports a padded format of size with "%(objectsize:padded)".
>  path::
>  	The pathname of the object.
