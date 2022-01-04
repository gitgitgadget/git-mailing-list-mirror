Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE98C433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 20:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbiADUEN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 15:04:13 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53169 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiADUEN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 15:04:13 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 94AE8114FF9;
        Tue,  4 Jan 2022 15:04:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4MczxHELYfbpvkRtgQM0rPy7U2esTXJP2XEo2U
        DXK/Q=; b=m/9OW8RP5pc/o/7moyCIU2mKY3mxp8e16uZT0kpfor3boX+K69Ykkz
        A4sVXRmMVgdGUfxPq2w0EKXLoWhChuzIqwY4+q9a3tdHLZccScZmWR+423BEDrCN
        MvCAiavqSnSNPqOoLc+CNQgDKg8BUgNXKEbRNiZLfwDjSsxy215UM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8D20E114FF8;
        Tue,  4 Jan 2022 15:04:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EDDD5114FF7;
        Tue,  4 Jan 2022 15:04:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     James Limbouris via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, James Limbouris <james@digitalmatter.com>
Subject: Re: [PATCH v4] subtree: fix argument handling in check_parents
References: <pull.1086.v3.git.1638758742741.gitgitgadget@gmail.com>
        <pull.1086.v4.git.1638929518657.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.2201041319300.7076@tvgsbejvaqbjf.bet>
Date:   Tue, 04 Jan 2022 12:04:10 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2201041319300.7076@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Tue, 4 Jan 2022 13:21:31 +0100
        (CET)")
Message-ID: <xmqqk0ffclol.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7C06F48E-6D99-11EC-B069-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> In any case, thank you so much for sending the fixed commit, and sorry for
> not reviewing it earlier. It looks good to me! With this commit message, I
> think it is good to go.

Thanks, both.  Will replace.
