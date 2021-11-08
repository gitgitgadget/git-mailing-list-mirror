Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED25EC433F5
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 19:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C38D36162E
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 19:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236796AbhKHTTR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 14:19:17 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57438 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236660AbhKHTTQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 14:19:16 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 760F4EDE2D;
        Mon,  8 Nov 2021 14:16:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=n59cIpYhtKB4UDKDlc6fD3bQImtRAHeifUiyem
        8yC08=; b=sm32I6An1edZZj+jYTIBZY0VBp8/X0GtSkbkvDg2sCCkRFTMFg6ip+
        Vc4fs5e1kfc5YlECRR5pJfy6vVEVW6cmOTVacvFeyQC9wns1YnfrR9Kdoyt5/fYe
        0ufCBWc0M9kUJkQtqeRZlXptXBlC0HQhyKmUvhaysXDgS2uF8WWdk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E756EDE2C;
        Mon,  8 Nov 2021 14:16:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CEE3CEDE2A;
        Mon,  8 Nov 2021 14:16:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: move some test-tools to 'unstable plumbing' built-ins
References: <YYTy6+DG5guzJIO7@coredump.intra.peff.net>
        <xmqq35oaxwnz.fsf@gitster.g> <YYWBz6rjF+I+JkO3@nand.local>
        <211106.86fss9hq3f.gmgdl@evledraar.gmail.com>
        <YYgHhaOAsv7pVAMi@nand.local>
Date:   Mon, 08 Nov 2021 11:16:29 -0800
In-Reply-To: <YYgHhaOAsv7pVAMi@nand.local> (Taylor Blau's message of "Sun, 7
        Nov 2021 12:06:13 -0500")
Message-ID: <xmqq7ddiv4oi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 611E1894-40C8-11EC-A8CB-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> In my experience I *rarely* rely on test-helpers when debugging wedged
> repositories, and much more often end up either in gdb, or in an
> anonymized copy of the repository on a different server. I would imagine
> that others have similar experiences.
>
> So unless we had a much more compelling reason to have the test helpers
> more readily available, I do not think that the risk our users will
> begin to depend on these unstable tools is worth taking.

OK.  It sounds like a sensible argument against such a change.

Thanks.
