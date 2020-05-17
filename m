Return-Path: <SRS0=BhVQ=67=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8282C433DF
	for <git@archiver.kernel.org>; Sun, 17 May 2020 18:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83C2620709
	for <git@archiver.kernel.org>; Sun, 17 May 2020 18:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QQq7WOHc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgEQSdZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 May 2020 14:33:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61842 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbgEQSdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 May 2020 14:33:25 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5376E58636;
        Sun, 17 May 2020 14:33:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BIriGnYkmCu4Xpdz+Ogxh2TGKm0=; b=QQq7WO
        HciY59sietKhhBHUu00trWAJR6dQhXwc7JTZu/eEXczUSE2+e+vxOZShG8lfibHc
        uipGOz9LQ5NSm1h4v93MveudbeBpPVDAJF7at/LGR7lv9TOqyE3ZqLkA2KNv/k9T
        j2zb88GH26CYXs7RMd/AhzivOfhK+dyh/L0/c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=m6HqBWFKNeBLOQ6t6adzeDIvKwmPP69J
        P2f5R4GbTjS1/5KatSr7MTQaKmODSw8D4h8fV7Vz61J/w4eLV14TvEEWNhAQu9P6
        42AtHuZpWdU0l3j81ZPiCPiBJbIooulI9MzLawx7yFPkBTby/5KYExqUrAM+jrfy
        FWIrKUaEQHs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4C25A58635;
        Sun, 17 May 2020 14:33:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C73E758633;
        Sun, 17 May 2020 14:33:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kenneth Lorber <keni@hers.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 1/6] Tell the glossary about core.hooksPath
References: <1589681624-36969-1-git-send-email-keni@hers.com>
        <1589681624-36969-2-git-send-email-keni@hers.com>
Date:   Sun, 17 May 2020 11:33:22 -0700
In-Reply-To: <1589681624-36969-2-git-send-email-keni@hers.com> (Kenneth
        Lorber's message of "Sat, 16 May 2020 22:13:39 -0400")
Message-ID: <xmqq4kse76od.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E3767B0C-986C-11EA-A762-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kenneth Lorber <keni@hers.com> writes:

> From: Kenneth Lorber <keni@his.com>
>
> The user manual glossary entry for hooks now knows about core.hooksPath.
>
> Signed-off-by: Kenneth Lorber <keni@his.com>
> ---
>  Documentation/glossary-content.txt | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

That's a gap worth filling.

> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
> index 090c888335..37147db1bc 100644
> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -206,10 +206,12 @@ for a more flexible and robust system to do the same thing.
>  	to optional scripts that allow a developer to add functionality or
>  	checking. Typically, the hooks allow for a command to be pre-verified
>  	and potentially aborted, and allow for a post-notification after the
> -	operation is done. The hook scripts are found in the
> -	`$GIT_DIR/hooks/` directory, and are enabled by simply
> -	removing the `.sample` suffix from the filename. In earlier versions
> -	of Git you had to make them executable.
> +	operation is done. The hook scripts are found in `$GIT_DIR/hooks/`
> +	or in any directory specified by the `core.hooksPath` configuration

I expect "the", instead of "any", would make more sense to readers.

It is true that you can choose any directory of your liking and
specify it via the variable, but once chosen that would be the only
directory used for the purpose.

> +	variable.  The sample scripts are enabled by simply
> +	removing the `.sample` suffix from the filename.  In earlier versions
> +	of Git you had to make the sample scripts executable manually.
> +	Hook scripts must be executable.  See linkgit:githooks[5] for details.
>  
>  [[def_index]]index::
>  	A collection of files with stat information, whose contents are stored

Thanks.
