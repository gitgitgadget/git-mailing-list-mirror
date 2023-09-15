Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2914CD37AF
	for <git@archiver.kernel.org>; Fri, 15 Sep 2023 23:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237925AbjIOXRw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Sep 2023 19:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237971AbjIOXRW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2023 19:17:22 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28121BCD
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 16:17:16 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A40091A2501;
        Fri, 15 Sep 2023 19:17:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=sfJYyP0TBkPmia/b3kQPz4J32Hh34dRKeIjjNF
        QIXLo=; b=pmZEkBIS+Y0wvFkM0lftfNT6dC2cw+lhCZJ3giBkH42EMptLYcfew7
        1HX93LO3epxdxaKlsM/S3+K4VkTgDiUKqT5FdZjCrNo7WI03Wt2GK567LiudpCOJ
        32OW3gF80gXaIYLqrHKPuISgfgBPoarbiSK1HKewALEGS032vJ5a4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9C12D1A2500;
        Fri, 15 Sep 2023 19:17:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1A86D1A24FF;
        Fri, 15 Sep 2023 19:17:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Caleb Hill via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Caleb Hill <hillcaleb@protonmail.com>,
        Caleb Hill <chill389cc@gmail.com>
Subject: Re: [PATCH] docs: fix "without do cleaning" typo
In-Reply-To: <pull.1572.git.git.1694800409471.gitgitgadget@gmail.com> (Caleb
        Hill via GitGitGadget's message of "Fri, 15 Sep 2023 17:53:29 +0000")
References: <pull.1572.git.git.1694800409471.gitgitgadget@gmail.com>
Date:   Fri, 15 Sep 2023 16:17:13 -0700
Message-ID: <xmqqzg1nc9hi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 01D0099A-541E-11EE-9C10-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Caleb Hill via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Caleb Hill <chill389cc@gmail.com>
>
> This pr fixes a typo I noticed today while reading documentation here:
> https://git-scm.com/docs/git-clean#Documentation/git-clean.txt-quit
>
> Signed-off-by: Caleb Hill <chill389cc@gmail.com>
> ---
>     docs: fix "without do cleaning" typo
>     
>     This pr fixes a simple typo I noticed today while reading documentation
>     here:
>     https://git-scm.com/docs/git-clean#Documentation/git-clean.txt-quit

Thanks; I'll reword the proposed log message a bit and queue.

> diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
> index 160d08b86bb..5e1a3d5148c 100644
> --- a/Documentation/git-clean.txt
> +++ b/Documentation/git-clean.txt
> @@ -127,7 +127,7 @@ ask each::
>  
>  quit::
>  
> -  This lets you quit without do cleaning.
> +  This lets you quit without doing any cleaning.

"without cleaning" would probably mean the same thing and a tad
shorter, but let's use what you wrote as-is.

Thanks.
