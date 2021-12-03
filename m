Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2140C433F5
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 20:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382909AbhLCUFg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 15:05:36 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61808 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353557AbhLCUFd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 15:05:33 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C1595EA72F;
        Fri,  3 Dec 2021 15:02:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2WF9an2Nk+5j5KR2VXVvP9h/h7EZK7zc5MPtzH
        EbfKE=; b=JjwmMA3l7qsl7IrCW8VmtcE4h5H3LFZg3zazrCwWfwe2M4pArnD+FS
        CSRnpXtxqLMuV5XdpSTcO5717cJUCcb4e6N/Nvcg3tsMuw2Fz3fKc2xFDE+B2OQ3
        gYaiIN9kv4NqReXktxUQTcbOdBsEFgmCJVLrG6C5mV5NgO/FNZzsI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9522BEA72C;
        Fri,  3 Dec 2021 15:02:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 35B50EA72B;
        Fri,  3 Dec 2021 15:02:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     James Limbouris via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, James Limbouris <james@digitalmatter.com>
Subject: Re: [PATCH] subtree: fix argument handling in check_parents
References: <pull.1086.git.1638324413653.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.2112031610590.63@tvgsbejvaqbjf.bet>
Date:   Fri, 03 Dec 2021 12:02:02 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2112031610590.63@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 3 Dec 2021 16:22:23 +0100 (CET)")
Message-ID: <xmqq1r2tsbid.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E2E887F6-5473-11EC-8853-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> So I _think_ your change is correct, even if I would love to see an
> easy-to-understand description of the scenario where more than one parents
> might be checked.

I agree with this.  I'll mark the topic as "Expecting a reroll" in
the next "What's cooking" report, so that we do not forget that we
are waiting for such an improved description in the log message.

Thanks.
