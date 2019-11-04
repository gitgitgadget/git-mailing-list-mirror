Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E61A1F454
	for <e@80x24.org>; Mon,  4 Nov 2019 04:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfKDEOI (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Nov 2019 23:14:08 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63394 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbfKDEOI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Nov 2019 23:14:08 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F3E4289AB9;
        Sun,  3 Nov 2019 23:14:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KhPAnA5MXdhp606f9kjqPWpiy04=; b=RS3zr/
        USfjV7pzXbBpLe9/OaZuIURkZeJSRmXdh3hzVAGNfSIAIyjoMgbUnptqQlHHsZ/K
        ped/htULYmiZqbVTby2KsRLKrLBxtfrAgHooP0nv4YLpaZ3gRYg/SaS8O3ycf6xs
        cfnvDNmDs4CMu45V2ymiJGy/Wc2vQH4rAM3fU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KIFvZ9/z8kTflAFM3eeGACTJelNd55Io
        yYEHLSGYxH4qORgAXXqIB12Y6B3BouOdaVvldGMKAcJqjk5BmpCehuDsfsOBtKns
        1SUGJB0IstP0YkycGCWojls4TwMG6sogPmyGXeN4v2dKRJ2stWg4V6PdwW1SQzos
        j7gFOR0koHo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EC5C389AB8;
        Sun,  3 Nov 2019 23:14:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CAF4889AB5;
        Sun,  3 Nov 2019 23:14:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Abimbola via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Abimbola Olaitan <craftwordltd@gmail.com>
Subject: Re: [PATCH 5/5] fix unproper comment in Makefile
References: <pull.442.git.1572753114.gitgitgadget@gmail.com>
        <58035fc61390d42bc97697de54d44f328f110acd.1572753114.git.gitgitgadget@gmail.com>
Date:   Mon, 04 Nov 2019 13:13:59 +0900
In-Reply-To: <58035fc61390d42bc97697de54d44f328f110acd.1572753114.git.gitgitgadget@gmail.com>
        (Abimbola via GitGitGadget's message of "Sun, 03 Nov 2019 03:51:54
        +0000")
Message-ID: <xmqqtv7kz3aw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 882B8762-FEB9-11E9-B66E-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Abimbola via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Abimbola <craftwordltd@gmail.com>
>
> Signed-off-by: Abimbola <craftwordltd@gmail.com>
> ---
>  Makefile | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index a632505ad9..41f0fcb78f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1033,7 +1033,6 @@ LIB_OBJS += zlib.o
>  
>  BUILTIN_OBJS += builtin/add.o
>  BUILTIN_OBJS += builtin/am.o
> -// BUILTIN_OBJS += builtin/annotate.o
>  BUILTIN_OBJS += builtin/apply.o
>  BUILTIN_OBJS += builtin/archive.o
>  BUILTIN_OBJS += builtin/bisect--helper.o

If you are ever going to reroll this topic, please clean up your
series before sending it out.  3/5 introduced a bogus line this step
removes; it should have used the right comment char "#" instead, or
better yet, just drop both.  

Find where you are doing "oops, the change done in the previous step
was wrong, and here is a commit to bring it into the right state"
and learn to use "rebase -i" to eliminate such a "oops, another band
aid on top"; it is a useful skill.

Having said that, if the topic is only to remove builtin/annotate.c,
I would expect that it would be a single patch topic (i.e. Makefile,
reference in git.c and builtin/annotate.c all must be modified or
removed at the same time).

Thanks.



