Return-Path: <SRS0=ybwr=BB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D136C433DF
	for <git@archiver.kernel.org>; Wed, 22 Jul 2020 21:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9B5822B42
	for <git@archiver.kernel.org>; Wed, 22 Jul 2020 21:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TWczx0Fq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732842AbgGVVKL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 17:10:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60518 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgGVVKK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jul 2020 17:10:10 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9B883636D9;
        Wed, 22 Jul 2020 17:10:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MSwq/YnLALOX19mm86OB2Xs802Q=; b=TWczx0
        FqwowDxKUqxi7RzjtjHabp/xmHAWlHoEDt3pl07Suh1nGjoM7IEBXEn4VggFWbgR
        /XsGXXpFewtfa3qbuB0JtLjhJ+E2fv74cSlMWITFeqldUAjPP8TDoPqUEwjibeac
        1+uzkeHNrCCD9ymGSAtqM5mi/f8lnaGHg599E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=g2CNtf5CNWXj/9FzGzJJzRMxGDC5CIfW
        wNe8PktJMEgG90Yf9Jwku56jviTuvGHaUegVjgK5F1JwtfKhKl3rfeQ5DRKxG4Ca
        Qqd24wDN+5VtlJ3pHtlTvlMQmz66CUOFgLXu2QyAkGmvVqC9bqIGEHqLpKYORfv8
        Fh1yBB2/fOM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 879A5636D6;
        Wed, 22 Jul 2020 17:10:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 560E0636D5;
        Wed, 22 Jul 2020 17:10:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Documentation/RelNotes: fix a typo in 2.28's relnotes
References: <e78abce653d4bf13b9fb464db3d8ecf6b7d137b2.1595449743.git.me@ttaylorr.com>
Date:   Wed, 22 Jul 2020 14:10:05 -0700
In-Reply-To: <e78abce653d4bf13b9fb464db3d8ecf6b7d137b2.1595449743.git.me@ttaylorr.com>
        (Taylor Blau's message of "Wed, 22 Jul 2020 16:29:40 -0400")
Message-ID: <xmqq1rl35k9e.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B7B7BE64-CC5F-11EA-816F-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>
> Just a small typo that I noticed while reading the release notes for
> GitHub's blog post about it.

Thanks.

>
>  Documentation/RelNotes/2.28.0.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/RelNotes/2.28.0.txt b/Documentation/RelNotes/2.28.0.txt
> index 5f1413a699..6baf781380 100644
> --- a/Documentation/RelNotes/2.28.0.txt
> +++ b/Documentation/RelNotes/2.28.0.txt
> @@ -116,7 +116,7 @@ Performance, Internal Implementation, Development Support etc.
>     configuration variables in extensions.* namespace were supposed to
>     have special meaning in repositories whose version numbers are 1 or
>     higher), but this was a bit too big a change.  The behaviour in
> -   recent versions of Git where certaion extensions.* were honored by
> +   recent versions of Git where certain extensions.* were honored by
>     mistake even in version 0 repositories has been restored.
>
>
> --
> 2.28.0.rc1.13.ge78abce653
