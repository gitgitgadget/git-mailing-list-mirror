Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0425C433EF
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 19:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245487AbiCOTKk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 15:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240212AbiCOTKi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 15:10:38 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E58213DE7
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 12:09:26 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 695171865C3;
        Tue, 15 Mar 2022 15:09:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KJtWX5mABbYZNzBvnBHb8HZKSWfG+JMOK8RWrX
        PrtKo=; b=ptS0DGkSN7wLnSIlvKa/y1baNBuvAboMtn1AniDTqPFil4F4o0/1sO
        1EoB1tsK+d9toU4RhKT8KUQ81zppjE7mTcbEwZ2bJr5PI4vVYplz4gcUCmmtZnM2
        IgY5twuoKcq0HHQu4vDn1XDR7guC+AMAyxEskTLMnOVVXfsvuNDoE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 62B011865C2;
        Tue, 15 Mar 2022 15:09:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DEB331865C1;
        Tue, 15 Mar 2022 15:09:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2022, #03; Mon, 14)
References: <xmqq5yogp6xo.fsf@gitster.g>
        <c4162c3e-a04c-6c8d-6b84-a32333ce5c9f@jeffhostetler.com>
Date:   Tue, 15 Mar 2022 12:09:21 -0700
In-Reply-To: <c4162c3e-a04c-6c8d-6b84-a32333ce5c9f@jeffhostetler.com> (Jeff
        Hostetler's message of "Tue, 15 Mar 2022 14:38:21 -0400")
Message-ID: <xmqqa6drdoda.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6D1AFEA8-A493-11EC-B621-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

>>   Built-in fsmonitor (part 2).
>>   Will merge to 'master'.
>>   source: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
>> 
>
> One of your notes on part 2.5 asked if it would be better
> to pull part 2 back to "seen" and let me squash in part 2.5
> (and attend to any new comments on 2.5 itself).
>
> I'm happy to do that if you haven't merged part 2 yet.

Yeah, let's kick it out of 'next' tentatively and give people a
chance to sanity check the result.

Thanks.
