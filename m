Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD8DC433EF
	for <git@archiver.kernel.org>; Fri, 20 May 2022 20:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238780AbiETU4G (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 16:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347017AbiETU4E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 16:56:04 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB5122502
        for <git@vger.kernel.org>; Fri, 20 May 2022 13:56:01 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6688019CC3A;
        Fri, 20 May 2022 16:56:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8VUVwlHjCQGSUuR/XK5Mwh1AS7oWRUH1IARMaD
        84uUc=; b=lHweTek7+jXSNvHneRlvNL6qKfFFWOAMDymCSbkNq1c1fYzKi9dDn9
        B7PxRICvxIoAIz2UWz24ABRHG7d/TTEFJ3EjdA2gg8BZHNurtlSGoJ3IYwL3sB+y
        VUKC6IaJkjXpDNj0WKu7lv6s2/0tAHVCzQSIfjfDw2H+hY+ACV0Vo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5FF6B19CC39;
        Fri, 20 May 2022 16:56:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.111.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0411A19CC36;
        Fri, 20 May 2022 16:55:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Victoria Dye <vdye@github.com>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/3] repack: handle --keep-pack, --max-pack-size for
 geometric repacks
References: <cover.1653073280.git.me@ttaylorr.com>
        <5517f0f8-871c-a155-7d8c-d0d6086bb7d2@github.com>
        <b151f2bb-bdc7-e004-f1d4-e1a83c2b73db@github.com>
Date:   Fri, 20 May 2022 13:55:56 -0700
In-Reply-To: <b151f2bb-bdc7-e004-f1d4-e1a83c2b73db@github.com> (Derrick
        Stolee's message of "Fri, 20 May 2022 16:05:29 -0400")
Message-ID: <xmqqilpzgbz7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3F8DA54C-D87F-11EC-844B-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>> I was worried about the robustness of the test, but some deeper diving
>> revealed that it should produce consistent results. Otherwise, the fix
>> itself is a straightforward (albeit hard to find in the first place). These
>> two patches look good to me!
>> 
>>> Thanks in advance for your review.
>
> I'm chiming in to say that I also read these patches and think they
> are good. Couldn't find a way to improve them.

Thanks, all.  Queued.
