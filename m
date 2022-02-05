Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9E7C433EF
	for <git@archiver.kernel.org>; Sat,  5 Feb 2022 08:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379668AbiBEIAK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Feb 2022 03:00:10 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52605 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379458AbiBEIAK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Feb 2022 03:00:10 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CD695179273;
        Sat,  5 Feb 2022 03:00:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JW5wORwY0vvF1FILaVkKEiWT/DuKvIZnyUhm12
        0Gj0w=; b=qGrZUZcnZG8FnTGYQ4uujJyYOI0rrgvmWzjCsHrxssEYs6B0ole9Yb
        +834tHoa2tAxIUJ8iofzeAXUSPYAj9rb66d9TZx7TmGBEyrR5FIXpK61yWqDI0SN
        sTzll96GfO7xuYql9M6A4JBd8AYlLZLpRGnx66D6sgLwZQijfAHB8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C7256179272;
        Sat,  5 Feb 2022 03:00:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.213.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2307F17925E;
        Sat,  5 Feb 2022 03:00:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2022, #01; Thu, 3)
References: <xmqqr18jnr2t.fsf@gitster.g>
        <6916de1c-12f6-6f45-99c7-ffe8dd08b244@sunshineco.com>
Date:   Sat, 05 Feb 2022 00:00:05 -0800
In-Reply-To: <6916de1c-12f6-6f45-99c7-ffe8dd08b244@sunshineco.com> (Eric
        Sunshine's message of "Fri, 4 Feb 2022 02:00:18 -0500")
Message-ID: <xmqq5yptlp4q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A21B471E-8659-11EC-9FB3-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On 2/4/22 12:22 AM, Junio C Hamano wrote:
>> * en/keep-cwd (2022-01-26) 1 commit
>>    (merged to 'next' on 2022-01-26 at b2518a683c)
>>   + sequencer, stash: fix running from worktree subdir
>>   Fix a regression in 2.35 that roke the use of "rebase" and "stash"
>>   in a secondary worktree.
>
> s/roke/broke/

Thanks. I think I'll need to update the draft release notes as part
of the next batch to merge topics to 'master'.
