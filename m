Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15262E94100
	for <git@archiver.kernel.org>; Fri,  6 Oct 2023 19:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbjJFTD0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Oct 2023 15:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbjJFTDZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2023 15:03:25 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460A895
        for <git@vger.kernel.org>; Fri,  6 Oct 2023 12:03:24 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 93CD41AEF4C;
        Fri,  6 Oct 2023 15:03:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=eNEUYQrtiw2t
        JrcUK+arjwPb1l46PFuOjhIBdU5pLdA=; b=dTpEKC8XTqn6RqwMZ2eovidd9ENP
        FjxocIhYlWi88/aGtvfZi9z3BVIJbnDkA+RdjwFyJaIEpQnBidl+dir1yP4HCpFs
        KmJ7niz17gkRrIogX6Z1f26qADGdV/P0dpURgSxIAia0SBA3VA2W3uVP5Nuiycb0
        c/8oOc0fTrv2KBs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8A5E91AEF4B;
        Fri,  6 Oct 2023 15:03:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F19AC1AEF4A;
        Fri,  6 Oct 2023 15:03:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Naomi Ibe <naomi.ibeh69@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: How To Pick And Work On A Microproject
In-Reply-To: <CAP8UFD1cd5YZqAxYbYUMNkAYJLLGjBpNe_NK5nVq3eLxxSDzEQ@mail.gmail.com>
        (Christian Couder's message of "Fri, 6 Oct 2023 11:02:01 +0200")
References: <CACS=G2z84_-WkWa-BnK8bNNqb9z_o37BC3-kb_NkrjzAL=r4Sg@mail.gmail.com>
        <xmqq7co0elnt.fsf@gitster.g>
        <CAP8UFD1cd5YZqAxYbYUMNkAYJLLGjBpNe_NK5nVq3eLxxSDzEQ@mail.gmail.com>
Date:   Fri, 06 Oct 2023 12:03:21 -0700
Message-ID: <xmqq1qe7a806.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 05706C58-647B-11EE-82D3-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> I am not sure how others feel about this, but I think it would be
> better in the future to not have to prepare such pages, and to just
> have a section with a number of examples of good microprojects on this
> https://git.github.io/General-Microproject-Information/ page. It will
> be easier to update this section when we know about other good ideas
> or better ideas, or when we want to remove an idea that we don't
> consider good anymore, or just update an idea.

If we have curated one-stop shop for microproject candidates to make
it easy to find them, it would be a vast improvement over the status
quo.  The easier for us to update the contents of the list, the
better for participants.  Having only one place that we need to look
at is one way to do so, and the general microproject information
page would be the best place to host it.  I like it.

>> Then it goes on to suggest finding a bug report, but I tend to think
>> that fixing them is way oversized to be a good microproject.
>
> I agree that it's oversized for most bugs. I have just added the
> following paragraph at the end of this "Searching for bug reports"
> subsection:
>
> "Also some bugs are difficult to understand and require too much or
> too difficult work for a microproject, so don=E2=80=99t spend too much =
time on
> them if it appears that they might not be simple to fix, and don=E2=80=99=
t
> hesitate to ask on the mailing list if they are a good microproject."

Would that be better, or would it be simpler to gut the whole
paragraph about bug reports?  This is "how to pick a microproject",
not "how to pick your main project to work on during your mentoring
program".

Unlike #leftoverbits that sometimes cover trivial but boring style
normalization and easy refactoring of code into helper functions, I
have never seen a bug report on the list that may make a good
microproject.  If we were to add a curated list of microproject idea
on the general microproject information page, it probably is better
to remove these mentions of bugreports and #leftoverbits, so that
readers will not get distracted.  "Don't hesitate to ask" so that
they may try to tackle more challenging one, if they wish, is a good
thing to say nevertheless.

Thanks.
