Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A00BC3498B
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3082247F8
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EB/Jh96a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbfLMTxe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 14:53:34 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52757 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728863AbfLMTxd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 14:53:33 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6F952192D6;
        Fri, 13 Dec 2019 14:53:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Bd4oaqZ1uGK7
        H+xEwgJrJltR+ZI=; b=EB/Jh96aCi+v/q0cs1oSYc2gk46kaP71ObBk5x6xKoOb
        lXcbgXcwJkpNy1XSQzviOGDqjL1PR0teoO9UE6UJfNMhSlk9w3jFll7zpFC80/yP
        +LrWtGBNL0hfGX/CbxmM7skiblOr+sMtCrTPbP+gls/VQOJpDnmqQ/G3CA4sjxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=WXH4IP
        0KSTGZ/ctE+YbCeIe9NPgapgyRfrdsgrmYWTgaU00cyWAcA3Zk/7QoA8lxfjcwbd
        6L3LZGsJ7gIUiR1OPbZVXrsX4ICFhNmgmi8akk2A0yWhwUjav3oyOh3tPZuqlFek
        6RLgk6fybVz4+WCkf5l1DpsUVZPV57qnNH5lk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 663F7192D5;
        Fri, 13 Dec 2019 14:53:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 845A0192D4;
        Fri, 13 Dec 2019 14:53:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] doc: remove non pure ASCII characters
References: <20191212204655.10425-1-jn.avila@free.fr>
        <20191212204655.10425-2-jn.avila@free.fr>
Date:   Fri, 13 Dec 2019 11:53:31 -0800
In-Reply-To: <20191212204655.10425-2-jn.avila@free.fr> (=?utf-8?Q?=22Jean-?=
 =?utf-8?Q?No=C3=ABl?= Avila"'s
        message of "Thu, 12 Dec 2019 21:46:54 +0100")
Message-ID: <xmqqk170j938.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3DD7C91C-1DE2-11EA-951D-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-No=C3=ABl Avila <jn.avila@free.fr> writes:

> Non ASCII characters may be handled by publishing chains, but right
> now, nothing indicates the encoding of files. Moreover, non ASCII
> source strings upset the localization toolchain.
>
> Signed-off-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>
> ---
>  Documentation/git-clone.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks.  I've always wanted to do this, but it is a bit surprising
that there is only this single instance?

> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index 34011c2940..2e8babe671 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -262,9 +262,9 @@ or `--mirror` is given)
>  	All submodules which are cloned will be shallow with a depth of 1.
> =20
>  --[no-]remote-submodules::
> -	All submodules which are cloned will use the status of the submodule=E2=
=80=99s
> +	All submodules which are cloned will use the status of the submodule'=
s
>  	remote-tracking branch to update the submodule, rather than the
> -	superproject=E2=80=99s recorded SHA-1. Equivalent to passing `--remot=
e` to
> +	superproject's recorded SHA-1. Equivalent to passing `--remote` to
>  	`git submodule update`.
> =20
>  --separate-git-dir=3D<git dir>::
