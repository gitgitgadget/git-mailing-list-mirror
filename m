Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D24C433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 19:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240561AbiEXTyw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 15:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241604AbiEXTyQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 15:54:16 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E437B9E8
        for <git@vger.kernel.org>; Tue, 24 May 2022 12:54:04 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ED540126A34;
        Tue, 24 May 2022 15:54:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Pm0c+QQbbLWmVILCU9EL1+CauWdgbC8guBh1LK
        dKA/Y=; b=KIv792o96w0NKhWfMK9s96+mnuWjabh9v3OtxV+wtcdUC12upP6n4J
        swnxdXTHtl2h0Ez3Sz6F9a2u20r61GEXipERfXJoMnm+1TC/Zho1VbzcGBsfgVVP
        iNWSGgBjJCI9yDfElm4kiiVKzEyxu0WNGcMSiFdGrMlkFLNkJoUO4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E11F3126A32;
        Tue, 24 May 2022 15:54:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AC3A1126A30;
        Tue, 24 May 2022 15:54:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH v7 26/30] t/helper/hexdump: add helper to print hexdump
 of stdin
References: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
        <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
        <6f2e935f148e826609153378751c04807858e76c.1653336765.git.gitgitgadget@gmail.com>
        <xmqqk0acosks.fsf@gitster.g>
        <1fe2e843-20d1-4ea9-7ea2-c05330da17c2@jeffhostetler.com>
Date:   Tue, 24 May 2022 12:54:00 -0700
In-Reply-To: <1fe2e843-20d1-4ea9-7ea2-c05330da17c2@jeffhostetler.com> (Jeff
        Hostetler's message of "Tue, 24 May 2022 10:44:07 -0400")
Message-ID: <xmqq7d6ahfl3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 421DE7E4-DB9B-11EC-A2A2-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> Would you prefer a send a V8 or would you be willing
> to push a fixup commit on top?

If "test-tool hexgrep" does not turn out to be a better solution,
and if there is no other changes needed, then I do not mind locally
amending, but I'd rather avoid touching a middle step in multi dozen
patch series myself if I can.

Thanks.
