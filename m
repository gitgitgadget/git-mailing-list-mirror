Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1110D20958
	for <e@80x24.org>; Sat,  1 Apr 2017 18:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751899AbdDASe0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 14:34:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55122 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751798AbdDASeZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2017 14:34:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4A4DB6B711;
        Sat,  1 Apr 2017 14:34:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pJCHafzVlV6XPQR72XIlQR9kKEM=; b=eKjxPG
        U/CzjwDcAu/Knswgg2MDXfl4Fi1iztzCTNjEDd16I737heswrpnFBTzvyItFke3x
        KJ/p3vAb+OTxIcsk1tzO0dyHKOvfVQKZKAs1UA6teHUmcuLePg1bwTPieGK2bF8j
        HsmkEcom7xFxRkRtmZb3iIc8WDRbCp8HcRiL8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NtVhGTKagxhfbT5sEumTafGA/GMRBPl5
        5ntGBST39YhCMTaqwDvOc8PycHgTICBBAUzhPn5JTvci26QL+7xFTwtu5lTpLVxl
        lmmw60gZpnP/Kl1zQPgLVZUumva7Fv/23cXaIpMKTOMoyo1pTewMakUlosPBx3Uu
        y4S7++XSkbU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 43B636B710;
        Sat,  1 Apr 2017 14:34:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 728EE6B70E;
        Sat,  1 Apr 2017 14:34:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Quentin Pradet <quentin.pradet@gmail.com>
Cc:     git@vger.kernel.org,
        Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH] git-bisect.txt: add missing word
References: <20170401064056.56969-1-quentin.pradet@gmail.com>
Date:   Sat, 01 Apr 2017 11:34:21 -0700
In-Reply-To: <20170401064056.56969-1-quentin.pradet@gmail.com> (Quentin
        Pradet's message of "Sat, 1 Apr 2017 10:40:56 +0400")
Message-ID: <xmqq37dsugcy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D3DE936A-1709-11E7-8F08-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Quentin Pradet <quentin.pradet@gmail.com> writes:

> Signed-off-by: Quentin Pradet <quentin.pradet@gmail.com>
> ---
>  Documentation/git-bisect.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

The updated text is more grammatically correct.  It would have been
better if you avoided wrapping the lines unnecessarily, though.

Thanks.

> diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
> index bdd915a66..90148bb07 100644
> --- a/Documentation/git-bisect.txt
> +++ b/Documentation/git-bisect.txt
> @@ -137,9 +137,9 @@ respectively, in place of "good" and "bad". (But note that you cannot
>  mix "good" and "bad" with "old" and "new" in a single session.)
>  
>  In this more general usage, you provide `git bisect` with a "new"
> -commit has some property and an "old" commit that doesn't have that
> -property. Each time `git bisect` checks out a commit, you test if that
> -commit has the property. If it does, mark the commit as "new";
> +commit that has some property and an "old" commit that doesn't have
> +that property. Each time `git bisect` checks out a commit, you test if
> +that commit has the property. If it does, mark the commit as "new";
>  otherwise, mark it as "old". When the bisection is done, `git bisect`
>  will report which commit introduced the property.
