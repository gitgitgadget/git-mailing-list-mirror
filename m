Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6CAE92FC9
	for <git@archiver.kernel.org>; Thu,  5 Oct 2023 22:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjJEWmg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Oct 2023 18:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbjJEWme (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2023 18:42:34 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2823DB
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 15:42:33 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C291D1AEBC5;
        Thu,  5 Oct 2023 18:42:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=pI8MdTVG+TDndhI4F28d4/aZVnMmtmOOC8cRcy
        /B9j8=; b=G5A53RQIBSzhzqly8j1ZQiZTo9RoJsWjG80WesAElcpWHjAf64Gnz+
        V42QbGybks+xFrmbtrBN0xThP4hE8b4lMj8rA1ALPpdoTGIkzY3eBv5uWDiFCHqC
        HgJkAD/yzletUfSKWKoDZZgF/HKA32Z5djR7xWN2lCm9YsOfFuZA0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B92BD1AEBC4;
        Thu,  5 Oct 2023 18:42:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 27F461AEBC3;
        Thu,  5 Oct 2023 18:42:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Naomi Ibe <naomi.ibeh69@gmail.com>
Subject: Re: How To Pick And Work On A Microproject
In-Reply-To: <CACS=G2z84_-WkWa-BnK8bNNqb9z_o37BC3-kb_NkrjzAL=r4Sg@mail.gmail.com>
        (Naomi Ibe's message of "Thu, 5 Oct 2023 23:14:50 +0100")
References: <CACS=G2z84_-WkWa-BnK8bNNqb9z_o37BC3-kb_NkrjzAL=r4Sg@mail.gmail.com>
Date:   Thu, 05 Oct 2023 15:42:30 -0700
Message-ID: <xmqq7co0elnt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 788B0E74-63D0-11EE-A787-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Naomi Ibe <naomi.ibeh69@gmail.com> writes:

> "Select a microproject and check that it has not yet been taken or
> discussed by searching the mailing list. Public Inbox is your friend."

Yeah, that is VERY unfriendly.  There is no mention on the pool of
microproject ideas from which you can "select" here.  I wonder if
some HTML link is missing in the sentence (i.e., clicking a word
leading to a page that lists what you can select from), or it has
always been like this.

Later in the same document, I see

    How to find other ideas for microprojects

    First check the specific page(s) or information about Git
    microprojects related to your program that should have been
    published on this site or on the GSoC or Outreachy site. But then
    still read on everything below!

which is much more realistic, as long as the "specific page(s)" are
well curated (which I have no idea myself, as I have never been in
the mentoring pool).  Naomi, have you checked and found such a page
on Outreachy site?

Then it goes on to suggest finding a bug report, but I tend to think
that fixing them is way oversized to be a good microproject.


And finally it gives a casual mention of good+first+issue, which is
probably the closest to what _should_ be listed as the first place
to try (sorry, I however do not know how well the list is curated,
either, but from a cursory look it looks legit).

https://github.com/gitgitgadget/git/issues?q=is%3Aissue+is%3Aopen+label%3A%22good+first+issue%22

There also is a mention of #leftoverbits in the document, but by its
nature, they can easily become stale or irrelevant, and they tend to
be more real issues, and I would expect them to be unnecessarily
harder than what dip-your-toe-in-the-water-and-say-hello
microprojects need to be.
