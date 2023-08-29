Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD0DC71153
	for <git@archiver.kernel.org>; Tue, 29 Aug 2023 22:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238425AbjH2V7j (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Aug 2023 17:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238391AbjH2V7I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2023 17:59:08 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC17A19A
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 14:59:05 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7D6872D3CF;
        Tue, 29 Aug 2023 17:59:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Op2QwXpqTj5PUTgzuUn4Kwi/SChZflEv85pa/c
        nkYhU=; b=wPbTmIRHXeHi4xtmmTQgvzzW9q/0tTKV9OZ6+3ARqtQZQCs8/bCRNK
        OLTHrRKio4wyCyQGf4bR7l0FZoKBhjMOOb6G/CBYrfRxUf4T+b4cC+/wzQ+5EgO8
        G28jo74UEFDY/aSJwRLZJ0ZZyAtaw5021sNSY3t5ry5qEneIFWEgM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7758B2D3CE;
        Tue, 29 Aug 2023 17:59:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 16EA32D3CC;
        Tue, 29 Aug 2023 17:59:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Andy Koppe <andy.koppe@gmail.com>, glencbz@gmail.com,
        phillip.wood123@gmail.com
Subject: Re: [PATCH v5 0/8] pretty: add %(decorate[:<options>]) format
References: <20230820085336.8615-1-andy.koppe@gmail.com>
        <20230820185009.20095-1-andy.koppe@gmail.com>
Date:   Tue, 29 Aug 2023 14:59:00 -0700
In-Reply-To: <20230820185009.20095-1-andy.koppe@gmail.com> (Andy Koppe's
        message of "Sun, 20 Aug 2023 19:50:01 +0100")
Message-ID: <xmqqcyz5cxy3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4388FED8-46B7-11EE-9B38-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andy Koppe <andy.koppe@gmail.com> writes:

> Apologies for sending another version so soon, but I realized that I
> hadn't removed the use of a compound literal from the first commit where
> I had added it, so it still appeared in the patches. The overall diff
> for v5 is the same as for v4.

Sorry, but I lost track.  How does this latest round of the topic
look to folks?  Ready to go?

Thanks.
