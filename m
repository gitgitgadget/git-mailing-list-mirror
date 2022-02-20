Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBC8C433EF
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 02:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbiBTCo0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Feb 2022 21:44:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiBTCoZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Feb 2022 21:44:25 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B593D4B6
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 18:44:05 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 242D2172A43;
        Sat, 19 Feb 2022 21:44:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oLAtprox1Qo0R21vr/fF7gPCEYI+3FaE9V+Yhe
        2PGhk=; b=cs/bhN1MrFNfdhlAnkZWcDZwi/cSZEdhzh0hF2G1dSqpv3xQ1ow/NO
        NQkyfXJW06PmwecxSt9LzcmJeNbX2CzqmG5DzqUzC8KsvVuMLeNxzaR3SRC7qK+C
        pCID8LvZreMHNTmdDhByGT0/liZzCbZ6ejHrHtcfNNND3brlyRu1g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1D28A172A42;
        Sat, 19 Feb 2022 21:44:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8F0AD172A3F;
        Sat, 19 Feb 2022 21:44:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/9] ci: make Git's GitHub workflow output much more
 helpful
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.2202200043590.26495@tvgsbejvaqbjf.bet>
Date:   Sat, 19 Feb 2022 18:44:01 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2202200043590.26495@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Sun, 20 Feb 2022 00:46:24 +0100
        (CET)")
Message-ID: <xmqqtucuw93i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F68C5F4C-91F6-11EC-9C1F-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I notice that you did not take this into `seen` yet. I find that a little
> sad because it would potentially have helped others to figure out the
> failure in the latest `seen`:
> https://github.com/git/git/runs/5255378056?check_suite_focus=true#step:5:162
>
> Essentially, a recent patch introduces hard-coded SHA-1 hashes in t3007.3.

I saw the thread, I saw a few patches were commented on, and a few
were left unanswered, but one was replied by the original submitter
with a "Good catch!", making me expect the topic to be discussed or
rerolled to become ready relatively soon.

But nothing happened, so I even forgot to take a look myself by
picking it up in 'seen'.  It does sound sad that the topic was left
hanging there for 3 weeks or so in that state without any reroll or
response.

