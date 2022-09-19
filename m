Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF80ECAAD3
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 17:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiISRPX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 13:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbiISRPT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 13:15:19 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F287310540
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 10:15:13 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 258321BEE6C;
        Mon, 19 Sep 2022 13:15:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=k0opy7V7i2DOtt7FqfFcSXcT0yEtmmkcOySR6+
        sdmQ4=; b=ZCJCOdTyF6No0NE+2vNhREZzwXFIySOZ1fALDocw+4FVLJ9ytG6jr9
        A2BzufOEN5e7r+vWopR/UiHiAoOCYAlx1tcs8RqtmWlkFMq4KBRM/bpB67Aayv4z
        QPFjHxX8ilbJ3+72OFnAo8NK2kuXJGBrBZTPWmPWPTnDTNXhm6F0A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1E7681BEE6B;
        Mon, 19 Sep 2022 13:15:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A51351BEE68;
        Mon, 19 Sep 2022 13:15:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Force Charlie via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Force Charlie <charlieio@outlook.com>
Subject: Re: [PATCH] unicode: update the width tables to Unicode 15
References: <pull.1333.git.git.1663388320380.gitgitgadget@gmail.com>
Date:   Mon, 19 Sep 2022 10:15:07 -0700
In-Reply-To: <pull.1333.git.git.1663388320380.gitgitgadget@gmail.com> (Force
        Charlie via GitGitGadget's message of "Sat, 17 Sep 2022 04:18:40
        +0000")
Message-ID: <xmqqo7vbb810.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9CBA0F7A-383E-11ED-8FF2-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Force Charlie via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Force Charlie <charlieio@outlook.com>
>
> Unicode 15 Released[0] and including several additional zero/double
> width characters.
>
> [0] https://home.unicode.org/announcing-the-unicode-standard-version-15-0/
>
> Signed-off-by: Force Charlie <charlieio@outlook.com>
> ---
>     unicode: update the width tables to Unicode 15
>     
>     Unicode 15 Released[0] and including several additional zero/double
>     width characters.
>     
>     [0]
>     https://home.unicode.org/announcing-the-unicode-standard-version-15-0/

Thanks.

Where are you getting the information to update these ranges from,
among 4489 new characters?  Is there a readily accessible URL that
is more suitable than the announcement of the whole collection?
