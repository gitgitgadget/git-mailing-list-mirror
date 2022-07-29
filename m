Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C86C00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 16:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236433AbiG2QCb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 12:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiG2QCa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 12:02:30 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF236FA1D
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 09:02:29 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 51E8F1A3544;
        Fri, 29 Jul 2022 12:02:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HJstsMFe5Yf6fh6Eby8GRvLIalrOiRFQstca26
        dCSUQ=; b=KuHNItY1quHwRV51UiotJnCpveHFAKAQzQdSu3O8XYSnwsRY6x2UML
        Gt2tk0WxjUEfyZoTk8eZEWhypZ5oP8VjdqGgnTke6Oyu+SkfAw4biUicu1Egtm0U
        QlCOUpeqiQi8hGs4FRicNwNkwnea0a2KwVTSbFZSPcHy3VPQHz5lE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 490B11A3543;
        Fri, 29 Jul 2022 12:02:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E87001A3542;
        Fri, 29 Jul 2022 12:02:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/2] ci: fix the FreeBSD build
References: <pull.1308.git.1659097724.gitgitgadget@gmail.com>
Date:   Fri, 29 Jul 2022 09:02:23 -0700
In-Reply-To: <pull.1308.git.1659097724.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Fri, 29 Jul 2022 12:28:42
        +0000")
Message-ID: <xmqq7d3vaovk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D643A66C-0F57-11ED-B6FF-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> performance regression: t5351 all of a sudden takes almost half an hour
> [https://github.com/git/git/runs/7398490747?check_suite_focus=true#step:5:171]
> to run on Windows. I found a fix, and it now passes in less than half a
> minute

;-)  That's impressive.

