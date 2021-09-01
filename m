Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F6FC432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 14:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A94D860ED4
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 14:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244981AbhIAO4I (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 10:56:08 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58309 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239646AbhIAO4I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 10:56:08 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 21DCE147B8B;
        Wed,  1 Sep 2021 10:55:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qtZkBZLh7JafiGApfiStQECY4ISwVIdBhXDhYi
        mHkAo=; b=K+p2skYHI46KfeufxVXkWXcWf+V5mdpu1J+scE1W/VK9/r7Y0lvBKE
        oTdF3karc9aMwIZPKJM0xwwR2RTBDHFa/xw6bzuMFlazYPkICoNcth3+LfFxLIWa
        cQJimCpZM+sYn8JZJkOIbnUzXRJC9z5VC0OglWUKCRd6HcdvDbNt4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1A60A147B8A;
        Wed,  1 Sep 2021 10:55:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2CF60147B89;
        Wed,  1 Sep 2021 10:55:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, kim@eagain.st
Subject: Re: What's cooking in git.git (Aug 2021, #09; Sun, 29)
References: <xmqq35qr7mq5.fsf@gitster.g>
        <20210831220208.3924051-1-jonathantanmy@google.com>
Date:   Wed, 01 Sep 2021 07:55:06 -0700
In-Reply-To: <20210831220208.3924051-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Tue, 31 Aug 2021 15:02:08 -0700")
Message-ID: <xmqqbl5cs5v9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 996E208C-0B34-11EC-ABE2-FA11AF6C5138-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> * ka/want-ref-in-namespace (2021-08-13) 3 commits
>>  - docs: clarify the interaction of transfer.hideRefs and namespaces
>>  - upload-pack.c: treat want-ref relative to namespace
>>  - t5730: introduce fetch command helper
>> 
>>  "git upload-pack" which runs on the other side of "git fetch"
>>  forgot to take the ref namespaces into account when handling
>>  want-ref requests.
>
> Sorry for not being able to look at this until now, but:
>
> Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
>
> Thanks for addressing my comment about the failing tests to be written
> in success/failure pairs [1] - I see that that has been done in patch 2.
>
> [1] https://lore.kernel.org/git/20210802210644.3432544-1-jonathantanmy@google.com/

Thanks.  Will "rebase -i (reword)" your Reviewed-by in and then
advance the topic to 'next'.

