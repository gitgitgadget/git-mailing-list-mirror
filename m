Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143C9C433EF
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 06:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240137AbiDNGyO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Apr 2022 02:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240084AbiDNGyN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Apr 2022 02:54:13 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3EA4F9C4
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 23:51:49 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B4D8A19FCC9;
        Thu, 14 Apr 2022 02:51:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Vq1mMF8NiFOBhH6QcTT3k8IA4+SCRmIrySxmBK
        ptsBY=; b=oVhCppzK8BNW99Wu/3j27q01+QNoJdynQlwNuIQbdLMy1TMXtaZws6
        h65mcrof5z9kW3ifjqZbg2KoOSteokxyv83I+WoQktMh8QBK8G1gW5V4fBZHl6An
        UT1ps0Q/3O//+w+DKTFv0wv9ayobekp7gu4d9JDoiYHgCzwBPQWDk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AD64519FCC8;
        Thu, 14 Apr 2022 02:51:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9D49219FCC7;
        Thu, 14 Apr 2022 02:51:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v3 2/3] CodingGuidelines: hint why we value clearly
 written log messages
References: <20220126234205.2923388-1-gitster@pobox.com>
        <20220127190259.2470753-3-gitster@pobox.com>
        <YiFYQBWBVq/HQULM@google.com> <xmqqv8wu5zpr.fsf@gitster.g>
Date:   Wed, 13 Apr 2022 23:51:44 -0700
In-Reply-To: <xmqqv8wu5zpr.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        03 Mar 2022 16:27:28 -0800")
Message-ID: <xmqq8rs82m4f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5983AEF6-BBBF-11EC-99FE-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Emily Shaffer <emilyshaffer@google.com> writes:
>
>>> + - Log messages to explain your changes are as important as the
>>> +   changes themselves.  Clearly written code and in-code comments
>>> +   explain how the code works and what is assumed from the surrounding
>>> +   context.  The log messages explain what the changes wanted to
>>> +   achieve and why the changes were necessary (more on this in the
>>> +   accompanying SubmittingPatches document).
>>> +
>>
>> One thing not listed here, that I often hope to find from the commit
>> message (and don't), is "why we did it this way instead of <other way>".
>> I am not sure how to phrase it in this document, though. Maybe:
>>
>>   The log messages explain what the changes wanted to achieve, any
>>   decisions that were made between alternative approaches, and why the
>>   changes were necessary (more on this in blah blah)
>>
>> Or maybe "...whether any alternative approaches were considered..." fits
>> the form of the surrounding sentence better.
>
> Quite valid observation.
>
> Documentation/SubmittingPatches::meaningful-message makes a note on
> these points, and the above may want to be more aligned to them.
>
> Patches welcome, as these have long been merged to 'master/main'.

Another thing.  If you (not Emily, but figuratively) haven't watched
Victoria's talk https://www.youtube.com/watch?v=4qLtKx9S9a8 on the
topic of clearly written commits, you should drop everything you are
doing and go watch it.

And with what we learn from it, we may be able to rewrite this part
of the documentation much more clearly.


