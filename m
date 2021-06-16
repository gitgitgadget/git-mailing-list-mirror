Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567C6C48BE5
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 01:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A1CB61369
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 01:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhFPBYv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 21:24:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57208 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbhFPBYv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 21:24:51 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A65D4E6554;
        Tue, 15 Jun 2021 21:22:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zfdzyBaJjuRwMKIBXi3hTJWe1waLzaE0mjxtSL
        ie/NM=; b=k6ek5CH6arF8aLk3WowhjigUG3in90YORD7b8zNQbq1B/QJdjxfO8T
        Jh6u7VwPPnVAmvqyaW7hx7O7aUq2HRX0z2KrUPCh39lNDnx9MPJlu8qQHnJ0lEeM
        uN+hjatFWd6pMWm/DOfViDEM9P72d224O+aBJlLolQecyZUB4Gx2I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9CFDAE6553;
        Tue, 15 Jun 2021 21:22:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 324C4E6552;
        Tue, 15 Jun 2021 21:22:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jun 2021, #05; Tue, 15)
References: <xmqqmtrrv8sd.fsf@gitster.g>
        <CABPp-BEP2ct7ikBJyvFuzkq+HZ1q-OMW3sKMphbkTZ82F7+dzg@mail.gmail.com>
Date:   Wed, 16 Jun 2021 10:22:44 +0900
In-Reply-To: <CABPp-BEP2ct7ikBJyvFuzkq+HZ1q-OMW3sKMphbkTZ82F7+dzg@mail.gmail.com>
        (Elijah Newren's message of "Tue, 15 Jun 2021 13:16:27 -0700")
Message-ID: <xmqq1r92vc0r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5A8B78FE-CE41-11EB-8AA5-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Tue, Jun 15, 2021 at 1:24 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> * ds/status-with-sparse-index (2021-05-22) 14 commits
>> ...
>>  "git status" codepath learned to work with sparsely populated index
>>  without hydrating it fully.
>>
>>  Waiting for reviews.
>
> I reviewed each of the rounds except v4 (v5 is the latest), and
> generally like the series but I highlighted a few issues in v5.
> Stolee reported he's planning to send a re-roll (see e.g.
> https://lore.kernel.org/git/2784d29b-b22a-2bf6-2450-7b4a0a72df54@gmail.com/),
> so I think this can be updated to "expecting a reroll"?

Thanks, very much appreciated.
