Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 659161F463
	for <e@80x24.org>; Fri, 20 Sep 2019 16:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390894AbfITQuk (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 12:50:40 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56438 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390491AbfITQuk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 12:50:40 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4B9F1967A7;
        Fri, 20 Sep 2019 12:50:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DmEBFBb6/+22Zdo6hhl/kTa9PdQ=; b=B4XBPf
        dM0ethED3N3kKwgch0e3v1UTm1hELqxlSb4dPbL0Xh397EX0exksz3Ok7LL+Xzt7
        7hwhf6oklwIIVK2rq+JoHOVrybzafRr+uAW/E032tmvv+cXsf5cudlnQs6ZQrzfW
        6UvGvRWmXYa2gDrhC1uvUrsEkSI4BFVLB1Bo8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MunFbi4JBns33AGCur4IYU99P+GoADw5
        Re6iHKA7QH7Vu0lKR3X985UNHvS45yySgCTLeO+zsyiX1FUjiqQyBI8mMTn/zP5Y
        3mn7s/c9cey5oWdwGGse4JLslmrVy3cNNJ1keWy17SokHNG2gBBE0Q7aaUfMsaE4
        rue1U3Y4vpk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 44768967A6;
        Fri, 20 Sep 2019 12:50:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 66E18967A3;
        Fri, 20 Sep 2019 12:50:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2019, #02; Wed, 18)
References: <xmqqy2yl44lw.fsf@gitster-ct.c.googlers.com>
        <20190918223741.79215-1-jonathantanmy@google.com>
Date:   Fri, 20 Sep 2019 09:50:33 -0700
In-Reply-To: <20190918223741.79215-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Wed, 18 Sep 2019 15:37:41 -0700")
Message-ID: <xmqqd0fux67a.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C444E0D8-DBC6-11E9-8390-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> * jt/cache-tree-avoid-lazy-fetch-during-merge (2019-09-09) 1 commit
>>  - cache-tree: do not lazy-fetch tentative tree
>> 
>>  The cache-tree code has been taught to be less aggressive in
>>  attempting to see if a tree object it computed already exists in
>>  the repository.
>> 
>>  Waiting for a response to an updated log message.
>
> I've responded here:
>
> https://public-inbox.org/git/20190910181534.134890-1-jonathantanmy@google.com/

Thanks.
