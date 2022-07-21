Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19738C433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 16:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbiGUQqb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 12:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiGUQqa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 12:46:30 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B321A053
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 09:46:30 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A68F71ACA55;
        Thu, 21 Jul 2022 12:46:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fGE2UtZWyGVlP94uEBGJzGDkw5BS7iHxderhEO
        DVShs=; b=vURVoQYyiRmqW0geIWIvIHId2z5I3/sX0ocZUHWMS10bz9npUQw5gC
        zoW0WQMyadpDV1W+OlNmIVTcsW/bfNk/SK0JPRRE6q9mkN0CJsYADMZZeoriqT3G
        gqxpq8MTaOeLQTbV4PJzGdYZPv/rEncvIJWUBJ1FzN8fgndnpTtyI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9F1AD1ACA54;
        Thu, 21 Jul 2022 12:46:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 50FBB1ACA53;
        Thu, 21 Jul 2022 12:46:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Kilian Kilger via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Tao Klerks <tao@klerks.biz>,
        Kilian Kilger <kkilger@gmail.com>
Subject: Re: [PATCH v3 0/2] git-p4: Fix bug with encoding of P4 client name
References: <pull.1285.v2.git.git.1658134679233.gitgitgadget@gmail.com>
        <pull.1285.v3.git.git.1658394440.gitgitgadget@gmail.com>
Date:   Thu, 21 Jul 2022 09:46:25 -0700
In-Reply-To: <pull.1285.v3.git.git.1658394440.gitgitgadget@gmail.com> (Kilian
        Kilger via GitGitGadget's message of "Thu, 21 Jul 2022 09:07:18
        +0000")
Message-ID: <xmqqr12ejtwe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A9581DFC-0914-11ED-951E-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Kilian Kilger via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Kilian Kilger (2):
>   git-p4: fix bug with encoding of p4 client name
>   git-p4: refactoring of p4CmdList()

[PATCH v3 1/2] seems to be identical to 34f67c96 (git-p4: fix bug
with encoding of p4 client name, 2022-07-08) that was already merged
to 'next' yesterday, so I can safely ignore it and take [PATCH v3
2/2] as if it were a single follow-up patch on the same topic and
queue it on top.

Thanks.
