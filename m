Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C83ECE79DE
	for <git@archiver.kernel.org>; Wed, 20 Sep 2023 14:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235233AbjITO5a (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Sep 2023 10:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234974AbjITO53 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2023 10:57:29 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6AE91
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 07:57:23 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 685AE36644;
        Wed, 20 Sep 2023 10:57:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=kknzOR7Tm9MVvrm9rx/nepy75r5w5o+3r7zJkN
        Fl330=; b=LwXA2hMOwvU7sVd+S2e5awF3V+1Fc3EOI3SI0M2UorEobeFK0IchRQ
        roI9iPoqUv1uWOW3Bbr88ICPPLjlJkmaRrOMKpYvYd7gkJW76S2X1Xl5xqj/9DMz
        bk5GaXAtGt7WYLKwiyQmSeYfdkgZsqeB4uXvckrW7c2kgOPIRq9Lo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 60DC736643;
        Wed, 20 Sep 2023 10:57:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A711E36642;
        Wed, 20 Sep 2023 10:57:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Arver <linusa@google.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2023, #05; Fri, 15)
In-Reply-To: <owly1qetjqo1.fsf@fine.c.googlers.com> (Linus Arver's message of
        "Tue, 19 Sep 2023 23:37:50 -0700")
References: <xmqqmsxmdhdw.fsf@gitster.g>
        <owly7comj5ll.fsf@fine.c.googlers.com> <xmqq34z9g8jz.fsf@gitster.g>
        <owly1qetjqo1.fsf@fine.c.googlers.com>
Date:   Wed, 20 Sep 2023 07:57:18 -0700
Message-ID: <xmqqjzskdh9t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FF36434C-57C5-11EE-89B4-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Arver <linusa@google.com> writes:

>> Whatever improvements you have in mind, if they are
>> minor, letting the above graduate (they have been in 'next' for a
>> week without anybody complaining) and doing them as a follow-up
>> series would be sensible, I would think.
>>
>> Thanks.
>
> Hmm, I don't think they are minor? See
> https://github.com/listx/git/tree/trailer-libification-prep for the
> current state of things.

They do not look like "oops the patches I sent to the list was
totally bogus and they need replacing"; aren't they rather "these
are not yet complete and there are some of the follow-on work on top
of them"?

> I need to still follow up to your last comment on "trailer: rename
> *_DEFAULT enums to *_UNSPECIFIED" [2] (I was going to see if we needed
> the "obvious solution" as you described).
>
> If it's too painful to move this out of 'next' now, I'm OK with it
> graduating as is and doing a separate follow-up (I expect several more
> of these to happen anyway). Up to you.

Let's mark the topic as "waiting for follow-up updates" and keep it
in 'next' until the follow-up patches become ready, then.

> Sorry for not noticing that this was in 'next' sooner and communicating
> accordingly.

Gotchas happen.  Let's try to communicate better the next time.

Thanks.
