Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 662A31F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 23:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389755AbfJVXiC (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 19:38:02 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64068 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731847AbfJVXiC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 19:38:02 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5D24834D78;
        Tue, 22 Oct 2019 19:38:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pApbpEXi3VP09+hWXEpakjbxIAM=; b=g7HmPN
        NXfr4rr3pMQYoD03ZggHaXkZoi/Th4PrJTNksoIXuANj11f3bDWXorkoiwRaFkL6
        LEEPeO4q8n2uBjba57LsgXsBsaQSNsGJ0WWzr11LHyV3MZw2/b8n0GgNsbsqC9Gv
        W4LeqDYyubcv5TMxL7bxmaNoc6ezzaYNRn5c4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=T6b3EDROSXnbK/S8GJplwnOu0l+J8fZ+
        eKLjBk851pijYhOpuwdi/DT8YXy3KgDfhqp+rrUvxNMoc3sIAlDVOeWB5lUUvJi4
        rEr/LIPg8cc9NoB9lltQuvnXB7WWhoS7rvrrKEd4vil9J70kR6C2EvZn05nifylJ
        SAIDrriSQps=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3550334D77;
        Tue, 22 Oct 2019 19:38:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 648C434D76;
        Tue, 22 Oct 2019 19:38:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 1/1] ci(osx): use new location of the `perforce` cask
References: <pull.400.git.1571160721.gitgitgadget@gmail.com>
        <pull.400.v2.git.1571316454.gitgitgadget@gmail.com>
        <372ab24acffbc956407cd93ed34135f83156e10d.1571316454.git.gitgitgadget@gmail.com>
        <20191018105143.GY29845@szeder.dev>
        <xmqqeez6n8j7.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1910230123540.46@tvgsbejvaqbjf.bet>
Date:   Wed, 23 Oct 2019 08:37:58 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1910230123540.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 23 Oct 2019 01:28:03 +0200 (CEST)")
Message-ID: <xmqq36fkl5bd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FBD7F7E8-F524-11E9-BC5C-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> This is already in 'next' X-<; reverting a merge is cheap but I
>> prefer to do so when we already have a replacement.
>
> I force-pushed (see https://github.com/gitgitgadget/git/pull/400), and
> once Stolee approves, he will submit v3. This will only change the
> commit message, though, as I disagree that hard-coding the URL would be
> an improvement: the nice thing about a package management system is that
> the user does not need to know the details (or need to know if the
> details change, like, ever).

If this were meant for the upcoming release, I would rather see us
copy a butt-ugly-but-known-working procedure if we have one this
close to -rc1.  If the hard-coded URL ever changes, the procedure
we would be copying from would be broken anyway.

But I agree 100% that we should take a conceptually cleaner approach
for the longer term.  Let's replace the original one with this and
cook in 'next'---it would be ideal if the ugly-but-know-working one
be updated to match in the meantime, but if it is bypassing package
management for a reason (the upstream just publishes the URL to
download from without packaging it properly, for example?), that
would not be possible, and it is OK if that is the case.

Thanks.



