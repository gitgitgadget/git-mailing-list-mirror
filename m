Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F9AC433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 00:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236848AbiCDA2V (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 19:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbiCDA2U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 19:28:20 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B9E614A
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 16:27:31 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 644321083CD;
        Thu,  3 Mar 2022 19:27:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Oj9+kRaOdyBeGzrWEFqdVjv4LYLBF4zJTSiZMj
        c5G5c=; b=CeWsc262cy+ZEsnawRJza4PsJI/gCSmCjdtD3O75D5ScgVVVtljhFt
        APVVNxYLjLyVU5l9tZFo7955aoz8V5Ekmo19gpT+tHGnGT2dOgU4HbX4sopO8UIg
        PDJViH0OAy+4gTMaWAJ1gAQYh5ecpSSofu9Mvprc0KozgLNu8vFZc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 59C1B1083CC;
        Thu,  3 Mar 2022 19:27:30 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B114E1083C9;
        Thu,  3 Mar 2022 19:27:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 2/3] CodingGuidelines: hint why we value clearly
 written log messages
References: <20220126234205.2923388-1-gitster@pobox.com>
        <20220127190259.2470753-3-gitster@pobox.com>
        <YiFYQBWBVq/HQULM@google.com>
Date:   Thu, 03 Mar 2022 16:27:28 -0800
In-Reply-To: <YiFYQBWBVq/HQULM@google.com> (Emily Shaffer's message of "Thu, 3
        Mar 2022 16:07:28 -0800")
Message-ID: <xmqqv8wu5zpr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E02DE662-9B51-11EC-B1FE-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

>> + - Log messages to explain your changes are as important as the
>> +   changes themselves.  Clearly written code and in-code comments
>> +   explain how the code works and what is assumed from the surrounding
>> +   context.  The log messages explain what the changes wanted to
>> +   achieve and why the changes were necessary (more on this in the
>> +   accompanying SubmittingPatches document).
>> +
>
> One thing not listed here, that I often hope to find from the commit
> message (and don't), is "why we did it this way instead of <other way>".
> I am not sure how to phrase it in this document, though. Maybe:
>
>   The log messages explain what the changes wanted to achieve, any
>   decisions that were made between alternative approaches, and why the
>   changes were necessary (more on this in blah blah)
>
> Or maybe "...whether any alternative approaches were considered..." fits
> the form of the surrounding sentence better.

Quite valid observation.

Documentation/SubmittingPatches::meaningful-message makes a note on
these points, and the above may want to be more aligned to them.

Patches welcome, as these have long been merged to 'master/main'.

Thanks.
