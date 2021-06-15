Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961EAC48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 06:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EFA661410
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 06:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhFOGFA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 02:05:00 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51710 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhFOGFA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 02:05:00 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EA10A13CBAF;
        Tue, 15 Jun 2021 02:02:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=MO1Yz1JW9iVu
        uIxxqEPld4CCHMBwvicMxg+eW4ap2qc=; b=PXc2OW/EcUTLMsPDWa7vE114buUS
        ZICuCwNKKW8qAqXKGjLbf4hPig2tToKqNF9rO9hiE9BVGnF4yYVlHv2k1B7CpH3V
        cnZFmyZyqon8iJk2Y3OjeOEbuqSsm0jDNL2hXo13fXqtQHLCAXc++WiLVfTGtnIA
        iUjGFQc3nMxxBxA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E2DD713CBAE;
        Tue, 15 Jun 2021 02:02:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EEC0413CBAD;
        Tue, 15 Jun 2021 02:02:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jrnieder@gmail.com, emilyshaffer@google.com,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Jeff King <peff@peff.net>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 0/4] Use singular "they" when appropriate
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
        <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
        <87a6nz2fda.fsf@evledraar.gmail.com>
        <YMKTARn368Qzsqc2@camp.crustytoothpaste.net>
        <87pmwt1dz3.fsf@evledraar.gmail.com>
        <f4488360-bdaf-3e97-69c5-00087f797117@gmail.com>
        <87h7i21a43.fsf@evledraar.gmail.com>
Date:   Tue, 15 Jun 2021 15:02:51 +0900
In-Reply-To: <87h7i21a43.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Sun, 13 Jun 2021 09:17:21 +0200")
Message-ID: <xmqqzgvrvf5g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 52584880-CD9F-11EB-ACDB-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Or, if we just fix these existing occurrences as a one-off there'll be
> no existing examples of it in-tree, and as people tend to imitate
> existing documentation they're unlikely to introduce new
> occurrences.

I suspect that may be a bit too optimistic.  It is too easy to
discuss interaction among users and introduce pronouns to refer to
them, and when it happens, it is far easier to have a document to
point at and tell them why we want them to rephrase if not how
exactly.  For that reason, I'd prefer to have some word about the
desire to make examples and explanations gender-neutral in the
guidelines.  The mechanics we recommend to achieve the goal does not
have to be specified if we want brevity---that can be learned by
imitating existing practices.

> If and when Felipe's <20210611202819.47077-1-felipe.contreras@gmail.com=
>
> is applied how small is the diff you'll still have rebased on top of
> that?

I just retried a "competing" merge that got ugly ;-)

Between Derrick's two "singular they" patches (one for comments, the
other for docs) and Felipe's two patches (the same split), they
touch identical base text.  Only the way they neuter the description
is different, and to me the latter feels a bit more ESL friendly.

So, the main things that are missing from Felipe's version that we
may want to build on top before the whole discussion can be
concluded are:

 - Derrick's "typofix" patch, but if I recall correctly it needed a
   fix-up in one of its hunks?

 - Guidelines; you had a more generic readability tips that would
   (incidentally) result in nudging the writers to be more gender
   neutral, which I think is going in the right direction, but I do
   prefer to see an explicit mention of gender-neutrality as one
   bullet item.

Thanks.
