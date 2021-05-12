Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE98C433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 14:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D21B6100A
	for <git@archiver.kernel.org>; Wed, 12 May 2021 14:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbhELOhO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 10:37:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61589 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbhELOhN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 10:37:13 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 389C1CA0C8;
        Wed, 12 May 2021 10:36:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=9mMHj/ML8JcJBudwz3m9Tm9R8I/XTxJMbZuqaDtcdOg=; b=gzIf
        JWHHT6fOToNXx2nEdrunF1ekzq4LdnfWi+Ri1R+D0Bi+cuW5aKybXSAkc4JqttC0
        L+HA/Vfl9GInkvqD/pdVc6OYnY8QdG1sL0SWaQOSqShAMZ0R5XtNZ+3OCvosNge4
        lC67e8Rsi2QsEiws62P1uQJYHwh4iYgo/V14mJU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 219EACA0C7;
        Wed, 12 May 2021 10:36:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DE406CA0C6;
        Wed, 12 May 2021 10:36:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Dave Huseby <dwh@linuxprogrammer.org>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        stefanmoch@mail.de
Subject: Re: [PATCH v2] Writing down mail list etiquette.
References: <20210512025447.6068-1-dwh@linuxprogrammer.org>
        <20210512031821.6498-1-dwh@linuxprogrammer.org>
        <20210512031821.6498-2-dwh@linuxprogrammer.org>
        <80e0215a-cd00-57f9-afb6-b85b33dba91d@gmail.com>
        <609b797a818bb_6d897208ce@natae.notmuch>
        <CAPig+cQvnsRe0fdPaBe9hJ4LbPFmHmGVNdiGYLqi2JM7A5GmjA@mail.gmail.com>
Date:   Wed, 12 May 2021 23:36:02 +0900
Message-ID: <xmqqbl9gf299.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 61444752-B32F-11EB-AB20-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> This has been my experience, as well. I've never sent a v6 with Junio
> as an explicit recipient, but which was otherwise identical to v5.

It mostly is because I've been too helpful than the written rule to
proactively pick up v5, before the participants of the discussion
explicitly reaches concensus that it is good enough.

In an ideal world, patches in areas that I do not have particular
interest in and that other reviewers with good taste are performing
good reviews, I should be able to keep myself completely out of the
picture, not involved in their review discussion in any way, and not
even having to monitor if the discussion reached some concensus, and
purely play a patch-monkey for such patches.  That, combined with
more reviewers with good tastes, would allow us to injest patches at
faster rate than we currently can.

> Another reason to avoid sending v6 which is identical to v5 is that it
> potentially wastes reviewer bandwidth.

As long as it is marked as "this is the final version that is
identical to the previous round, only difference from which is that
the collected reviewed-by and acked-by have been added", it would
not waste reviewer bandwidth.  The reviewers _should_ however notice
if it has questionable changes since the "previous round", in which
case their reviewed-by's may now be invalid, of course, though.

> The advice which seems to have triggered this particular discussion
> comes from Documentation/SubmittingPatches:
>
>     After the list reached a consensus that it is a good idea to
>     apply the patch, re-send it with "To:" set to the
>     maintainer{current-maintainer} and "cc:" the list{git-ml} for
>     inclusion.  This is especially relevant when the maintainer did
>     not heavily participate in the discussion and instead left the
>     review to trusted others.
>
> It's not the first time this advice has resulted in confusion. Perhaps
> now would a good time to retire it altogether, or at least rewrite it
> to mention the points you gave above about responding to "What's
> Cooking" or by sending a "ping" to the original patch email (which may
> result in Junio either picking up the patch or responding with an
> explanation as to why he didn't).

No, please do not put _more_ tasks on my plate.

The "send the final with everybody's concensus" is an ideal that
tries to reduce the maintainer bottleneck by distributing the work
of final validation.  I've been too helpful in this area in that I
have often been the one who does the "ping" ("What is the status of
this topic?"), but that would _not_ scale.  Anything that the party
with more numbers, namely the contributors, can do, we should farm
it out to them.

> Following the above SubmittingPatches paragraph is another which also
> seems to mislead people frequently:
>
>     Do not forget to add trailers such as `Acked-by:`, `Reviewed-by:`
>     and `Tested-by:` lines as necessary to credit people who helped
>     your patch, and "cc:" them when sending such a final version for
>     inclusion.
>
> In fact, a submitter should almost never add a Reviewed-by: trailer
> because Reviewed-by: is explicitly given by a reviewer only when the
> reviewer is satisfied that the patch is merge-ready, in which case no
> more re-rolls are expected.

Yes, that is exactly why v6 that is identical to v5 that all
reviewers are happy with is useful.  It should be able to carry
reviewed-by's and acked-by's, reviewers can audit that there is no
forged or otherwise inappropriate reviewed-by's, without placing any
extra burden on the maintainer.

Thanks.
