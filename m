Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A8681FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 17:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933325AbdCXR5c (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 13:57:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64832 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932626AbdCXR5a (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 13:57:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 34D03752B4;
        Fri, 24 Mar 2017 13:57:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ZquiED5oiapJ
        t1Mf1ydeYSvOYsc=; b=GB2HhpOf0NQAPjZOzUNMomjeVKNbFulFGQdsWHdQugLc
        W3bM52rIauUfLhb4monagMK/lnUNZm1E3R0i5ObrYYaLT4zOsA0KN16OSseQcIZ7
        zcTZUEM0m3CBKHMu7zHHWeqh4ti3sNP5m3SchO9HgRdJlQ5BSEfBcg7zoS0tQ/w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=yiCgdq
        P5dwAqfq4AkiKKot5RmmnKt4AwCTJCjsy4m7R9gVN7M1htvlz2zwu/s+Z185xsQ3
        MklyKnSR3bOQB7GjJhA899L4E0Kx7vcvT+agZT6T6J7LJS5SGM0Sg0ZSI3GjiqCN
        10lweOKUIo+WXkeFlWB1wbzglnuYyUfKh9CtI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C443752B3;
        Fri, 24 Mar 2017 13:57:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 81E11752B1;
        Fri, 24 Mar 2017 13:57:28 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jean-Noel Avila <jn.avila@free.fr>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] l10n: Add git-add.txt to localized man pages
References: <20170312200248.3610-1-jn.avila@free.fr>
        <20170320210225.13046-1-jn.avila@free.fr>
        <20170320210225.13046-3-jn.avila@free.fr>
        <xmqqpohbtxi3.fsf@gitster.mtv.corp.google.com>
        <CACBZZX51BskROyC_Kp=-PHuqzJ4uaDpu277R0Y4qCvz=6vLUiA@mail.gmail.com>
Date:   Fri, 24 Mar 2017 10:57:27 -0700
In-Reply-To: <CACBZZX51BskROyC_Kp=-PHuqzJ4uaDpu277R0Y4qCvz=6vLUiA@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 24 Mar
 2017 16:58:14
        +0100")
Message-ID: <xmqqziga7e2g.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 585C2832-10BB-11E7-8864-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Mon, Mar 20, 2017 at 11:05 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> But more importantly, aren't we essentially adding an equivalent of
>>
>>         cd Documentation && cat git-*.txt
>>
>> to our codebase?
>>
>> Surely we cannot avoid having a copy of all messages that are to be
>> translated using msgid/msgstr based approach, and we already do so
>> for end-user-facing in-program strings, but it just feels a bit too
>> much having to carry a duplicate (and slightly a stale) copy of the
>> entire documentation set around.  For N languages, we'll have an
>> equivalent for N copies of the English text, in addition to the
>> translated documentation.
>
> As someone reading this thread from the sidelines you never elaborate
> on why this is a problem worth solving (other than "a bit too much")
> before everyone downthread jumped on trying to figure out how to solve
> this out-of tree somehow.

I do not particularly see the size as an issue that must be solved;
to me, it is "nice to solve".

But going back and finding this from Jean-Noel in an earlier
message:

    ... This is one of the points raised in the first RFC mail. Splitting=
 this
    part would help a lot manage the translations with their own workflow=
,
    would not clutter the main repo with files not really needed for
    packaging and would simplify dealing with the interaction with crowd
    translation websites which can directly push translation content to a
    git repo.

there may be other benefits we may be able to reap from such a
split.
