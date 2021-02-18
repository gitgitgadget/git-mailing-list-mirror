Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5252C433E0
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 19:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6062364EB3
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 19:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbhBRTss (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 14:48:48 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63473 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbhBRTcK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 14:32:10 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DD45BB0D02;
        Thu, 18 Feb 2021 14:31:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=5rBF4/LJPyp1
        NouF9LUe0TTByN8=; b=sjfuyhfJ9n+nN/QTztidpxl7O7C6g7DOljOMt3PxnK6J
        18v2yQfZmXfyz2fDT9546F+Hj/xdTynAlOOSfNQdJ2o5579UNymM4+mkzZq8JeN7
        7LXmIUBXT0DRXPBTDydE16E2ojQE4H0ACCp0vs4CVovJNJ3pvjEOXKqjpfq+2SM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=DI/WgI
        uw3XUeneRuZBfGNKm6iDEJCpcQSWbmd0wYMrQB0FOqweASjh6BzyprZQr/bsyVYH
        h5V6frXq3Hozy/W+9QGD0FhrXkYahhPF9GeqsLZ9qkDyZIa4eH/1yCo3j0YpMMMd
        eU2lgm1IVSkKQNDvg5TpdwWqIPedsGe8PR44M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D40A6B0D01;
        Thu, 18 Feb 2021 14:31:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 56DE9B0D00;
        Thu, 18 Feb 2021 14:31:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Feb 2021, #03; Wed, 17)
References: <xmqqr1legm5v.fsf@gitster.g>
        <CAN0heSqHLzGSZ87GLo8dm854ZOMONCv0c69YFX_=40q5wG66JQ@mail.gmail.com>
Date:   Thu, 18 Feb 2021 11:31:25 -0800
In-Reply-To: <CAN0heSqHLzGSZ87GLo8dm854ZOMONCv0c69YFX_=40q5wG66JQ@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Thu, 18 Feb 2021 07:44:29
 +0100")
Message-ID: <xmqqczwxfa0i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E43D5D7A-721F-11EB-9B89-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> On Thu, 18 Feb 2021 at 03:13, Junio C Hamano <gitster@pobox.com> wrote:
>> * ma/doc-markup-fix (2021-02-17) 2 commits
>>  - gitmailmap.txt: fix rendering of e-mail addresses
>>  - rev-list-options.txt: fix rendering of bonus paragraph
>>
>>  Docfix.
>>
>>  Will merge to 'next'.
>
> Thanks for picking it up.

Thanks for contributing.

> It looks like you didn't pick up the middle(!) one, "git.txt: fix
> monospace rendering". I thought maybe you queued it somewhere else, but
> I can't seem to find it anywhere. Chris, and later Patrick, had a
> question about it, which was maybe why you skipped it. I hope I've
> resolved that confusion, which was entirely caused by my cramming
> something too diff-like into the commentary of the patch.

Yeah, I too commented on that one myself just now.  It is a mystery
how I managed to miss the entire discussion (including the starting
patch in the middle of a 3-patch series) yesterday.

> Obviously, that patch 2/3 doesn't need to go in the middle -- it can
> just as well be at the top.
>
> Martin
