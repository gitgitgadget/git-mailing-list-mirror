Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E69D01F462
	for <e@80x24.org>; Wed, 29 May 2019 19:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbfE2Tyc (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 May 2019 15:54:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61425 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfE2Tyb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 May 2019 15:54:31 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 81180152EFE;
        Wed, 29 May 2019 15:54:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KKDZuF2Dd6wWfTZtNiA8Y/CXOeU=; b=KdT9d6
        3hAd/FzPmEa2XCrFFcgfjxzS0vhdv5iOdIlsTVmnNdRAV+9HYXzDX5gfosmlGCTP
        fSx2Gmv6xxHb/dBnT6fWTie9GqS/zzVrigvw8O8STTMz32x+XJ56Eb+zlAz6Ng/8
        NG3e9FzkvaFQ6BYY1mxawn1z1N0s7qfOJh9BY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nU9BjLKoPTfGFSDmgc+hfh+Nx6rY2YDC
        ldHGwYjjv0Gu5XHMrv9DfebnLqsMhEtwLlpOcINLlCcXdd0G16EzobiXJNDK/viQ
        uBLqIwLNEtpYf2/agOxUuGwkY251zPd9whj6kPajFAqEaMtIFqaEHy97Fcw90KGb
        +J2VUDbjW74=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 79ED0152EFD;
        Wed, 29 May 2019 15:54:30 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D550C152EFC;
        Wed, 29 May 2019 15:54:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: ab/send-email-transferencoding-fix, was Re: What's cooking in git.git (May 2019, #04; Tue, 28)
References: <xmqqtvdez0yo.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1905291424140.44@tvgsbejvaqbjf.bet>
        <877ea9mo98.fsf@evledraar.gmail.com>
        <xmqqh89dyxp1.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1905292009030.44@tvgsbejvaqbjf.bet>
Date:   Wed, 29 May 2019 12:54:28 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1905292009030.44@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 29 May 2019 20:10:09 +0200 (CEST)")
Message-ID: <xmqqzhn5xci3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 92397150-824B-11E9-B04E-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Yeah, I recall that one from previous week.  Let's queue it on top
>> (and find the right place tos quash it in).
>
> Sorry, I was unclear. The commit to amend is the tip one: "send-email: fix
> regression in sendemail.identity parsing".

No need to be sorry---I found it out after applying and for a single
liner, it is trivial to see which commit it needs to be squashed
into ;)

FWIW, I learned to try to respond as early as possible to help
unblock other people, and as a consequence, my response may come
before I know exactly what the task is, or when I can get to the
task that I promise in my response.  When I wrote the above, I
didn't exactly recall how many tests your follow-up patch I saw
earlier (or the one you sent this time) was adding prerequisites,
and I didn't yet know how involved it would be to find where it
applies when I wrote my response.

