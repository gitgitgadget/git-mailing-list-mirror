Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4317A20281
	for <e@80x24.org>; Tue, 19 Sep 2017 03:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751547AbdISDMd (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 23:12:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61668 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750925AbdISDMb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 23:12:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3152397A44;
        Mon, 18 Sep 2017 23:12:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HiTuo3Ubje9MGfmYZKoGfRUJNC8=; b=Z2Qaaf
        XCyNYW3Rtr3xzmmhQKHrSCcqlLslayIY4wyWVJNQaiTuOHuDyCBlZfYk0NDLud/6
        L0u8nYala2BPyvJSR5fYBi1S37ayGS8GaWuAmweFTT3//uZkppzet3OwU31unPgF
        wXM3B/hQipY1FE5Ndtc9f4uFEB3heIghXWmek=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YOVSi9QLAWuUQ2bwiG8LLXxTmmbtcG0s
        t9mKj6lj1TFOiIqX2X6S3AIfisf8szWPqWsZKu24FxR5E1jTozHoXzl/FZ7xZVTB
        6wMEFwBqmVtQ4W+RwAQNKUR6DbztmmbVjTkjEYsb2mPDQXdnTVbWAmUziOBQZEwz
        CoN8sWKiXh8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2990997A43;
        Mon, 18 Sep 2017 23:12:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8A54C97A42;
        Mon, 18 Sep 2017 23:12:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t/README: fix typo and grammatically improve a sentence
References: <0102015e8f587e1a-6101d61b-8db8-4f22-8101-68f582c6df8f-000000@eu-west-1.amazonses.com>
Date:   Tue, 19 Sep 2017 12:12:29 +0900
In-Reply-To: <0102015e8f587e1a-6101d61b-8db8-4f22-8101-68f582c6df8f-000000@eu-west-1.amazonses.com>
        (Kaartic Sivaraam's message of "Sun, 17 Sep 2017 10:18:15 +0000")
Message-ID: <xmqqpoanqt42.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5F734C36-9CE8-11E7-AA9F-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
> ---
>  t/README | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/t/README b/t/README
> index 2f95860369751..4b079e4494d93 100644
> --- a/t/README
> +++ b/t/README
> @@ -265,12 +265,12 @@ or:
>  
>      $ sh ./t9200-git-cvsexport-commit.sh --run='-3 21'
>  
> -As noted above, the test set is built going though items left to
> -right, so this:
> +As noted above, the test set is built by going through the items
> +from left to right, so this:
>  
>      $ sh ./t9200-git-cvsexport-commit.sh --run='1-4 !3'
>  
> -will run tests 1, 2, and 4.  Items that comes later have higher
> +will run tests 1, 2, and 4.  Items that come later have higher
>  precedence.  It means that this:
>  
>      $ sh ./t9200-git-cvsexport-commit.sh --run='!3 1-4'
>
> --
> https://github.com/git/git/pull/404

Both of these look to me obvious improvements.  I'll queue them
unless other people object.

Thanks.
