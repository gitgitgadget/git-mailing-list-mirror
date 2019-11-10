Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 196C11F454
	for <e@80x24.org>; Sun, 10 Nov 2019 06:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfKJG7k (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Nov 2019 01:59:40 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50001 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfKJG7k (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Nov 2019 01:59:40 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E2846364F1;
        Sun, 10 Nov 2019 01:59:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZJpaCOeDoThK4ooDYgFRUNTdMHY=; b=rYszfI
        pY2G173zMC4ecry2XkXy2UrldfgsyoGpkGbByVHwX1O3/8giEpTCGSbRY8jUNv6D
        4JJ7Bxn7jYrMVAliNr6bIdRovQgpREYFJo6ZVy/3slyCUuUfXzqYzb0FsyWHz05M
        /L+FXLx+eG3G04lqTLPHyvhlO8/2JDX1HEai8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=B/dthRlPHrGb5cgYNDiJHOK0A7sQ3N4G
        JjlJ6nt3Q2gu/OK7lH2hZh4gciIg+xrvddCKskrOm1DgDqa9MKqBHyx5KMnRK6Qw
        WoiSKVFkYnhEEYhVsx54kLmFHehfDjtvBdLmpvql6pcuEfrpqB7gJYQoY4QhZVVL
        2yNojmtklWs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DB217364F0;
        Sun, 10 Nov 2019 01:59:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 493D8364EE;
        Sun, 10 Nov 2019 01:59:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Nov 2019, #02; Fri, 8)
References: <xmqqeeyin4kx.fsf@gitster-ct.c.googlers.com>
        <CABPp-BHLAdTDaooQu2YXGcTEtqQrOwZ7cuQNhNuFEnV-yA0FiA@mail.gmail.com>
Date:   Sun, 10 Nov 2019 15:59:36 +0900
In-Reply-To: <CABPp-BHLAdTDaooQu2YXGcTEtqQrOwZ7cuQNhNuFEnV-yA0FiA@mail.gmail.com>
        (Elijah Newren's message of "Fri, 8 Nov 2019 08:44:15 -0800")
Message-ID: <xmqq4kzckyhz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A8A60D3C-0387-11EA-8D62-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Fri, Nov 8, 2019 at 12:43 AM Junio C Hamano <gitster@pobox.com> wrote:
>> * en/doc-typofix (2019-11-07) 11 commits
>>  - Fix spelling errors in no-longer-updated-from-upstream modules
>>  - multimail: fix a few simple spelling errors
>>  - sha1dc: fix trivial comment spelling error
>>  - Fix spelling errors in test commands
>>  - Fix spelling errors in messages shown to users
>>  - Fix spelling errors in names of tests
>>  - Fix spelling errors in comments of testcases
>>  - Fix spelling errors in code comments
>>  - Prefer 'up-to-date' spelling
>>  - Fix spelling errors in documentation outside of Documentation/
>>  - Documentation: fix a bunch of typos, both old and new
>>
>>  Docfix.
>>
>>  Will merge to 'next'.
>
> Wait!  I thought we wanted to eject the uptodate vs. up-to-date patch.

OK, let's drop that one.

Thanks for paying attention.
