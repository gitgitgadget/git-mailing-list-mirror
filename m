Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78202C71153
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 18:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbjH1SZR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 14:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjH1SY6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 14:24:58 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A656C13D
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 11:24:55 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 405F13017D;
        Mon, 28 Aug 2023 14:24:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=1fdrKKLZA1WmO4QxxjIOioGmUwDuKfBZ1xeU2i6zT0o=; b=YUIw
        uitAEzpN+pdUf1/hbeFsEI8wnaB9OlJRLw+12pGgFvWKZqY/52YPwY6PKCcn8QZX
        U+WQ67z70Ex3XxZYI9b72bBSPaGAPTTNK26QrzO8dWmJP3UGy+9JYm1HOPI6fz2C
        MTw1qshnFyylrhRb/Y2GPE2TNP1hspb98PQTS4o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 395BC3017C;
        Mon, 28 Aug 2023 14:24:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C79A53017B;
        Mon, 28 Aug 2023 14:24:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Teng Long <dyroneteng@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 1/3] leak tests: mark a handful of tests as leak-free
References: <cover.1692902414.git.me@ttaylorr.com>
        <b1711c4c817f95011bc477a9485c115b4926c7da.1692902414.git.me@ttaylorr.com>
        <20230824210238.GA940724@coredump.intra.peff.net>
        <ZOj7XqRSmIFxaI3P@nand.local>
        <20230825203819.GC2382334@coredump.intra.peff.net>
Date:   Mon, 28 Aug 2023 11:24:50 -0700
Message-ID: <xmqqttsjgh3h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2DC33290-45D0-11EE-AD18-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I do think we should apply the racy-thread log fix, though. I thought we
> had discussed it at the time, but there doesn't seem to be anything in
> the archive. And I was willing to let it go as a weird one-off at the
> time, but now that it wasted another 30 minutes of my life discovering
> the problem again, I'm in favor of applying it.
>
> Whether it happens as part of your re-rolled series, or is applied
> separately, I am OK either way. :)

Whether it comes from you or Taylor, I do favor to see it as a new
message at lore archive than having to fish an older message from it
;-)

Thanks.
