Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AACC2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 20:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76C0B2076E
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 20:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CiMPvxsw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbgKXUzx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 15:55:53 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59934 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbgKXUzx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 15:55:53 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CAE1A9650F;
        Tue, 24 Nov 2020 15:55:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YYJgdfawOIzYSnI5+0BVgnHTWJI=; b=CiMPvx
        swy8PrmT5Omy1URbKKx+agZelMF+0Fw5TvJA9lMGaE4vid1xCC3QokuMDbmnrK+A
        9+nhaWn4w5/eORLrgEMvox5M/g0YjKyiLNuNGOSSL9Tl8Qx/EPZ3FMg7gWFiY22f
        a7PMCDuI0LSc8X2Dr9FiPMWdoykAJJ69nPl44=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=S4voAzUNumg+OFJJbBZ8IO2iyFZSB9Rd
        Mq7qjk5AhYUVlwUAMXncg6bk/ONQQ0yMvWIBJBl9Rl3OIAq3D3IGuJe+Futfqq/V
        LWDV2kLVPl15eiAe0+4yajsZy3HDuDeJVHcg8BLRy7e5mgfe9v1WCKvQLrEX6N9b
        fpRQdR6Y5Js=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C2E699650E;
        Tue, 24 Nov 2020 15:55:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 558E19650D;
        Tue, 24 Nov 2020 15:55:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] stash: add missing space to an error message
References: <20201124005212.13780-1-kyle@kyleam.com>
Date:   Tue, 24 Nov 2020 12:55:49 -0800
In-Reply-To: <20201124005212.13780-1-kyle@kyleam.com> (Kyle Meyer's message of
        "Mon, 23 Nov 2020 19:52:12 -0500")
Message-ID: <xmqq4klejwyy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6F172722-2E97-11EB-904F-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kyle Meyer <kyle@kyleam.com> writes:

> Restore a space that was lost in 8a0fc8d19d (stash: convert apply to
> builtin, 2019-02-25).
>
> Signed-off-by: Kyle Meyer <kyle@kyleam.com>
> ---

Makes sense.  Thanks.

>  builtin/stash.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/stash.c b/builtin/stash.c
> index 24ddb1bffa..e1f8235fdd 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -419,7 +419,7 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
>  			ret = apply_cached(&out);
>  			strbuf_release(&out);
>  			if (ret)
> -				return error(_("conflicts in index."
> +				return error(_("conflicts in index. "
>  					       "Try without --index."));
>  
>  			discard_cache();
>
> base-commit: b291b0a628020eedb10b6236d87fe25d295cea81
