Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3A0C433DB
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 20:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 013236197B
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 20:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhCSUTr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 16:19:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53076 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhCSUTn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 16:19:43 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 30122BBB0F;
        Fri, 19 Mar 2021 16:19:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WBbLd6aLjE1HwBHxAzekFhAM2XI=; b=PsQT5o
        1AypLqJtt8x0PYkxoG21bb3kHUTYkyH7dx+La/CLTEvB6vjQtK3+8ZmJQlZIhSCW
        c7YP10hi+AwzsQLwwK9eOfdl84QnUWv1aRGMZHkHwC5YSBnPxnO1gUICGADCpd3R
        HLH/mCSViXnWkHp02drIfB1pv3qgxCvgvFdH4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wHkbjXxKGL9tXjAinQeaifFONGhkuHbK
        mxe/17htuKM53z5Tmup9uCKjvKTDzPG7LulPIO6ZZNuPRLyXh2OYf/xlts1uw36x
        /lRZ6iL1BFnFj6geZFMMLbJw8fn2euWRN1VbdlWeliZMCezu4E0yiSY4rPtl00Wg
        vnjO9NJavrk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 27035BBB0E;
        Fri, 19 Mar 2021 16:19:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A823EBBB0D;
        Fri, 19 Mar 2021 16:19:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Nils Leif Fischer via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        Nils Leif Fischer <hello@nilsleiffischer.de>,
        Nils Leif Fischer <nils.fischer@aei.mpg.de>
Subject: Re: [PATCH] Fix a typo in git-maintenance documentation
References: <pull.984.git.git.1616149021392.gitgitgadget@gmail.com>
        <xmqqv99nm3jy.fsf@gitster.g>
Date:   Fri, 19 Mar 2021 13:19:41 -0700
In-Reply-To: <xmqqv99nm3jy.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        19 Mar 2021 10:55:13 -0700")
Message-ID: <xmqqa6qynbfm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7091EDA4-88F0-11EB-803D-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>  gc::
>>  	Clean up unnecessary files and optimize the local repository. "GC"
>> -	stands for "garbage collection," but this task performs many
>> +	stands for "garbage collection", but this task performs many
>
> Isn't this merely an American style vs British style issue?

Having said that, I think a lot of existing documentation (and my
gut feeling says "majority of", but I cannot claim anything like
that without actually counting [*1*]) we have tend to stick to the
"punctuation outside" British style [*2*].

If somebody (not me, and probably not Derrick) is willing to do the
counting and tree-wide style fixes, I am OK if we add some new text
to Documentation/CodingGuidelines to declare which style we stick
to, and enforce consistency throughout the documentation set.


[Footnote]

*1* A quick count:

    $ git grep -e '," ' Documentation/

    gives just a single hit.  On the other hand, '", ' hits too many,
    but many are sentences like 

      "git clone -q", "git fetch -q", and the like are quiet.

    which is not quite fair.

    Don't try to do that for the comma replaced with period; you'd be
    buried by "word..."  and the like.


*2* After all, that is more "logical", for us CS types---opening and
    closing quotes pair with each other, and the punctuation that
    appears near the quoted portion is part of the larger sentence
    structure.
