Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D72CD6128
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 19:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378277AbjJITCD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 15:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378180AbjJITCB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 15:02:01 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D1CD8
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 12:01:54 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7C5032A481;
        Mon,  9 Oct 2023 15:01:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=w+bBJHHuibO1/6RzDsxjxN0ZMDZDPhP9pDAmA0
        w10K4=; b=jZJEBheEgWvOit5hVt5aIJzuAmXl1SUY88HHyXopV+e9KQaM3jDm8G
        2A5hSjoYtsMYQ8qeT6e+hRSMtJpunG6+2LDIcMGU8+gr6oLrdMarP4Uv7h8kBSD8
        sWP3LZctZZ5Cs5AwHLx0u2W5U1h5QFECgVTjJhW4hbbHG6VTCjfc4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 759952A480;
        Mon,  9 Oct 2023 15:01:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0B81F2A47F;
        Mon,  9 Oct 2023 15:01:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 03/25] documentation: fix typos
In-Reply-To: <92beac82-f0fd-452b-858f-453cdf21b71f@ramsayjones.plus.com>
        (Ramsay Jones's message of "Sun, 8 Oct 2023 17:32:07 +0100")
References: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
        <fffcf580b29153a3c4c7ead3abfb2b621d3a0d46.1696747529.git.gitgitgadget@gmail.com>
        <92beac82-f0fd-452b-858f-453cdf21b71f@ramsayjones.plus.com>
Date:   Mon, 09 Oct 2023 12:01:49 -0700
Message-ID: <xmqqbkd7zkki.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4DDFEA2E-66D6-11EE-94F4-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> On 08/10/2023 07:45, Elijah Newren via GitGitGadget wrote:
> [snip]
>> diff --git a/Documentation/gitformat-pack.txt b/Documentation/gitformat-pack.txt
>> index 870e00f2982..42afb953e8c 100644
>> --- a/Documentation/gitformat-pack.txt
>> +++ b/Documentation/gitformat-pack.txt
>> @@ -17,8 +17,8 @@ $GIT_DIR/objects/pack/multi-pack-index
>>  DESCRIPTION
>>  -----------
>>  
>> -The Git pack format is now Git stores most of its primary repository
>> -data. Over the lietime af a repository loose objects (if any) and
>> +The Git pack format is how Git stores most of its primary repository
>> +data. Over the lietime of a repository loose objects (if any) and
>
> Hmm, this tyop jumped out at me while this patch
> floated past... (at least I assume it is a typo!):
>
>   s/lietime/lifetime/
>
> ATB,
> Ramsay Jones

Thanks, will squash in.
