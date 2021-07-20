Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A26C07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 21:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B56B60FF2
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 21:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhGTVO4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 17:14:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61476 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbhGTVOo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 17:14:44 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B8EB0E91E1;
        Tue, 20 Jul 2021 17:55:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aRx/p5zIU16BkDsycGiRnmOD5iIirLVag2C2r7
        j7v6Q=; b=io+sJ29HknIeDYcIreXym+FDPCC2ATnQuXwCQ3xwa5ua9eNVHGxq0n
        zA+vKBPlL/jF4j9AeFwOHnUrF2jnuUHHAT+J3UGkj1RseLNy9OVNl/rncRqV9wRE
        C7YyR/mC/tLHQZ+PJ0cAP29R4Bh+f23ArweJctPbW3p9YRdHioBTI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B0CF3E91E0;
        Tue, 20 Jul 2021 17:55:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3746EE91DF;
        Tue, 20 Jul 2021 17:55:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        German Lashevich <german.lashevich@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] doc/git-config: explain --file instead of referring
 to GIT_CONFIG
References: <YO9YyTZdU4WadYGg@coredump.intra.peff.net>
        <YO9ZGTX9f1fOpTkh@coredump.intra.peff.net>
        <CAN0heSoz8KmmtX8LVcY2wBM6Fm4TAYwDmQGPE8wpdZTmWRVzWA@mail.gmail.com>
        <YPcrslQNmqvlBYpX@coredump.intra.peff.net>
Date:   Tue, 20 Jul 2021 14:55:20 -0700
In-Reply-To: <YPcrslQNmqvlBYpX@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 20 Jul 2021 16:01:54 -0400")
Message-ID: <xmqqfsw8hcqf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2DD0100C-E9A5-11EB-89FA-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I double-checked the rest of the series for other spelling errors but
> didn't see any. This is marked for merging to next, but hasn't made it
> yet. So if you get this in time, Junio, can you please squash this into
> the first patch?

Thanks, will do.


>
> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> index 193fef2867..6c78ad1c13 100644
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -147,7 +147,7 @@ See also <<FILES>>.
>  	repository `.git/config`.
>  +
>  For reading options: read only from the specified file rather than from all
> -avialable files.
> +available files.
>  +
>  See also <<FILES>>.
>  
>
> -Peff
