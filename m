Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195A1C433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 15:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED8A061212
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 15:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347153AbhIXPjs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 11:39:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56025 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346508AbhIXPjr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 11:39:47 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1DDEDDF036;
        Fri, 24 Sep 2021 11:38:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=w3a170HQkOiQ
        Xm1EVmdmhYUrRtHZEk/+tfFEVcEKa0k=; b=WlbW2dJqsULdnUBDA8Ci2Ws/rw3t
        SX3hHWsTQz07VcF8himv7ZY7M0bikojpvww4vOPs9NGtmVvwcje7LJACMbEe2Pav
        hOXWi8yyuWi4s9f+d0ozgdAWJIe77JlwYa835t1O7j4wtkAylDzjC5ivBwrOcXEx
        QEA1DNngblE2bXo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 16460DF035;
        Fri, 24 Sep 2021 11:38:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 767DDDF033;
        Fri, 24 Sep 2021 11:38:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
Subject: Re: js/win-lazyload-buildfix (was Re: What's cooking in git.git
 (Sep 2021, #07; Thu, 23))
References: <xmqqa6k2yj1j.fsf@gitster.g> <YU2W24RUaN4OHrcn@carlos-mbp.lan>
Date:   Fri, 24 Sep 2021 08:38:12 -0700
In-Reply-To: <YU2W24RUaN4OHrcn@carlos-mbp.lan> ("Carlo Marcelo Arenas
 =?utf-8?Q?Bel=C3=B3n=22's?=
        message of "Fri, 24 Sep 2021 02:14:03 -0700")
Message-ID: <xmqqv92qvva3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6DE41716-1D4D-11EC-87E8-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:

> On Thu, Sep 23, 2021 at 04:22:00PM -0700, Junio C Hamano wrote:
>>=20
>> * js/win-lazyload-buildfix (2021-09-23) 2 commits
>>  - lazyload.h: use an even more generic function pointer than FARPROC
>>  - lazyload.h: fix warnings about mismatching function pointer types
>>=20
>>  Compilation fix.
>>=20
>>  Will merge to 'next'.
>
> Sorry to hijack this thread with this minor point, but I was hoping[1]
> from a reroll of this topic from Hannes.
>
> Alternatively the patch below the scissors would be nice to squash or
> it will be harder to fix later.

Your message is *not* hijacking the topic.  What's cooking reports
are designed to invite a comment like yours to stop me from acting
on my faulty understanding of the status of each topic.

Thanks.  Will hold to see what J6t says.



