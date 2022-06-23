Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FB1C43334
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 19:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbiFWTrN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiFWTq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 15:46:59 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DD252E6A
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 12:42:23 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 503A0142538;
        Thu, 23 Jun 2022 15:42:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iED6v+wlAI2rpoe1XMW95Pia6hXRAeOuwzOsXK
        enn/s=; b=Mgd8jCb7PIu30HPr9EUnR/G2osuZtgbF38BocG/+nqDuP3AF8mXkKq
        p3cKdfJA0IQjmeDZ3oSHE8nerZKY6MiabV88m6WQB1IIoOYo0gVrjy1ZlTg+xumH
        fFl1qGKopMI/4OvX2U5cZIFL+G5b4k/1CWPjpSYfrasvdu5TuJZRU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 469C9142537;
        Thu, 23 Jun 2022 15:42:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 75DCA142534;
        Thu, 23 Jun 2022 15:42:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com, avarab@gmail.com
Subject: Re: [PATCH] Documentation/config/transfer.txt: fix typo
References: <68c1c3648c51f6298eea4d58286b20e0c770a270.1656010900.git.me@ttaylorr.com>
Date:   Thu, 23 Jun 2022 12:42:17 -0700
In-Reply-To: <68c1c3648c51f6298eea4d58286b20e0c770a270.1656010900.git.me@ttaylorr.com>
        (Taylor Blau's message of "Thu, 23 Jun 2022 15:02:01 -0400")
Message-ID: <xmqqa6a3yxnq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9759BF46-F32C-11EC-9B0C-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Commit 7281c196b1 (transfer doc: move fetch.credentialsInUrl to
> "transfer" config namespace, 2022-06-15) propagates a typo from
> 6dcbdc0d66 (remote: create fetch.credentialsInUrl config, 2022-06-06),
> where "other" is misspelled as "oher". Fix the typo accordingly.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
> Noticed while skimming the new documentation for the upcoming 2.37
> release.

Thanks.

>
>  Documentation/config/transfer.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/config/transfer.txt b/Documentation/config/transfer.txt
> index b4475c0690..7ed917f5fc 100644
> --- a/Documentation/config/transfer.txt
> +++ b/Documentation/config/transfer.txt
> @@ -20,7 +20,7 @@ exposure, e.g. because:
>    in other ways, e.g. a backup process might copy the data to another
>    system.
>  * The git programs will pass the full URL to one another as arguments
> -  on the command-line, meaning the credentials will be exposed to oher
> +  on the command-line, meaning the credentials will be exposed to other
>    users on OS's or systems that allow other users to see the full
>    process list of other users. On linux the "hidepid" setting
>    documented in procfs(5) allows for configuring this behavior.
> --
> 2.35.1
