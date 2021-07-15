Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7234C636C8
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 18:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C174261360
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 18:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237171AbhGOSFS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 14:05:18 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63955 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236800AbhGOSFS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 14:05:18 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 83CF013B0C1;
        Thu, 15 Jul 2021 14:02:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vrsEqr3WwiwAafSH8QCN0UOASapa+sRsOgsNKw
        g23QI=; b=gJ8QWhUo12dGfhv3yeeh0zAmy8LxrMWduUGh7G4Yq8qOs2ggrHZh7X
        8qWJdOdObPs1DlVyE9PdEWy2XMpr8CP4CoJx7hiS4WR2era4RaGt0f+7I7rfwd2W
        WlVWZ5kvKbZPSuhL/ZJ2ojAhj5cdnK0sLY7InhWA1PDn0rrbXdqIY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7C7E713B0C0;
        Thu, 15 Jul 2021 14:02:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EF46213B0BF;
        Thu, 15 Jul 2021 14:02:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] CodingGuidelines: recommend gender-neutral description
References: <xmqqmtqpzosf.fsf@gitster.g>
        <2c7f188a-6ebe-b116-8299-86ca3732d79a@gmail.com>
        <87czrl0wob.fsf@evledraar.gmail.com> <xmqqk0lrtuh4.fsf_-_@gitster.g>
        <CAPig+cT24=jy65C1cQ4WarakJHKm4F8_78nDm=jWOnHxfhtcRw@mail.gmail.com>
        <YPBmv7x3zUbuQ2uy@nand.local>
Date:   Thu, 15 Jul 2021 11:02:20 -0700
In-Reply-To: <YPBmv7x3zUbuQ2uy@nand.local> (Taylor Blau's message of "Thu, 15
        Jul 2021 12:47:59 -0400")
Message-ID: <xmqq35sftpzn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CD77ABAA-E596-11EB-AD1B-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Thu, Jul 15, 2021 at 12:35:30PM -0400, Eric Sunshine wrote:
>> On Thu, Jul 15, 2021 at 12:25 PM Junio C Hamano <gitster@pobox.com> wrote:
>> > Technical writing seeks to convey information with minimal
>> > friction. One way that a reader can experience friction is if they
>> > encounter a description of "a user" that is later simplified using a
>> > gendered pronoun. If the reader does not consider that pronoun to
>> > apply to them, then they can experience cognitive dissonance that
>> > removes focus from the information.
>> >
>> > Give some basic tips to guide us avoid unnecessary of gendered
>> > description.
>>
>> Some words seem to be missing from this sentence.
>
> I assume that it's supposed to read "guide us [to] avoid unnecessary
> [uses] of gendered description".

Thanks.  Last-minute edit always screwes me up.

>> > +    Note that this sounds ungrammatical and unnatural to those who
>> > +    learned English as a second language in some parts of the world.
>>
>> It also sounds ungrammatical and unnatural to this native English speaker.
>
> Apologies if this suggestion has been made earlier in the thread, but
> this article
>
>     https://apastyle.apa.org/style-grammar-guidelines/grammar/singular-they
>
> document from the APA's style guide helps convince me that this is
> grammatical.

Yes, the language is living and drifting---and that is why it
matters when and where you learned ;-)
