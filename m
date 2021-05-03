Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA11C433B4
	for <git@archiver.kernel.org>; Mon,  3 May 2021 02:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D680561208
	for <git@archiver.kernel.org>; Mon,  3 May 2021 02:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbhECCjZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 May 2021 22:39:25 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55643 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbhECCjX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 May 2021 22:39:23 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CC59813A9DB;
        Sun,  2 May 2021 22:38:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ezXS3mrSEYMt
        nHU9EQjpt4T/8n4hPmuZ57G/ly/5KQ8=; b=LKmXQci/EIWbZeJSRbrU2JWqP7Uq
        /AVObtwQLs3vboBDwWNp+sV1fv6AnOMPHMP4xKSCZ4B6mD4RLvEcsoHzMKZkoV9p
        l7NDCBYnhZG+BiXN6KKX2uQGrfnK4UYtDzqIBI2UCDK+fG6Ff9U4Z9Ozo6b6p2EK
        WIx8rwEbInKk65c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C56EC13A9DA;
        Sun,  2 May 2021 22:38:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1B96A13A9D6;
        Sun,  2 May 2021 22:38:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: What's cooking in git.git (Apr 2021, #06; Thu, 29)
References: <xmqqr1itfo41.fsf@gitster.g> <87im44xerh.fsf@evledraar.gmail.com>
Date:   Mon, 03 May 2021 11:38:26 +0900
In-Reply-To: <87im44xerh.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 30 Apr 2021 11:34:39 +0200")
Message-ID: <xmqqwnsga6e5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A426FB9C-ABB8-11EB-8FC1-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> * ab/pretty-date-format-tests (2021-04-27) 2 commits
>>  - pretty tests: give --date/format tests a better description
>>  - pretty tests: simplify %aI/%cI date format test
>>  (this branch is used by zh/pretty-date-human.)
>>
>>  Tweak a few tests for "log --format=3D..." that show timestamps in
>>  various formats.
>>
>>  Will merge to 'next'.
>
> Thanks. Good to know not all my "I read this series and here's some
> small patches ..." are a distraction :)

It largely depends.  This time the other contributor helped by
deciding to work with this topic, but that does not necessarily
happen all the time.
