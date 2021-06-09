Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F84C47082
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 00:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCFDB60FDA
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 00:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbhFIAZx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 20:25:53 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58486 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233455AbhFIAZw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 20:25:52 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 821A0143850;
        Tue,  8 Jun 2021 20:23:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yE5xiiX10jz7ttYY/GNNQYBq7TvT4GM6PB68/L
        Tb70c=; b=BIijITq0QnEi0e5lgplI+nNggrOOmi4fsFE1cgbRABOACN0fYGkIE2
        tkA+5fLVx7GTPZkCfv56dE4Xw1YZOH/je75n3z70nEgVkLD/OvEG16RJhIxjnV75
        Se96k+PXbdA/cDk2kMthG0674pfaDn5x5TwXZhBP4jEmpZGgJlsvM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7A60D14384F;
        Tue,  8 Jun 2021 20:23:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C274714384D;
        Tue,  8 Jun 2021 20:23:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Atharva Raykar <raykar.ath@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v3] MyFirstContribution: link #git-devel to Libera Chat
References: <20210608180624.72135-1-raykar.ath@gmail.com>
        <20210608190612.72807-1-raykar.ath@gmail.com>
        <YL/X6KBRZbPFz09t@google.com>
Date:   Wed, 09 Jun 2021 09:23:54 +0900
In-Reply-To: <YL/X6KBRZbPFz09t@google.com> (Emily Shaffer's message of "Tue, 8
        Jun 2021 13:49:44 -0700")
Message-ID: <xmqqczsvnaw5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F9F5C798-C8B8-11EB-A905-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> On Wed, Jun 09, 2021 at 12:36:12AM +0530, Atharva Raykar wrote:
>> 
>> Many of the regulars on #git-devel are now on Libera Chat, to the extent
>> that the community page now lists it as the IRC Channel[1]. This will
>> help new contributors find the right place, if they choose to ask
>> questions on `#git-devel`.
>> 
>> Relevant discussion on the IRC transition:
>> https://lore.kernel.org/git/CAJoAoZ=e62sceNpcR5L5zjsj177uczTnXjcAg+BbOoOkeH8vXQ@mail.gmail.com/
>> 
>> [1] https://git-scm.com/community
>> 
>> Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
> Reviewed-by: Emily Shaffer <emilyshaffer@google.com>
>
>
> Thanks Atharva! :)
>
>  - Emily

Thanks, both.  Will queue.
