Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B545C04A6A
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 20:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbjHAUfa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Aug 2023 16:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjHAUf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 16:35:29 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EED26A3
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 13:35:26 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B9D491B0618;
        Tue,  1 Aug 2023 16:35:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=U1DZUoxU7Ji5a5q8OoBOtxQue4AaualsO/HKRl
        KhUpI=; b=r7N7/tAe1JXvYA7/R0xaNRbNWwyPGoQaK/vvv3HiRfaxmPHxyM4MV8
        Zym2q8yLt3fWJmR0QsVdYfAx1FcUKe9aRyADNCBDZ7YuKBzpW2AfCQWkqybRCdH2
        QSdOChuByNRxzpCV/m+hzUj3Q5rvmUx2Mrf/Sx8670cA0GWRYp5IM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B06BC1B0617;
        Tue,  1 Aug 2023 16:35:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2056D1B0616;
        Tue,  1 Aug 2023 16:35:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <nasamuffin@google.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2023, #07; Mon, 31)
References: <xmqqmszcynem.fsf@gitster.g>
        <CAJoAoZk1WiCSDqFXccG4FiwYhWUuWWmFz+ZqiXhacmfjZuE6FA@mail.gmail.com>
        <xmqqzg3abpis.fsf@gitster.g>
        <CAJoAoZngMcN-0-5q1y-zX5552QhgRHCrKULQ7hKyJgcCoSQJNQ@mail.gmail.com>
Date:   Tue, 01 Aug 2023 13:35:23 -0700
In-Reply-To: <CAJoAoZngMcN-0-5q1y-zX5552QhgRHCrKULQ7hKyJgcCoSQJNQ@mail.gmail.com>
        (Emily Shaffer's message of "Tue, 1 Aug 2023 13:27:33 -0700")
Message-ID: <xmqqy1iua4c4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F1A0AE6C-30AA-11EE-9A3B-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <nasamuffin@google.com> writes:

>> Or are there still further changes in behaviours planned?
>
> Huh, I thought that you wanted further changes. In
> https://lore.kernel.org/git/ZDSTFwMFO7vbj%2Fdu@google.com/ I was
> asking for opinions on adding tests; if you're fine to take it without
> tests, then of course I don't have an objection to an identical patch
> with objectively improved grammar in the commit message. But since you
> were asking for a reroll in the What's Cooking, I figured there was
> more you were unhappy with in the patch. If that's not the case, by
> all means, go ahead and take it.

Well, this is why an overly slow reaction is bad for everybody.

I quite honestly do not recall what was suggested and with what
severity (was it a good to have?  was it a showstopper?).

Anyway, if it is not urgent and nobody else is jumping up and down
and asking for an immediate inclusion of the current iteration, we
can wait a bit longer without hurting anybody ;-)

Thanks.
