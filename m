Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F70920281
	for <e@80x24.org>; Mon,  6 Nov 2017 04:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750848AbdKFEe7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 23:34:59 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63201 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750766AbdKFEe5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Nov 2017 23:34:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 35A06B7EBB;
        Sun,  5 Nov 2017 23:34:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FbDkrP2ULNDbtgCcfa17W48rZvc=; b=KXZDD4
        +s/rH7HEhisFa/Ihc6RB7BjvRdH5wXjmUNlhYKKqOi5zOjn/Bx8aHv1xtjZCZoeY
        Qc/m6D9ylfH8ywONS2383CgqmJ5oCKdexCM3/fQTsBGq1C/tgwHu3/XPCNIDEW2l
        Q0ja90OJ4B6BayMpKZvKHflOQLB0+lYI4bWj8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=I4+fgs2/VHkhCUPcc8FGhPVbW00cG2zY
        dq4ZaiZAI/5xd1rGQFObvncYT4QmCjSqHUgPDnaYNzJVScc03dHpZSabyVZmbJwU
        zlyjATl/6xRfj6xZQb7uJTpPLN6GFQDcuo4wAMmWhzyLARZ0u7m4KGgDMp/U/lU0
        5RBwvUE1VTU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2D23CB7EBA;
        Sun,  5 Nov 2017 23:34:57 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A7E2CB7EB9;
        Sun,  5 Nov 2017 23:34:56 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ann T Ropea <bedhanger@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 3/3] Documentation: revisions: add note about 3dots usages as continuation indications
References: <20171105162730.31405-1-bedhanger@gmx.de>
        <20171105162730.31405-3-bedhanger@gmx.de>
Date:   Mon, 06 Nov 2017 13:34:55 +0900
In-Reply-To: <20171105162730.31405-3-bedhanger@gmx.de> (Ann T. Ropea's message
        of "Sun, 5 Nov 2017 17:27:30 +0100")
Message-ID: <xmqqk1z4hvo0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D7653180-C2AB-11E7-AEF6-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ann T Ropea <bedhanger@gmx.de> writes:

> Also, fix typo: "three dot" ---> "three-dot" (align with "two-dot").
>
> Signed-off-by: Ann T Ropea <bedhanger@gmx.de>
> ---
>  Documentation/revisions.txt | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
> index 61277469c874..d1b126427177 100644
> --- a/Documentation/revisions.txt
> +++ b/Documentation/revisions.txt
> @@ -271,7 +271,7 @@ The '..' (two-dot) Range Notation::
>   for commits that are reachable from r2 excluding those that are reachable
>   from r1 by '{caret}r1 r2' and it can be written as 'r1..r2'.
>  
> -The '...' (three dot) Symmetric Difference Notation::
> +The '...' (three-dot) Symmetric Difference Notation::
>   A similar notation 'r1\...r2' is called symmetric difference
>   of 'r1' and 'r2' and is defined as
>   'r1 r2 --not $(git merge-base --all r1 r2)'.
> @@ -285,6 +285,15 @@ is a shorthand for 'HEAD..origin' and asks "What did the origin do since
>  I forked from them?"  Note that '..' would mean 'HEAD..HEAD' which is an
>  empty range that is both reachable and unreachable from HEAD.
>  
> +However, there are instances where '<sha1>...' is *not*
> +equivalent to '<sha1>...HEAD'.  See the "RAW OUTPUT FORMAT"
> +section of linkgit:git-diff[1]: the three-dot notations used
> +there are simply continuation indications for the abbreviated
> +SHA-1 values.  The ones encountered there are usually
> +associated with file/index/tree contents rather than with commit
> +objects, and the range operators described above are only
> +applicable to commit objects (i.e., 'r1' and 'r2').
> +
>  Other <rev>{caret} Parent Shorthand Notations
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  Three other shorthands exist, particularly useful for merge commits,

I actually have a mild suspicion that this is going in a wrong
direction.  In very early days of Git, we wanted to make sure that
people can tell if a long hex string is a truncated object name or a
full one (mostly because some lower-level commands insisted to be
fed only full object name).

These days, everybody knows when they see 79ec0be62a that it is
*not* a full object name and will no longer be confused unlike early
days and there is no strong reason to waste six output columns of
"git diff --raw" output by using these three dots.  

I wonder if we can come up with a solution in line with the patch
1/3 in this series, which got rid of the "..." that indicated that
the hexstring was not a full object name.


