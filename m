Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26DCC3DA66
	for <git@archiver.kernel.org>; Wed, 23 Aug 2023 22:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238548AbjHWWES (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Aug 2023 18:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238450AbjHWWDw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2023 18:03:52 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0CAE5F
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 15:03:51 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 467281A19BA;
        Wed, 23 Aug 2023 18:03:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Qu02yvdyG7DOL6kWUUd6LtBkD1dqOu9cUBX2Mj
        sLNDQ=; b=HaPVKOQzqd34wNyz18ii2AHTYxn4RR4xRJAYoXY+otQnEME8SJEvBj
        Bwms57vbXDI/ClOgIRjyDEzOwE5AeRid54MMbKgYDqnnVZ5R7lfnrPJdMTcbJE45
        Nt0JOljqgHGShsNAgPdBrMdE/kmeb6lFhkkIhNWs7kTN0PPNWQm48=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3EF991A19B9;
        Wed, 23 Aug 2023 18:03:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 689C31A19B8;
        Wed, 23 Aug 2023 18:03:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: 2.43 release date adjustment?
References: <ZOYdG8RtPIgymtBV@nand.local> <xmqqpm3dg27i.fsf@gitster.g>
        <ZOZR0jesPpCDNbRj@nand.local> <xmqqh6ope8v6.fsf@gitster.g>
        <ZOZ+cbkrXsEcQyaW@nand.local>
Date:   Wed, 23 Aug 2023 15:03:45 -0700
In-Reply-To: <ZOZ+cbkrXsEcQyaW@nand.local> (Taylor Blau's message of "Wed, 23
        Aug 2023 17:47:29 -0400")
Message-ID: <xmqqcyzde7r2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EE88CC8E-4200-11EE-8CDD-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> No specific reason to expect bugs. Just trying to line things up so that
> we have (a) people around when the release is tagged, and (b) don't have
> a release hanging over our heads either during or immediately after a
> week when most US developers are offline.

That is exactly what I call "expecting a post-release fixes".

A much more important thing is to make sure we catch them before the
release and devise ways to help us do so, perhaps opting more userbase
into testing early.

Also a much more productive thing to discuss than just the timeline:
What do we want the end product of this cycle to include?

I am personally hoping to see an enhanced rerere that can record and
replay delete-modify conflict that gets resolved to removal.  Others
may have their own agenda, and it may be interesting to hear them.
Those without specific agenda for this cycle may volunteer to help
others' topics.

Thanks.
