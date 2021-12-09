Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E577FC433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 00:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241460AbhLIA0F (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 19:26:05 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52645 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238328AbhLIA0F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 19:26:05 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CB38DED341;
        Wed,  8 Dec 2021 19:22:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZMs2pv7hH1oOl46pRjqV+UuKypR7mD+v5bx8lT
        UfpyU=; b=UhFiz3CUjhOOEH2iUEzs37LmIWxyqE/A8w+zJHmeydSx287dqJswgF
        MRlehghJX9E0sH/iMImKC/c41uWHw9mAlGv78ior6LpUNwBBhjzlZa7eO+0Od/5p
        tsLa8T2iJBZcJ7AdLbztIMo3mSsbGzh/GB/sZawbcHIVh1c2VAQsg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C3809ED340;
        Wed,  8 Dec 2021 19:22:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 35268ED33F;
        Wed,  8 Dec 2021 19:22:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lessley Dennington <lessleydennington@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: ld/sparse-diff-blame, was What's cooking in git.git (Dec 2021,
 #02; Tue, 7)
References: <xmqq8rwv6e0a.fsf@gitster.g>
        <a4968ff2-17c6-faa8-e9be-0c1880e870dd@gmail.com>
        <xmqqtufiztp9.fsf@gitster.g>
        <3478ff65-b1ce-5b5c-2053-90b927b66779@gmail.com>
Date:   Wed, 08 Dec 2021 16:22:30 -0800
In-Reply-To: <3478ff65-b1ce-5b5c-2053-90b927b66779@gmail.com> (Lessley
        Dennington's message of "Wed, 8 Dec 2021 16:58:44 -0600")
Message-ID: <xmqqlf0uwrsp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1924F8A2-5886-11EC-9C5B-C48D900A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lessley Dennington <lessleydennington@gmail.com> writes:

> On 12/8/21 1:13 PM, Junio C Hamano wrote:
>
>> I think the patches in this series are in good shape.  The other
>> topic this series depends on is already in 'next', so we can mark
>> this for 'next', too.
>>
>> Note that "explanation in reply" does not count as much as an
>> improved version would.  If the code or the log message puzzled a
>> reviewer during the review, future readers of the code and "git log"
>> will be puzzled the same way.
>> Thanks.
>> 
> Thank you for the feedback, I will take that into account for future
> series.

This topic in turn is depended on others, so it is in everybody's
interest to declare it stable as soon as we agree it is, and we just
did ;-)

Thanks for working on this.
