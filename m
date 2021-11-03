Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968DAC433F5
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 23:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BAC861076
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 23:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhKCXbA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 19:31:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62514 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhKCXa7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 19:30:59 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 68294E634C;
        Wed,  3 Nov 2021 19:28:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4rV5okGbFNln71j1rXzJ/Lp/bILYOgzveeiW5w
        NMSMw=; b=GBGZVEcfzCE/YVH7+i+QTAiFI6GOZWsHkC8X0/NYwGyY+Q+85e3lNh
        lkPEXsyAKjRKY2rZqoRt1x4DVMVMo2j1yJ/qXp8/XYJbetrjuIIFA4p1FEizS/yR
        V+MKUb6NxHvqst1a1V6h7dZgRTJkeWUOEyzlJtSeXOSdfKbPBNOJs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 60F7AE634B;
        Wed,  3 Nov 2021 19:28:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CC998E6348;
        Wed,  3 Nov 2021 19:28:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: Breakage in dockerized(pedantic, fedora); Fix in the works
References: <nycvar.QRO.7.76.6.2111040007170.56@tvgsbejvaqbjf.bet>
Date:   Wed, 03 Nov 2021 16:28:20 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2111040007170.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 4 Nov 2021 00:17:46 +0100 (CET)")
Message-ID: <xmqqo8704y5n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BBE72564-3CFD-11EC-990A-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> some of you might have noticed that the `dockerized(pedantic, fedora)` job
> started to fail, see e.g.
> https://github.com/git/git/runs/4098188917?check_suite_focus=true#step:5:232
>
> This also happened during the Git for Windows rebase onto -rc1 that
> Victoria Dye prepared, and together we investigated the problem. Victoria
> will send a fix later. (I'm saying this just in case anybody wondered
> whether they should investigate this breakage.)

Thanks for a quick action.  Very much appreciated.
