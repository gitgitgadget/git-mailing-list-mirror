Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59494C433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 21:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239208AbiDMVS3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 17:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239049AbiDMVSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 17:18:16 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5416C888F7
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 14:13:35 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 107C71767AB;
        Wed, 13 Apr 2022 17:13:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/fz9rxg/ouImROu9JLXXo2ZmNIsovhZHxvEb1+
        SYrp8=; b=gSN4LoP0eVY+BfLYTFRL6Wo3NDtYqDm/HQ28w8L9pyEDNxZcDXgG9M
        V7rRpJ78QArgOAuUjngOnEgbNhIXy8tu90GTqinjTZdSvXf03xE0IRRrxFFgzhQY
        E9T/HzOR2+/5oQh7xFhp4btGBxCIT+1kF9ZXWp13Dajx7r3dK5hEs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 092B21767A9;
        Wed, 13 Apr 2022 17:13:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6206F1767A8;
        Wed, 13 Apr 2022 17:13:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Documentation/RelNotes: fix a typo in 2.36's relnotes
References: <d23e51b8dc78651dbd751473c0f8b3dcd6bc3ac6.1649883760.git.me@ttaylorr.com>
Date:   Wed, 13 Apr 2022 14:13:31 -0700
In-Reply-To: <d23e51b8dc78651dbd751473c0f8b3dcd6bc3ac6.1649883760.git.me@ttaylorr.com>
        (Taylor Blau's message of "Wed, 13 Apr 2022 17:03:28 -0400")
Message-ID: <xmqqczhk7klg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 92BAE12C-BB6E-11EC-8646-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
> Noticed while reading the RelNotes for GitHub's release highlights blog
> post.

Thanks as always for highlighting more interesting bits from the
flat-and-bland-list-of-changes which is what I prepare as the
release notes.

> - * A not-so-common mistake is to write a script to feed "git bisect
> + * A not-so-uncommon mistake is to write a script to feed "git bisect
>     run" without making it executable, in which case all tests will

I actually meant that this is "not a common mistake that deserves our
bandwidth but because a change was already made to help such a case,
why not take it".

We can probably rewrite _without_ mentioning our expectation of how
common it would be.

    A user can forget to make a script file executable before giving
    it to "git bisect run".  In such a case, all tests will exit ...
