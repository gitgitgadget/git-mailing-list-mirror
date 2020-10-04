Return-Path: <SRS0=wQ61=DL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96B4C4363C
	for <git@archiver.kernel.org>; Sun,  4 Oct 2020 19:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86546206B6
	for <git@archiver.kernel.org>; Sun,  4 Oct 2020 19:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="txpPMy0X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgJDT4U (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Oct 2020 15:56:20 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58547 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgJDT4U (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Oct 2020 15:56:20 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 942C3FB4B9;
        Sun,  4 Oct 2020 15:56:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=b6nVmLB7vHnETgvAW3xvFXEtkts=; b=txpPMy
        0XUAGLkXp/t2o8b/3YXMAGKrZNdI3ljypAdHfC8uhzn9rMK30mERu00kLX7vhiU0
        3hxTjjShPbnwCr7nRfUpGA7gBJE9M9WAgaTPkMbjoOnpI0pzSIg7k9kqnkcFO55o
        yg2fyop8H7v3kOA62QClQOx0Js2NGPWYccfUo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JWsRC7RKxDwhjo3ZICUTIf/TyzpaH1g2
        sQ1w1JEmWYe+dq5zggIBxdVv37EY58kzNZa5rjYD9g0iwGDO8OhWgTxbLLSHEYBR
        PArIp47UuovtPPpB+2BrF7VtQnxpfgaXdH1zJgwdJZzS8nQlWdpnUH+T+7oK6Odk
        yvF5QdByQo0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8D252FB4B8;
        Sun,  4 Oct 2020 15:56:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D5459FB4B6;
        Sun,  4 Oct 2020 15:56:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Samanta Navarro <ferivoz@riseup.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fast-import: fix typo in documentation
References: <20201004114101.k5j7vhoxg5pyehmc@localhost>
Date:   Sun, 04 Oct 2020 12:56:14 -0700
In-Reply-To: <20201004114101.k5j7vhoxg5pyehmc@localhost> (Samanta Navarro's
        message of "Sun, 4 Oct 2020 11:41:01 +0000")
Message-ID: <xmqqk0w57okh.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A9782982-067B-11EB-80E9-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Samanta Navarro <ferivoz@riseup.net> writes:

> Signed-off-by: Samanta Navarro <ferivoz@riseup.net>
> ---
>  Documentation/git-fast-import.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
> index 7d9aad2..39cfa05 100644
> --- a/Documentation/git-fast-import.txt
> +++ b/Documentation/git-fast-import.txt
> @@ -814,7 +814,7 @@ may have uses for this information
>  	'original-oid' SP <object-identifier> LF
>  ....
>  
> -where `<object-identifer>` is any string not containing LF.
> +where `<object-identifier>` is any string not containing LF.

Thanks.
