Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC4FC00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 18:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbiHJS3m (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 14:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiHJS3l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 14:29:41 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B3D86C24
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 11:29:40 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 929F5132153;
        Wed, 10 Aug 2022 14:29:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CxBoJi4qMpixsQaHSty9EwJK/ifsawMvnp1ggo
        +x2Gs=; b=wWZ6vCmzwKU/5t7YunOgDJrcrvMBQoeoEgCJnLqmfNmCGuL7DZwfmW
        vo0n2nZyYTp1J14+o4aSN3mnlLHUh/Npbb72C7GGSZUMXqhuRKT+Vmh1g7nkysbn
        z+Rnd+gPNo4cXc+5EOm6/8L0Q1Rb2CRLGSQfxMo2BgoGcgP+etg40=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8B3D5132152;
        Wed, 10 Aug 2022 14:29:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E7C19132150;
        Wed, 10 Aug 2022 14:29:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fernando Ramos <greenfoo@u92.eu>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 7/7] mergetools: vimdiff: restore selective diff mode
References: <20220809004549.123020-1-felipe.contreras@gmail.com>
        <20220809004549.123020-8-felipe.contreras@gmail.com>
        <CAMP44s2RsvXnt8LtDcv+Ai_kCxmtURGWXmwfchO08dhjMxkGhA@mail.gmail.com>
        <YvHv+EcNyHXCNZhK@zacax395.localdomain> <xmqqmtccpjv8.fsf@gitster.g>
Date:   Wed, 10 Aug 2022 11:29:37 -0700
In-Reply-To: <xmqqmtccpjv8.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        10 Aug 2022 01:45:31 -0700")
Message-ID: <xmqq35e4lzou.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 64B21C5E-18DA-11ED-984D-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> So, definitely a great work. Thanks for the deeper look at the problem and this
>> brilliant solution :)
>
> Is that a "Reviewed-by:" I should add while queuing these 7 patches?

Ah, sorry, scratch that.  There is a newer round, and that is the
one that can use your input.

> Thanks, both.

