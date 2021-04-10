Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB25C433B4
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 04:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8447261184
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 04:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbhDJEPH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Apr 2021 00:15:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60875 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234059AbhDJEPC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Apr 2021 00:15:02 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 323C1B1128;
        Sat, 10 Apr 2021 00:14:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=XmhEXCtKgAUF
        hVevqH23tBZudjk=; b=jFNtVdmYqhaY6NtcrwtKc8t0Bj3E74ZwrKn31XR8Zd0O
        vSS2WHH48cYeeokLSmIyo1EBvLIZ7FP/JlDvHi8IZbqZfX6uHr+RxQDn5Ts0imHp
        xWgEeeb1ek1rDqhUjsHmtryPyZpohvFx/lRIEKuJiA20zypSiRDg+1FnstOS6J0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=RhLRPD
        SNqcJPD50boDDyncrjaK5ZInI1YX0uOcIPFIj+YBYJ4Fb2F7TJlIVSXsE8CFnbup
        l9T8AH4dzTE7draB0Pgvb3PA6Gr5MtVgf+LcBonFBn3BhRA8/Gc5fi1BhyecZ5Jk
        36rQSPcCZSPY6ZMrOXG3AzzPUS2NqUDwc/Js8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 293F5B1127;
        Sat, 10 Apr 2021 00:14:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B38D3B1126;
        Sat, 10 Apr 2021 00:14:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/5] doc lint: lint and fix missing "GIT" end sections
References: <cover-0.6-00000000000-20210326T103454Z-avarab@gmail.com>
        <patch-5.6-d4004b6a7cb-20210326T103454Z-avarab@gmail.com>
        <xmqqr1jzn5j5.fsf@gitster.g> <xmqqk0prmafq.fsf@gitster.g>
        <87lf9rhe4y.fsf@evledraar.gmail.com>
Date:   Fri, 09 Apr 2021 21:14:46 -0700
In-Reply-To: <87lf9rhe4y.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 09 Apr 2021 13:49:01 +0200")
Message-ID: <xmqq4kgelqrt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 49931B5A-99B3-11EB-8764-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> It adds the value of:
>
>  * If you're looking at e.g. git-subtree's manpage it doesn't have it,
>    so we're clearly marking things that are part of git itself, also if
>    you're doing e.g. "man git-annex" (or other non-git.git tool)
>    somewhere.
>
>  * Once you're at the bottom of a manpage in e.g. a web view it's a
>    handy link back to the start, see
>    e.g. https://git-scm.com/docs/git-add#_git

OK, that's fair enough.

Thanks for a clarification.

