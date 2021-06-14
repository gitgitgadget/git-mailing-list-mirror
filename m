Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA503C48BE8
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 00:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D1536134F
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 00:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbhFNAtx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 20:49:53 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64497 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbhFNAtw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 20:49:52 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7C9DD132867;
        Sun, 13 Jun 2021 20:47:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=AFYfpu97vZtF
        8D4mOTI3x/DPbc/5vCyu8ylkPjaCctA=; b=O98L3mfe32Xs54+SpPwAGZ6QUIMW
        PagxKU9ujNIvzOrzziGQGF7Pqz0WkLBu4zkMVSJOUa1/vhKyD04LIijW1aai3cPA
        waNle9JhN7zFyYEXEZ8JosjnyDKB6zUniMWw5yftWZTggcTPIVcm13hIpo7Tp1ws
        DszpZpe3joYxpoQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6A7D0132866;
        Sun, 13 Jun 2021 20:47:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 95C8D132865;
        Sun, 13 Jun 2021 20:47:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
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
Date:   Mon, 14 Jun 2021 09:47:45 +0900
In-Reply-To: <f4488360-bdaf-3e97-69c5-00087f797117@gmail.com> (Derrick
        Stolee's message of "Fri, 11 Jun 2021 13:18:06 -0400")
Message-ID: <xmqqr1h51dce.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 23754A5E-CCAA-11EB-86C8-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> My general approach (as specified in this v2) is:
>
> 1. Use singular "they" over "he" or "she" and other variants.
> 2. If you don't want to write "they", then avoid third-person
>    singular pronouns.
>
> Your approach focuses only on item 2, giving this recommendation:
>
> * Avoid third-person singular pronouns.
>
> I think your change to CodingGuidelines is a bit verbose to get to
> that point, and makes it difficult to understand one goal is to
> avoid gendered pronouns, which I think reduces the chance that a
> new contributor would discover and understand that recommendation.

Is it fair to say that a concise summary of this discussion so far
is:

 - Avoiding gendered pronous is a good way to ensure inclusive
   documentation.

 - Our documentation does not have too many instances of "gendered
   pronouns" issue, and all of them can be corrected without
   resorting to singular "they" (to which those who learned in some
   parts of the world may not be ready yet), and it results in more
   concise and clearer description anyway.

I tend to agree that =C3=86var's approach to guidelines is to cover more
general readability tips, not necessarily focusing on avoidance of
gendered pronouns, let alone encouraging of "singular they".  I
think that is overall a good approach to advance the "let's make
sure the document is easier to read by everybody" goal than
mechanical "he and she are bad, let's use they" does.  One thing
that the "let's use they" approach does better is that it brings the
"gender neutral" concern upfront, exactly because "let's make sure
the document is easier to read by everybody" is a superset and does
not have to bother singling out the "gender" as an issue.

It may be easier to move the discussion forward if we (half)
separated the concerns.

Because the "gender neutral" is so out of place relative to the
existing guidelines that focus on ensuring consistency that appear
in the "Writing Documentation" section, it is hard to make it into a
single bullet item among many others.  Perhaps we want to have a new
paragraph between "mixes US and UK English" and "Every user-visible
change" paragraphs.

    In order to ensure the documentation appears to be inclusive,
    avoid assuming that an unspecified "cast" who appears in
    description and examples is male or female, and think twice
    after writing "he", "him", "she", or "her".  Here are some tips
    to avoid use of gendered pronouns:

    - Rethink if your example or description needs to talk about a
      human "cast" in the first place.  Do you need to say "The
      programmer chooses between X and Y as she sees fit", or is it
      sufficient to say "Valid choices are X and Y" to make the
      resulting sentence more concise and clear?

    - If you need to talk about human "cast", think if the role the
      cast plays can be second person (e.g. "If you want X to
      happen, you'd pass option Y", instead of "If the user wants X
      to happen, she'd ..."), or can be more than one person
      (e.g. "Interested readers can read 'git log -p README' to
      learn the history in their ample spare time" instead of "an
      interested reader" learning in "his" spare time).

    - If you absolutely need to talk about a human "cast" that is
      third-person singluar, you may resort to "singular they" (e.g.
      "A contributor asks their upstream to pull from them").  Note
      however that this sounds ungrammatical and unnatural to those
      who learned English as a second language in some parts of the
      world.

If we were to go that route, I think the first two points (which I
didn't give enough thought to be even called a "draft") should be
replaced with something like what =C3=86var wrote in his write-up.  Also,
I do not mind losing "Note however" from the third point, but in the
name of inclusive documentation, it may not be a bad idea to remind
ourselves.


