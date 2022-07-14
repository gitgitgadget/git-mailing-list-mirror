Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175ADC433EF
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 16:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbiGNQf0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 12:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiGNQfZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 12:35:25 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7335A2F1
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 09:35:23 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F671143061;
        Thu, 14 Jul 2022 12:35:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1o6mb3kbwPlEmC4MZoSO28BTCNu1vZUEA0hzxN
        M7+Vo=; b=TO0YstKQIAYg+rH3U6aPwRbWvkaZD74ZKA0oNb2Gb4AokxVAeM0ztW
        axm3Kiadmu23ym5iYCwU3/YakJPvzGCyWfsaJ7qJ3iX/PYzmnCu7YwoJ1jeL81aD
        33Xcbe+Klcn5JkylIw1spTmET7vZzcxpm4SxE4cN+qb//Dv4dPOvA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 35F43143060;
        Thu, 14 Jul 2022 12:35:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9BBA214305F;
        Thu, 14 Jul 2022 12:35:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org
Subject: Re: ds/rebase-update-ref (was Re: What's cooking in git.git (Jul
 2022, #04; Wed, 13))
References: <xmqq7d4g8onl.fsf@gitster.g>
        <c77648aa-b74b-008b-0bc0-bd6f95eedf2f@github.com>
Date:   Thu, 14 Jul 2022 09:35:21 -0700
In-Reply-To: <c77648aa-b74b-008b-0bc0-bd6f95eedf2f@github.com> (Derrick
        Stolee's message of "Thu, 14 Jul 2022 08:11:39 -0400")
Message-ID: <xmqqpmi77iuu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F4DC1D14-0392-11ED-97C1-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>>  "git rebase -i" learns to update branches whose tip appear in the
>>  rebased range.
>> 
>>  Expecting a reroll.
>>  cf. <15631ea2-6722-fd24-c8a6-0cee638b0602@github.com>
>>  source: <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
>
> It looks like you've picked up the latest re-roll (v4), so this
> status is a little stale.

Yes, indeed.  Sorry, and thanks.  Will update.
