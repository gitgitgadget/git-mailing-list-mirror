Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45558C33CA1
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 16:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A08A2075D
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 16:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="P5A0D0RG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbgAHQ6B (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 11:58:01 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65023 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbgAHQ6B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 11:58:01 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ED1F9A09EC;
        Wed,  8 Jan 2020 11:57:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0q5N8bMHw13lGeXAYEd785iPyPw=; b=P5A0D0
        RGU9nQss+Cj4dz2hHcWi42GtkuThTJcPOV6/IYecO0ImJW7O6gXpb9ofQPqgrRxS
        n1a8nSpg8ZG4AKS/E3jh9eth8+WdIxGWgMoWx6HihYD0tXDg7LcE4QdOpaUWAh8X
        taN+iI7Lf936LnjfEodk2l/ILCPbMaUwmhJMk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kb/HJh5DbSagWCT0/KvuxT0r8g2vzHBp
        BBEqOuYAmbFczE7K+ffuzgmNTkjGYdBbQTnM82B21kJBw80xdSmNBtEZzGcDHFz5
        KJ7ZZzXTvMT62YKe8yKcjaBNDbkdim/aON8DNEcPzQURTFqUhGajq5mpHYXqEkQs
        +pr8Tqw97Yg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E53CDA09EA;
        Wed,  8 Jan 2020 11:57:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 18AC0A09E9;
        Wed,  8 Jan 2020 11:57:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH v2 1/1] doc/gitcore-tutorial: fix prose to match example command
References: <pull.515.git.1578391553.gitgitgadget@gmail.com>
        <pull.515.v2.git.1578443496.gitgitgadget@gmail.com>
        <0c75cd8f9727b10af6f6a804177e551ba0217abf.1578443496.git.gitgitgadget@gmail.com>
Date:   Wed, 08 Jan 2020 08:57:53 -0800
In-Reply-To: <0c75cd8f9727b10af6f6a804177e551ba0217abf.1578443496.git.gitgitgadget@gmail.com>
        (Heba Waly via GitGitGadget's message of "Wed, 08 Jan 2020 00:31:36
        +0000")
Message-ID: <xmqqr2093my6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 045F8E26-3238-11EA-B8CD-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Heba Waly via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Heba Waly <heba.waly@gmail.com>
>
> In 328c6cb853 (doc: promote "git switch", 2019-03-29), an example
> was changed to use "git switch" rather than "git checkout" but an
> instance of "git checkout" in the explanatory text preceding the
> example was overlooked. Fix this oversight.
>
> Signed-off-by: Heba Waly <heba.waly@gmail.com>
> ---
>  Documentation/gitcore-tutorial.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
> index f880d21dfb..c0b95256cc 100644
> --- a/Documentation/gitcore-tutorial.txt
> +++ b/Documentation/gitcore-tutorial.txt
> @@ -751,7 +751,7 @@ to it.
>  ================================================
>  If you make the decision to start your new branch at some
>  other point in the history than the current `HEAD`, you can do so by
> -just telling 'git checkout' what the base of the checkout would be.
> +just telling 'git switch' what the base of the checkout would be.
>  In other words, if you have an earlier tag or branch, you'd just do
>  
>  ------------

Thanks.  The part before this paragraph does illustrate the use of
"switch", and we should talk about that command here, too.

