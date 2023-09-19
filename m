Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C88DCE79A9
	for <git@archiver.kernel.org>; Tue, 19 Sep 2023 21:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbjISVZR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Sep 2023 17:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjISVZR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2023 17:25:17 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE790BF
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 14:25:10 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5F6182DA32;
        Tue, 19 Sep 2023 17:25:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=RXHhJipcwMLKDwP0MRPPhcYV3qQfdItkmZuEzD
        McZsA=; b=W9JUOKSAdmqkjCzJ7D0H13jyK5ekQO/T34g22m5XR9OklOVusqec7/
        GGlH59m/wiqKMgJPM8NuVNYJiSHdVRF5jqRUYWjD6iOrjNqFuFhtzrQ57cSCW1Lf
        zJfqNa3xeL6Tdkyi0t80bhZV6ayHWpHxsexRbcoSqz2zt4T0IrdXw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 29B542DA31;
        Tue, 19 Sep 2023 17:25:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B00562DA30;
        Tue, 19 Sep 2023 17:25:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Arver <linusa@google.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2023, #05; Fri, 15)
In-Reply-To: <owly7comj5ll.fsf@fine.c.googlers.com> (Linus Arver's message of
        "Tue, 19 Sep 2023 13:00:38 -0700")
References: <xmqqmsxmdhdw.fsf@gitster.g>
        <owly7comj5ll.fsf@fine.c.googlers.com>
Date:   Tue, 19 Sep 2023 14:25:04 -0700
Message-ID: <xmqq34z9g8jz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 00704796-5733-11EE-A18E-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Arver <linusa@google.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> [Cooking]
>>
>> [...]
>>
>> * la/trailer-cleanups (2023-09-11) 6 commits
>>   (merged to 'next' on 2023-09-12 at 779c4a097a)
>>  + trailer: use offsets for trailer_start/trailer_end
>>  + trailer: rename *_DEFAULT enums to *_UNSPECIFIED
>>  + trailer: teach find_patch_start about --no-divider
>>  + trailer: split process_command_line_args into separate functions
>>  + trailer: split process_input_file into separate pieces
>>  + trailer: separate public from internal portion of trailer_iterator
>>
>>  Code clean-up.
>>
>>  Will merge to 'master'.
>>  source: <pull.1563.v2.git.1694240177.gitgitgadget@gmail.com>
>
> This isn't ready yet (still need to reroll).

Whoa, wait.  I wasn't aware of any more comments that needed
addressing.  Whatever improvements you have in mind, if they are
minor, letting the above graduate (they have been in 'next' for a
week without anybody complaining) and doing them as a follow-up
series would be sensible, I would think.

Thanks.
