Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F2851F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 17:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752414AbcJERw3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 13:52:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59457 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752124AbcJERw3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 13:52:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BBE4344B23;
        Wed,  5 Oct 2016 13:52:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1n9Er/QBkH09eI0dHn/G52FX+Ks=; b=gZmmKA
        Z2Eqr8tu4//UBKd5FaPfA0stngdLsqJlheYMnrNDHTcYOhzFus8BCZNPiAaz78NV
        OaEsnNULPTKh0DtQe6Jvp5CSmFOixYjWADAb1z4YNA0k91XMoFonfBOVJ/jtvvYx
        1iwxM+6HUooXtmziAnsGvyTWsB9mDicycWVbg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=d9+T8Fgdt9Wq3xFD7OVp/4dHQUAdqDSN
        fGOtMzbW9QlWLl/73myU4ZE7QVoVdqRY4VRSHvlldnx+bpqlEMhUtrjif/Bq7XKH
        0JqxmaFpBIk8jNUtSBA/hqRzoI3Fer3i4hyuryF/rJ1ANm1XWlcAyqZqfkCCCWGG
        8km7OX7ORZg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B44F044B21;
        Wed,  5 Oct 2016 13:52:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 39F6244B20;
        Wed,  5 Oct 2016 13:52:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     sorganov@gmail.com
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/6] Documentation/git-merge.txt: improve short description in NAME
References: <cover.1475678515.git.sorganov@gmail.com>
        <a33dd3ec3da0dc2dad72ed85edd29ff01f898831.1475678515.git.sorganov@gmail.com>
Date:   Wed, 05 Oct 2016 10:52:25 -0700
In-Reply-To: <a33dd3ec3da0dc2dad72ed85edd29ff01f898831.1475678515.git.sorganov@gmail.com>
        (sorganov@gmail.com's message of "Wed, 5 Oct 2016 17:46:22 +0300")
Message-ID: <xmqqa8eiptt2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7A8C7EF6-8B24-11E6-B3F6-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

sorganov@gmail.com writes:

> From: Sergey Organov <sorganov@gmail.com>
>
> Old description not only raised the question of why the tool is called
> git-merge rather than git-join, but "join histories" also sounds like
> very simple operation, something like what "git-merge -s ours" does.
>
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  Documentation/git-merge.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
> index 216d2f4..cc0329d 100644
> --- a/Documentation/git-merge.txt
> +++ b/Documentation/git-merge.txt
> @@ -3,7 +3,8 @@ git-merge(1)
>  
>  NAME
>  ----
> -git-merge - Join two or more development histories together
> +
> +git-merge - Merge one or more branches to the current branch

This patch, evaluated by itself, looks like a regression in that it
tries to explain "merge" by using verb "merge", making it fuzzier to
those who do not yet know what a "merge" is.  That was why it tried
to explain "merge" as an operation to join histories.

However, the next one, 5/6, resurrects the "join history" in the
description part to help them, so the damage is not so severe when
we take them together.

I haven't formed firm opinion on this patch yet.
