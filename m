Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57ABECAAA1
	for <git@archiver.kernel.org>; Fri, 16 Sep 2022 15:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbiIPPkC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 11:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbiIPPj7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 11:39:59 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DE236DFF
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 08:39:58 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1821A1B8B32;
        Fri, 16 Sep 2022 11:39:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Cg5F3t7RERyng6KBxHbElEzH7kDJFOJXGOLnx3
        nRJoc=; b=fHn7PZBy7PvL7Jl0F5duej+QQq5/WggCojZYpayMW1uckEAlEOXB/v
        YEe5fDCHr4/bU2/y/sF2ur0CpblRMxxPcvGeqflsf6xypxTiO9M35GKvQUVJgiQj
        2tjlm1pbINP6FwxhdG4Szkiz69AQySuTypcUpy7W1yLo0pQPGJMik=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 11BC01B8B31;
        Fri, 16 Sep 2022 11:39:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 723F01B8B30;
        Fri, 16 Sep 2022 11:39:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] api docs: link to html version of api-trace2
References: <20220916062303.3736166-1-tmz@pobox.com>
        <20220916062303.3736166-2-tmz@pobox.com>
Date:   Fri, 16 Sep 2022 08:39:53 -0700
In-Reply-To: <20220916062303.3736166-2-tmz@pobox.com> (Todd Zullinger's
        message of "Fri, 16 Sep 2022 02:23:03 -0400")
Message-ID: <xmqqv8pnjpkm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CF8D3DAC-35D5-11ED-8E14-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

> In f6d25d7878 (api docs: document that BUG() emits a trace2 error event,
> 2021-04-13), a link to the plain text version of api-trace2 was added in
> `technical/api-error-handling.txt`.
>
> All of our other `link:`s point to the html versions.  Do the same here.
>
> Signed-off-by: Todd Zullinger <tmz@pobox.com>
> ---
> This is minor, but I noticed it while working on the previous patch.  The
> effect can be see at [1] where we link to [2].

Thanks.
