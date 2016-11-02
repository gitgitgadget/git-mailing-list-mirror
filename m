Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A37C420193
	for <e@80x24.org>; Wed,  2 Nov 2016 12:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752971AbcKBMzf (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 08:55:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63581 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752509AbcKBMze (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 08:55:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8A83246A02;
        Wed,  2 Nov 2016 08:55:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=CwZXh0nHPZvn
        fswlNxTqwdAUvJk=; b=Yx8TnBnx7PNQj7rw37ynQ2tTm+D145fv9ErXD6xoy1Rn
        cRwlsAZTs5+5nHKgrbA6YrgmxQAtw4B4xoDH3EPlaZl+9nBFT13Q3qCaMjuBs6kI
        B5+mK1302p+PNTGJnQZxfQWQ7dEtBKglySumCFU7qtxEumvA//8Ic1UTGAdCYho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=xH0+tz
        4SFiMm61I8coulrQ0rLSApQZtYCm5U17jmYq4adAgw+arjrHX44xVtGzOExXvUFf
        UOuITR7WJ1GqvhJNXav98G2wyk9KnRs5PMtf96Yrt99GXQMb4lEJcyfKw8vAjw43
        c3T9KjEnnfyKa+hVx4jJ/c8DOqxtos1Ux4Nqc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 83C0146A01;
        Wed,  2 Nov 2016 08:55:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0605346A00;
        Wed,  2 Nov 2016 08:55:31 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2016, #09; Mon, 31)
References: <xmqqwpgoqjct.fsf@gitster.mtv.corp.google.com>
        <20161102071646.GA5094@tb-raspi>
Date:   Wed, 02 Nov 2016 05:55:29 -0700
In-Reply-To: <20161102071646.GA5094@tb-raspi> ("Torsten =?utf-8?Q?B=C3=B6g?=
 =?utf-8?Q?ershausen=22's?=
        message of "Wed, 2 Nov 2016 07:16:46 +0000")
Message-ID: <xmqq37jaf3cu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A36C244C-A0FB-11E6-9420-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>> * tb/convert-stream-check (2016-10-27) 2 commits
>>  - convert.c: stream and fast search for binary
>>  - read-cache: factor out get_sha1_from_index() helper
>>=20
>
> It looks to be a good "proof of concept".
>
> The current series is far away from being ready, so please kick it
> out of pu and feel free to discard.

Thanks for a heads-up.  Anything in 'pu' won't be of importance
until 2.11 final, so please don't worry too much about it.
