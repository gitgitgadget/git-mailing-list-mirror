Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF7BC433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 20:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 855AC6143D
	for <git@archiver.kernel.org>; Thu, 13 May 2021 20:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbhEMUMN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 16:12:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50081 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbhEMUMM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 16:12:12 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C4F37D60FD;
        Thu, 13 May 2021 16:11:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MXtx4mLZ6wyCpg/5HBGOH1g3dNM/WoAPFuKWsW
        Jsjsg=; b=r8vvuwKZAYYZPLSqCWwmJsPOHtXFvwzqceWUZl4Wu4FMD/lzkvOeqL
        m4frLiZVxclNlY70NGyzwb32RBCcJZKjSKs7Ftf2zV5DpH3L4omW9c0RbVi8ydAj
        IO7eErn/YMMkRcP+7aU6mtlTNmphITiy+9By0IxRkmAOy8vaFwS9o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BDAEAD60FC;
        Thu, 13 May 2021 16:11:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 182D3D60FA;
        Thu, 13 May 2021 16:11:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     lilinchao@oschina.cn
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH] Fix typo in Documentation/RelNotes/2.31.0.txt
References: <21c2f550aefd11eb9a470026b95c99cc@oschina.cn>
        <fe07e104b3c311eba3eb0024e87935e7@oschina.cn>
Date:   Fri, 14 May 2021 05:11:00 +0900
In-Reply-To: <fe07e104b3c311eba3eb0024e87935e7@oschina.cn>
        (lilinchao@oschina.cn's message of "Thu, 13 May 2021 16:19:53 +0800")
Message-ID: <xmqqa6oybdij.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5676FB96-B427-11EB-97FA-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"lilinchao@oschina.cn" <lilinchao@oschina.cn> writes:

> ping
> ---
>>From: Li Linchao <lilinchao@oschina.cn>
>>
>>replace 'whey' with `when`
>>
>>Signed-off-by: Li Linchao <lilinchao@oschina.cn>
>>---
>> Documentation/RelNotes/2.31.0.txt | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>>diff --git a/Documentation/RelNotes/2.31.0.txt b/Documentation/RelNotes/2.31.0.txt
>>index cf0c7d8d40..617d211f3f 100644
>>--- a/Documentation/RelNotes/2.31.0.txt
>>+++ b/Documentation/RelNotes/2.31.0.txt
>>@@ -49,7 +49,7 @@ UI, Workflows & Features
>>    @{1}, but we failed to answer "what commit were we on?", i.e. @{1}
>>
>>  * "git bundle" learns "--stdin" option to read its refs from the
>>-   standard input.  Also, it now does not lose refs whey they point
>>+   standard input.  Also, it now does not lose refs when they point
>>    at the same object.
>>
>>  * "git log" learned a new "--diff-merges=<how>" option.
>>--
>>2.31.1.442.g7e39198978

Thanks.  Will see if it makes sense to apply.

While it is true that is a typo, fixing it here won't correct it for
the 2.31 release as it was tagged and released long time ago.  And
of course, it will be silly to issue 2.31.1 maintenance release to
fix a typo in the release notes for 2.31.0 release.  So...
