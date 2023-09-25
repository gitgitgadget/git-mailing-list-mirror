Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475B4CE7AAA
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 17:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbjIYRYR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 13:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIYRYQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 13:24:16 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09ECB10F
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 10:24:10 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7055B1C9C5B;
        Mon, 25 Sep 2023 13:24:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=Z8ba/Xk8USQZXbop9R0ikq5qSxSvaqfcdqLdHk
        3oiUM=; b=v808RMyYcayX7UTozYqkCN7/w9afA/C8sa6PzEiQFNAMabVnTktG5E
        0A3A/7Pa52aP2Ev7MMhsVMciokpOplwteRTPDSmUvyfV50dXlFCK+XHm1yX3VVhw
        B9cueppRdWTPKXPOX/bgRGg0B+TYAt1Z7ycXNuYlakHOrqL85ot+g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 68E0E1C9C5A;
        Mon, 25 Sep 2023 13:24:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C991A1C9C59;
        Mon, 25 Sep 2023 13:24:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Soref <jsoref@gmail.com>
Cc:     Josh Soref via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] pretty-formats.txt: fix whitespace
In-Reply-To: <CACZqfqCVsv-ZaSRWt_ejMn5f_U_1E2h7wsCgUg_50A+KHzOgkA@mail.gmail.com>
        (Josh Soref's message of "Sun, 24 Sep 2023 06:31:46 -0400")
References: <pull.950.git.1695391818917.gitgitgadget@gmail.com>
        <xmqqsf75zxbv.fsf@gitster.g>
        <CACZqfqCVsv-ZaSRWt_ejMn5f_U_1E2h7wsCgUg_50A+KHzOgkA@mail.gmail.com>
Date:   Mon, 25 Sep 2023 10:24:07 -0700
Message-ID: <xmqqsf72upxk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 55EFAE8E-5BC8-11EE-96C5-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Soref <jsoref@gmail.com> writes:

>> > * comma after `etc.` when not ending a sentence
>>
>> There is one instance that says "A, B, C, D, etc., are all accepted."
>> without the comma after 'etc.' and the patch corrects it.  OK.
>
> It seems like this is the only change that's of interest.
>
> Do I just make a distinct gitgitgadget PR with that change, or do I
> ask it to mark that single change as a V2 to this? (given the branch
> name assumed whitespace and the only change would be a comma, it'd be
> kinda wrong...)

;-)

Up to you.  If I were doing this patch, I would wait and see if
others chime in (to support other changes in v1 that I was on the
negative side) and then make v2 with the changes you still believe
in when that happens.

Thanks.
