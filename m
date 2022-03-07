Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46B7C433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 17:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243842AbiCGRTc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 12:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243701AbiCGRTb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 12:19:31 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992B843ED2
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 09:18:35 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0EA7F179657;
        Mon,  7 Mar 2022 12:18:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=waGC0bYs7rCX1xkg1JkozlMfGTpcbC4woBPWcW
        6UZF4=; b=KpQMwpxpvHYw9nZVGgyujrgJlz7HCL0xJyqt3Hchu9R0530upQUole
        4l9H7buYTT3AN7e59dnrwARXtNZnS44JkClBuRWJlK08gLClJVlYcaFDApkt1db6
        1uUmEyoe0Hm3HFU8l7QeiMQcvO1UjVqsm/qrQqpn59xUOylkCYuu8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0748C179656;
        Mon,  7 Mar 2022 12:18:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7F4E9179654;
        Mon,  7 Mar 2022 12:18:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: ds/commit-graph-gen-v2-fixes (was Re: What's cooking in git.git
 (Mar 2022, #01; Thu, 3))
References: <xmqqv8wu2vag.fsf@gitster.g>
        <3683c549-6efc-2c67-1130-d7008100ee55@github.com>
Date:   Mon, 07 Mar 2022 09:18:31 -0800
In-Reply-To: <3683c549-6efc-2c67-1130-d7008100ee55@github.com> (Derrick
        Stolee's message of "Mon, 7 Mar 2022 08:49:43 -0500")
Message-ID: <xmqqee3du1eg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9D432CAE-9E3A-11EC-9117-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> On 3/3/2022 11:31 PM, Junio C Hamano wrote:
>
>> * ds/commit-graph-gen-v2-fixes (2022-03-01) 5 commits
>>  - commit-graph: fix generation number v2 overflow values
>>  - commit-graph: start parsing generation v2 (again)
>>  - commit-graph: fix ordering bug in generation numbers
>>  - t5318: extract helpers to lib-commit-graph.sh
>>  - test-read-graph: include extra post-parse info
>> 
>>  Fixes to the way generation number v2 in the commit-graph files are
>>  (not) handled.
>>  source: <pull.1163.v3.git.1646164112.gitgitgadget@gmail.com>
>
> After discussing the issues in detail with Patrick, it seems
> that an additional patch is required (submitted in [1], though
> I incorrectly numbered it "5/4" when it should be "6/5"). I can
> also re-roll to make sure that the patch is visible inline with
> the rest of the series, if you want.
>
> Thanks,
> -Stolee
>
> [1] https://lore.kernel.org/git/db5eb248-1b54-9f24-8f8a-28c19a1eee6a@github.com/

I do recall seeing the follow-up patch.  Let me queue it on top.

Thanks.


