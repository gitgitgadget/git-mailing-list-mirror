Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0181AC48BDF
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 01:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C93D56134F
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 01:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbhFNBNZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 21:13:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58338 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbhFNBNY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 21:13:24 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 64A78BD017;
        Sun, 13 Jun 2021 21:11:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=t2dwLhZB04v6wpBpQg4rXr+qCR+WxXHXMsTQRC
        gEF+M=; b=EXyxKx4IZaTbYCdGapeFzMIWzJ8Uj9y+VCIVm02bGHoUTGoH0vShmL
        N43eN/mJqHHGrNZFeSNijA6Yq60oiWl6m2e9C8t3vnrHqT9KxS126f3s7kLjp6IB
        Cn4JCHN8QvX85uVOVUg5hhNMN8LMKwJHAVbQ/agx/dTyrbmnw8ua8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5ABE5BD016;
        Sun, 13 Jun 2021 21:11:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D7307BD015;
        Sun, 13 Jun 2021 21:11:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org, felipe.contreras@gmail.com
Subject: Re: [PATCH v3] *: fix typos which duplicate a word
References: <20210609102641.3531183-1-rybak.a.v@gmail.com>
        <20210611111850.3430523-1-rybak.a.v@gmail.com>
Date:   Mon, 14 Jun 2021 10:11:19 +0900
In-Reply-To: <20210611111850.3430523-1-rybak.a.v@gmail.com> (Andrei Rybak's
        message of "Fri, 11 Jun 2021 13:18:50 +0200")
Message-ID: <xmqqfsxl1c94.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6D3B985C-CCAD-11EB-9CF1-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrei Rybak <rybak.a.v@gmail.com> writes:

> Fix typos in documentation, code comments, and RelNotes which repeat
> various words.  In trivial cases, just delete the duplicated word and
> rewrap text, if needed.  Reword the affected sentence in
> Documentation/RelNotes/1.8.4.txt for it to make sense.

Thanks.  I usually avoid touching published release notes (it is not
like we'd issue 1.8.4.1 maintenance release to apply this typofix),
but as you spent time to fix them all, and as we spent time to review
the changes, let's take all of them.

>   * Invocations of "git checkout" used internally by "git rebase" were
> -   counted as "checkout", and affected later "git checkout -" to the
> +   counted as "checkout", and affected later "git checkout -" which took
>     the user to an unexpected place.
>     (merge 3bed291 rr/rebase-checkout-reflog later to maint).

I think this one actually wanted to say "affected later X to take
the user to an unexpected place", but ", which" is OK, too.

Thanks.
