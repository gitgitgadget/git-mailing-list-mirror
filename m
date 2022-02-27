Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B3AC433F5
	for <git@archiver.kernel.org>; Sun, 27 Feb 2022 22:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbiB0WOQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Feb 2022 17:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiB0WOQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Feb 2022 17:14:16 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9FA1A82A
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 14:13:38 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7A80C18DB5D;
        Sun, 27 Feb 2022 17:13:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CJea1CLCKL6Ayl98kDFynRCSWIrX6RHQg/8e7X
        BX81I=; b=slsuC9o+LqU5tomnnQHDeZvFxrXL39hbGrmpPQAnHNmI+TTBRBWWHi
        J1FV7E0qdQDQHUfMyfBIslZUiiMqD+kpGwY8A2U7l2ROwCyczKBJzi14I/CxYggA
        6X5Tg9G5kVg554uxIQkiO6zSwpB2ZnvcA7w1LD0V/uDW3y2pbZi/8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 732F318DB5C;
        Sun, 27 Feb 2022 17:13:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0026118DB5B;
        Sun, 27 Feb 2022 17:13:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Altmanninger <aclopte@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Re* [PATCH] rerere-train: modernise a bit
References: <xmqqsfsjuw8m.fsf@gitster.g>
        <20220227180203.pakrqimsxbjx47tu@gmail.com>
        <xmqqy21w3z78.fsf_-_@gitster.g>
        <20220227202328.7afrpuaujgwsnmcy@gmail.com>
Date:   Sun, 27 Feb 2022 14:13:35 -0800
In-Reply-To: <20220227202328.7afrpuaujgwsnmcy@gmail.com> (Johannes
        Altmanninger's message of "Sun, 27 Feb 2022 21:23:28 +0100")
Message-ID: <xmqq5yp03qls.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 820DE3E6-981A-11EC-96B0-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Altmanninger <aclopte@gmail.com> writes:

> The --no-pager fix would have prevented my confusion, which is an argument
> for placing it first.

I would rather squash them into one.  "--no-pager" alone would give
an apparent regression to people like you whose pager "corrected"
the output from the command, but with two changes squashed together,
we would not have to see any regression.

Thanks.

