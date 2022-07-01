Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF00C43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 21:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbiGAVub (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 17:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbiGAVua (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 17:50:30 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2D559269
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 14:50:30 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4C01B138475;
        Fri,  1 Jul 2022 17:50:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HCN1GHQmH/IF6uAlTLw76xNFmyfIt2Nwi94DUG
        BkyeU=; b=xjQnmiRrd+fowvwYTYKguepWBur9XavFB2JpO7imBjZYDP3/30CF0F
        AV9AIsONUSLXmuNb/gxyuMfosH0jzbWrkOYUxLnUZ/XoGK99EaDOoRU9VBulVqeF
        B808KnQWsnSezr9DZR9+MRB7Q+3ZOk4wKCzFxljJIfm14eswo6kvc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 30CB8138473;
        Fri,  1 Jul 2022 17:50:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7CEFE138472;
        Fri,  1 Jul 2022 17:50:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org,
        vdye@github.com
Subject: Re: [PATCH v5 0/8] mv: fix out-of-cone file/directory move logic
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
        <20220630023737.473690-1-shaoxuan.yuan02@gmail.com>
        <b06e2765-940e-0157-4eab-4faf8aefa2f4@github.com>
Date:   Fri, 01 Jul 2022 14:50:27 -0700
In-Reply-To: <b06e2765-940e-0157-4eab-4faf8aefa2f4@github.com> (Derrick
        Stolee's message of "Fri, 1 Jul 2022 15:43:26 -0400")
Message-ID: <xmqq35fk7ba4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D2457332-F987-11EC-BE7D-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> On 6/29/2022 10:37 PM, Shaoxuan Yuan wrote:
>> ## Changes since PATCH v4 ##
>> 
>> 1. Fix style-nits.
>> 
>> 2. Add t1092 tests (2/8) for "mv: add check_dir_in_index() and solve 
>>    general dir check issue" (8/8).
>
> Thank you for these updates. I just took a quick
> re-read and I'm happy with this version.
>
> Thanks,
> -Stolee

Thanks, all.  Will queue.
