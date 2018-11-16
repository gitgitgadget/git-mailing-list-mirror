Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C45391F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 10:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389368AbeKPU6A (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 15:58:00 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53240 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727539AbeKPU57 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 15:57:59 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E4CDC10BC07;
        Fri, 16 Nov 2018 05:46:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8W8pmAXPW9OhTGRx2WD+fG2QfRM=; b=Fa2VZ7
        c0rHJ47V1UOKu4J3aGwjRghlWkbU8KQ6mIqhVowXL+sEYl1oxo5VdXKdhKTwbprv
        +JhVqy/e/vrlU/pOM/SaA9IuG5cZ7cfsFTgUQruxhCbiDlk3kD3Cfiwh+i67mQm5
        OVIUVYUM9aZE29R4hYTBaltgDgzgL5HUolYOs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RQVYhNePwznoUYL9bQXZjjsA2+7BuUHv
        HSk1L5PXdB5tjDeLxWhcGq6I+EOPgkzfj/FBv9xPcjxhNlZhcNrWhnwXjWFGBbu2
        vh7OlrwCDseb9rEmFMu7Foz//tOuDXTBqYXeGGexOmPt8wSlfBDn1e6dMN/DvILv
        fb9USZY+pXM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DBBFE10BC06;
        Fri, 16 Nov 2018 05:46:10 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 528BD10BC04;
        Fri, 16 Nov 2018 05:46:10 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jonathantanmy@google.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH v4 0/1] Advertise multiple supported proto versions
References: <cover.1542059029.git.steadmon@google.com>
        <cover.1542162201.git.steadmon@google.com>
        <xmqqin10m01g.fsf@gitster-ct.c.googlers.com>
        <20181114195142.GI126896@google.com>
Date:   Fri, 16 Nov 2018 19:46:09 +0900
In-Reply-To: <20181114195142.GI126896@google.com> (Josh Steadmon's message of
        "Wed, 14 Nov 2018 11:51:42 -0800")
Message-ID: <xmqqo9api9la.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D46E6A7E-E98C-11E8-A339-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

>> This one unfortunately seems to interact rather badly with your
>> js/remote-archive-v2 topic which is already in 'next', when this
>> topic is merged to 'pu', and my attempt to mechanically resolve
>> conflicts breaks t5000.
>
> Hmm, should we drop js/remote-archive-v2 then? Any solution that
> unblocks js/remote-archive-v2 will almost certainly depend on this
> patch.

That one is already in 'next' for quite some time.  If you are
retrating it, that's OK.

Let me revert the topic out of 'next' and discard it, and then queue
this one in 'pu'.

Thanks.




