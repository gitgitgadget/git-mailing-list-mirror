Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC0CC48BE5
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 02:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88E1561246
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 02:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbhFPCtP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 22:49:15 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56614 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbhFPCtO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 22:49:14 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 554C412F210;
        Tue, 15 Jun 2021 22:47:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=sDGjSzol4kMC
        r0hlxSRB2yrz/r7ha5jYsrAnSqEXTQg=; b=f2y3QxnjR0Y3vOjtfDnK4d6fwfvJ
        5thx+qhiyhHKSXwlUqeQPAix0K7jlCmcxteDqA7gV7weLNPd7/F/cXZlVXKZHB0k
        67oslT2+gOR2kCcNndbhEYa5gplRSfEmEF4rIdHp5vCd2827LMN2Gnxxy04toR6v
        ooHCLSyj1GU3tyY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4CCE212F20F;
        Tue, 15 Jun 2021 22:47:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B8CBC12F20E;
        Tue, 15 Jun 2021 22:47:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sandals@crustytoothpaste.net,
        stolee@gmail.com, jrnieder@gmail.com, emilyshaffer@google.com,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Jeff King <peff@peff.net>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        Phillip Susi <phill@thesusis.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 4/4] CodingGuidelines: recommend singular they
References: <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
        <pull.975.v3.git.1623766273.gitgitgadget@gmail.com>
        <f06092a9053e40d93c4ec94b7fbbb1b8d563957b.1623766273.git.gitgitgadget@gmail.com>
        <87a6nryt51.fsf@evledraar.gmail.com>
Date:   Wed, 16 Jun 2021 11:47:05 +0900
In-Reply-To: <87a6nryt51.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 15 Jun 2021 18:19:53 +0200")
Message-ID: <xmqqsg1iseza.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 23778446-CE4D-11EB-A2C2-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Tue, Jun 15 2021, Derrick Stolee via GitGitGadget wrote:
> ...
>> + In order to ensure the documentation is inclusive, avoid assuming
>> + that an unspecified example person is male or female, and think
>> + twice before using "he", "him", "she", or "her".  Here are some
>> + tips to avoid use of gendered pronouns:
>> +
>> +  - Removing the example person might make the sentence more
>> +    clear and efficient.  Instead of saying "The programmer
>> +    chooses between X and Y as she sees fit", it is clearer to
>> +    say "Valid choices are X and Y".
>> +
>> +  - If you need to talk about an example person, then try using
>> +    second-person to allow the reader to be that example.  For
>> +    example, "If you want X to happen, you'd pass option Y",
>> +    instead of "If the user wants X to happen, she'd ...").
>> +    Alternatively, replace the single example with more than one
>> +    person and use plural "they", such as "Interested readers
>> +    can read 'git log -p README' to learn the history in their
>> +    ample spare time" instead of "an interested reader" learning
>> +    in "his" spare time).
>> +
>> +  - If you absolutely need to refer to an example person that is
>> +    third-person singluar, you may resort to "singular they" (e.g.

"singular".

By the way, I do not mind toning down "if you absolutely need to
... resort to" that discourages "singular they".  I just wanted
writers to consider that the language evolves slowly, and if they
think "singular they" is the best vehicle to phrase what they want
to say even after considering that it may sound distracting to
foreigners, I would not stop them.

> To be fair he does go on to say something that suggests to also go for =
a
> version of your approach here, i.e. that we still have some reference t=
o
> "they" over "he" and "she". I've got no problem with that, but he also
> said (comments in [] are mine):
>    =20
>     If we were to go that route [(of copying Junio's version from [3])]=
,
>     I think the first two points [(i.e. the first two bullet-points you
>     incorporated above)] (which I didn't give enough thought to be even
>     called a "draft") should be replaced with something like what =C3=86=
var
>     wrote in his write-up.

FWIW, I am not happy with this version for that reason, either.

I wonder if replacing the first two bullet points ("Removing" and
"If you need to talk about") above with what was added to the
CodingGuidelines by the "succinct matter-of-factly description" in

https://lore.kernel.org/git/87a6nz2fda.fsf@evledraar.gmail.com/

would be sufficient.

Thanks.
