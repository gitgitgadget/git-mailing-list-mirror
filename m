Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8C1C433B4
	for <git@archiver.kernel.org>; Wed, 19 May 2021 12:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51B096135B
	for <git@archiver.kernel.org>; Wed, 19 May 2021 12:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353383AbhESMLy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 08:11:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58446 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353353AbhESMLv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 08:11:51 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B2074CDD0B;
        Wed, 19 May 2021 08:10:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zlNTvhkHbg4TgG5tCszJZHvrMmPyZhrtKz4Fn1
        pLKO0=; b=nhMoCMexrdAyrac4th0IVwUGqlnyHrJ+6AbaTp54D0A29vpjr48Ok+
        QbIoYkSLupErjI3wc48b1JZDR/nXo6vo3NsIzE2S8XtbKGX7UCE+HMiZW/RTeep9
        M0VtWPmS1voBLAVkRw4VLcoJuzvwRP0WrgNkNPNNeZ8DwWFbtJlck=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A941DCDD09;
        Wed, 19 May 2021 08:10:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 29119CDD08;
        Wed, 19 May 2021 08:10:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Reuven Y. via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, "Reuven Y." <robi@post.jce.ac.il>
Subject: Re: [PATCH v2] docs: improve fast-forward in glossary content
References: <pull.957.git.1621406381404.gitgitgadget@gmail.com>
        <pull.957.v2.git.1621416530195.gitgitgadget@gmail.com>
Date:   Wed, 19 May 2021 21:10:30 +0900
In-Reply-To: <pull.957.v2.git.1621416530195.gitgitgadget@gmail.com> (Reuven
        Y. via GitGitGadget's message of "Wed, 19 May 2021 09:28:49 +0000")
Message-ID: <xmqqlf8ayle1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 34E63082-B89B-11EB-8FB9-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Reuven Y. via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Reuven Y <robi@post.jce.ac.il>
>
> The text was somewhat confusing between the revision itself and the autour,
> improved through a discussion with @Junio
>

Sorry but I am not @Junio.

> -	<<def_commit,commit>> but instead just update to his
> -	revision. This will happen frequently on a
> +	<<def_commit,commit>> but instead just update your branch to point at the same
> +    revision as the branch you are merging. This will happen frequently on a

Hmph, I sense a broken indentation.

I'll fix it up, so no need for resending only to fix this.

Thanks.

>  	<<def_remote_tracking_branch,remote-tracking branch>> of a remote
>  	<<def_repository,repository>>.
>  
>
> base-commit: bf949ade81106fbda068c1fdb2c6fd1cb1babe7e
