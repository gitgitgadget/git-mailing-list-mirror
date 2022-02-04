Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F21C433F5
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 16:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376617AbiBDQmq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 11:42:46 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59159 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233928AbiBDQmq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 11:42:46 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AE8DEF8F7A;
        Fri,  4 Feb 2022 11:42:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=cbfqB3HWJRjU
        Yhkg4/EyyXjULtDapRDQKl4SBL+IFGQ=; b=iab2FzNtLjPUzJJBejqq33x+DjnU
        5o8MHrOptBD0DCIilL6h+DbsAE3SjPI3aagJ1DI31+MjyUk05eenv7fBz8Mgz+XF
        C02PiclFgeYCeGCnHjG3oAvU1DOn6gSCsalbxUs7QSPMP3RQGJVjxPGdTltlCQsf
        XhieEkzD5Rh/I3A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A583CF8F79;
        Fri,  4 Feb 2022 11:42:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0B649F8F77;
        Fri,  4 Feb 2022 11:42:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: en/remerge-diff
References: <xmqqr18jnr2t.fsf@gitster.g>
        <20220204081336.3194538-1-newren@gmail.com>
        <220204.86czk250zv.gmgdl@evledraar.gmail.com>
Date:   Fri, 04 Feb 2022 08:42:43 -0800
In-Reply-To: <220204.86czk250zv.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 04 Feb 2022 12:20:04 +0100")
Message-ID: <xmqqee4ioa64.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7A774012-85D9-11EC-A02B-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Fri, Feb 04 2022, Elijah Newren wrote:
>
>> On Fri, Feb 3, 2022 at 21:22 PM Junio C Hamano <gitster@pobox.com> wro=
te:
>> [...]
>>> * en/remerge-diff (2022-02-02) 11 commits
> ..
> Yes, I'd really like to have this merged down. I didn't comment on your
> v4/v5 re-rolls but everything there looks good to me and addresses any
> outstanding comments I had (to the extent that they needed to be
> addressed at all).

Thanks, both, for your inputs (not just on this topic but also other
ones).

