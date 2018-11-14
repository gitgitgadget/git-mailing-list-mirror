Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38F301F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 05:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731118AbeKNPgS (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 10:36:18 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51678 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731103AbeKNPgS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 10:36:18 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C57B01914E;
        Wed, 14 Nov 2018 00:34:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=iEjdk8/gQqw5
        H3vDMMx+fJDspaQ=; b=mTKZWNEeHI3taVd2D8zGIfRLqDvAlIICKL4UJPAJCuRG
        ZXyivcPT2/rWGPQ2WRBoteSKe1+vvCCHbSiP3+oYyUILFwhiGI4FiLcNhvYpR+ZG
        +czHAwvqKIfjaKFZP/z3+hJMNrO6vsZ0iiEutExlqTd46vppidRhat3O5O1slwE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=dxk8I1
        lLLElkoDvzzDe/5E2LgLD07566SEIhonL5s1B0ikzTyl2gh80ozT7sT3nonk/ESD
        RNUDd9XkUXyysckyErlQZfApBt5jxndZZDfx24kagpH7ebPDDdlb3Jscs69zCPIs
        /L22l2z3nR9vp5sOJBVK7AdJyOcQS9LtHwb/c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BF3891914C;
        Wed, 14 Nov 2018 00:34:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D156B1914B;
        Wed, 14 Nov 2018 00:34:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2018, #04; Tue, 13)
References: <xmqq8t1xukw2.fsf@gitster-ct.c.googlers.com>
        <871s7o3im8.fsf@evledraar.gmail.com>
Date:   Wed, 14 Nov 2018 14:34:30 +0900
In-Reply-To: <871s7o3im8.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 13 Nov 2018 20:03:27 +0100")
Message-ID: <xmqqy39wnrx5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F70A2286-E7CE-11E8-9FF3-CC883AD79A78-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> * ab/dynamic-gettext-poison (2018-11-09) 2 commits
>>  - Makefile: ease dynamic-gettext-poison transition
>>  - i18n: make GETTEXT_POISON a runtime option
>>
>>  On hold.
>>  The tip one may be controversial, but at least it would get me going.
>>  cf. <xmqqpnvg8d5z.fsf@gitster-ct.c.googlers.com>
>
> So just to clarify the state of this. I sent a v4 with the patch you're
> referring to included,...

Clearly I failed to update the comments when I replaced the patch
(v3 plus SQUASH fix) with what is queued which is v4.  Thanks for
noticing.  I think this one is ready to move forward, if it is
deemed worth doing.

> I'm a bit surprised that people aren't excited about this whole "you
> don't need to recompile git just to run this one special test mode",

I actually do not think it is surprising at all.  Only a few people
care about i18n breakages so they are not daily running the poison
test in the first place.  I myself only "see" its result in Travis
not because I am particularly interested in the poison test, but
because I cannot selectively not seeing it when visiting the summary
page like https://travis-ci.org/git/git/builds/454503815 (I do look
at its log if it fails, though).

So a true improvement for most of the developers is to somehow make
it unnecessary to even worry about poison test.  How poison test is
done is secondary to them and I think that is why we see nobody is
enthused when the way it is run is improved.  Having to carry code
that is only used while running poison test in the production binary
is an annoyance, not an improvement, to them.

As I do not immediately see a way to satisfy the pie-in-the-sky wish
"the world would be a great place if it were impossible to introduce
a bug that marks plumbing messages with _() so that we did not even
have to do a poison test", I am neutral, not negative, on this topic.
I am also hoping that the dynamic-poisoning may allow us to do a
"readable but still poisoned" fake translation more easily than the
separate build method we have used so far, so that adds a slight
positive to the topic.

Thanks.
