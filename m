Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DC8C433EF
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 23:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbiANXtO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 18:49:14 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57045 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiANXtN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 18:49:13 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8D5641686EA;
        Fri, 14 Jan 2022 18:49:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XsWnlL8p4gpx4J1Z+9y5sB2H+7ZAnsvZzUqxw8
        PfBoo=; b=RcCOEas1ZnoQJdudgLB1VGW+sru6isuJjIhTpamIg+wSlEDWv5z59W
        sE+MDE8PB7dG5ec1S3RgXlOX+GYIuWbnM8ZlZDw0vO25y9seSr7sn3ZDucZT+L99
        QHw1PY5V4R5X1VCGOhcjKkz1lxMpktl0+Y0nC/1hce9ufTct56yb4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 85E391686E9;
        Fri, 14 Jan 2022 18:49:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EEF861686E6;
        Fri, 14 Jan 2022 18:49:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: Mistakes in the stalled category?
References: <xmqq35lrf8g4.fsf@gitster.g>
        <CABPp-BFj8NyXG6cQPJeDE46eicbfnP=TgEirRZVcnMM+YNG7OQ@mail.gmail.com>
Date:   Fri, 14 Jan 2022 15:49:08 -0800
In-Reply-To: <CABPp-BFj8NyXG6cQPJeDE46eicbfnP=TgEirRZVcnMM+YNG7OQ@mail.gmail.com>
        (Elijah Newren's message of "Fri, 14 Jan 2022 07:44:36 -0800")
Message-ID: <xmqqlezh98uj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 91989CF0-7594-11EC-A624-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> [Stalled]
>>
>> * ds/sparse-checkout-requires-per-worktree-config (2021-12-21) 5 commits
>>  . sparse-checkout: use repo_config_set_worktree_gently()
>>  . config: add repo_config_set_worktree_gently()
>>  . worktree: add upgrade_to_worktree_config()
>>  . config: make some helpers repo-aware
>>  . setup: use a repository when upgrading format
>>
>>  "git sparse-checkout" wants to work with per-worktree configration,
>>  but did not work well in a worktree attached to a bare repository.
>>  source: <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com>
>
> It has been two weeks since the last submission and emails about this
> topic, so maybe you put this one in "stalled" intentionally.  (If so,
> and Stolee if this really is stalled, would you like me to try
> updating?  I know it has expanded quite a bit from the early simple
> fix you were trying to provide, but you've got most the code I think
> you need and some important fixes I wouldn't want to see dropped.)

[Stalled] being early in the report is primarily a way to remind us
that an update is overdue.

<1db0f601-4769-15c0-cd58-ecddfa1fc9d5@gmail.com> is what prompted me
to consider that I can put it on backburner and spend my time on
other topics.

>> * pw/add-p-hunk-split-fix (2022-01-12) 2 commits

I think what happened was that the previous iteration of this was on
2021-12-20 and marked as "Expecting a reroll" for a few issues of
the "What's cooking" report.  And then I've moved it to [Stalled]
section, but before I had a chance to issue another "What's cooking"
report, an update came, and when I updated the list of commits, I
forgot to move the topic out of the [Stalled] category.

>> * gc/fetch-negotiate-only-early-return (2022-01-12) 3 commits

Likewise, the previous round was on 2021-12-21.

