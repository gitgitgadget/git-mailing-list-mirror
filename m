Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C02C433C1
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 22:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAAB460230
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 22:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhCUWRi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 18:17:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63271 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhCUWRG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 18:17:06 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0EAD2C5A8D;
        Sun, 21 Mar 2021 18:17:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4FPRVRquwIXwaJkwFVtMSm5func=; b=cxQHiZ
        h4vi09ejrXv6goL3S4k5vt/1yeA/oqanP5HunRoNEjMVaqx0VgCRdX8wnr/0c0zu
        YzFcDDgULhiEqMI6EyZTC5Ojtw6XroXuApdXYP8164Ox5dkqJn8a0W48IVsfAfV0
        /lWgzpmQuWw4ehOF9snyUdjkJ+EeFOE432SDs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lIzNeBAh6xhZnEs6EMZo7zhn3NlV7pCN
        rSx4DAUsW6pDSvqKAFTaV9ewhasWMgZLltiKs3UoFJ30CjDvGhDHBmoy3iTwidM2
        xV+mBFpHaAYHGkbmda1MXzMn1CBqwhh1vBxyhRaQ9Rsv8j+2bl19vcu1F+PG4+Bk
        7oJSIbjF4SQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F23F7C5A8C;
        Sun, 21 Mar 2021 18:17:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4F5A4C5A8B;
        Sun, 21 Mar 2021 18:17:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Georgios Kontaxis" <geko1702+commits@99rst.org>
Cc:     "Georgios Kontaxis via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3] gitweb: redacted e-mail addresses feature.
References: <pull.910.v2.git.1616297564158.gitgitgadget@gmail.com>
        <pull.910.v3.git.1616347731514.gitgitgadget@gmail.com>
        <xmqqzgyw9wn3.fsf@gitster.g>
        <dfb1fe6cdf78788250009abe8e1489c8.squirrel@mail.kodaksys.org>
Date:   Sun, 21 Mar 2021 15:17:04 -0700
In-Reply-To: <dfb1fe6cdf78788250009abe8e1489c8.squirrel@mail.kodaksys.org>
        (Georgios Kontaxis's message of "Sun, 21 Mar 2021 20:07:22 -0000")
Message-ID: <xmqqmtuw884f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2B22BDA8-8A93-11EB-A12F-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Georgios Kontaxis" <geko1702+commits@99rst.org> writes:

>> ... so I doubt
>> the wisdom of munging the patch part at all.
>>
>> I may be sympathetic to the cause of the patch, but, I do not agree
>> with its execution in this iteration of the patch.
>>
> I see your point.
>
> It seems hiding e-mail addresses should be limited to the commit message,
> i.e., stop at the "---" line.

I doubt it makes sense to redact anything in the 'patch' view at
all, actually.  What kind of URL does the crawler need to formulate
and what pieces of information (like commit object names or branch
names) does it need to fill in the URL to get a series of patches
out of gitweb?  As long as it takes more effort than running "git
clone" against the repository, the crawler would not have much
incentive to crawl and harvest addresses from the 'patch' pages, and
even in the log message part, the downsides of butchering the
payload would outweigh the "privacy benefit", I would have to say.

Quite honestly, if a site claims to offer a 'patch' download UI but
returns corrupt data back, I would say it is much worse than not
offering the service at all.  Perhaps disabling the 'patch' feature
in repositories that enable 'privacy' feature may be a much better
approach.
