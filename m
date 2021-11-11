Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3721C433EF
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 22:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4CF161208
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 22:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbhKKXBb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 18:01:31 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64851 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234150AbhKKXBb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Nov 2021 18:01:31 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C3E4E311A;
        Thu, 11 Nov 2021 17:58:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=e7FeQP56j2v6LpabTB3i3nMpO3l4D+UCqKHT9B
        WU5pw=; b=PFOUF3k7iBGadC1jsRk7l2iMCpxUMQ1c2T1b4kUU9DIw8CXroXBcUE
        UQ98MVt9GJLCfvO4gFct+EEM5BHDiiynRnf7qe6kUw5eAFcaPMNciUgqn6bMb2dc
        YiQXgM9sFfbNSm6lOBmh2zhE1+GOZM8Sn/SBYoFdPGdCgJ1YeY4y8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2371AE3118;
        Thu, 11 Nov 2021 17:58:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 886BAE3116;
        Thu, 11 Nov 2021 17:58:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2021, #03; Tue, 9)
References: <xmqqy25wygek.fsf@gitster.g> <YY2W6ESIxSz9lakK@google.com>
Date:   Thu, 11 Nov 2021 14:58:39 -0800
In-Reply-To: <YY2W6ESIxSz9lakK@google.com> (Emily Shaffer's message of "Thu,
        11 Nov 2021 14:19:20 -0800")
Message-ID: <xmqqlf1ujo4g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E97BEDC0-4342-11EC-9591-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

>> * gc/remote-with-fewer-static-global-variables (2021-10-28) 6 commits
>>  - remote: add struct repository parameter to external functions
>>  - remote: die if branch is not found in repository
>>  - remote: remove the_repository->remote_state from static methods
>>  - remote: use remote_state parameter internally
>>  - remote: move static variables into per-repository struct
>>  - t5516: add test case for pushing remote refspecs
>> 
>>  Code clean-up to eventually allow information on remotes defined
>>  for an arbitrary repository to be read.
>> 
>>  Will merge to 'next'?
>
> What's still blocking this from being merged? Anything? Release
> schedule?

I do not think I saw anybody giving sufficient review on any
previous rounds or the latest round.  I did read some part and
commented on earlier rounds, during the -rc period, I don't have
enough concentration to judge a new design properly myself.

So, in short, these patches are unreviewed yet, if I am not
mistaken.

Thanks.
