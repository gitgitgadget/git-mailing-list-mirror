Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E366AC5519F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 07:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 805D224199
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 07:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FYw4ETV4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgKRHCk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 02:02:40 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53753 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgKRHCk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 02:02:40 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E786083148;
        Wed, 18 Nov 2020 02:02:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RMIde83bbPK7X6iYzyIwmliNqgM=; b=FYw4ET
        V4gSUZZ288Rl9hu+rbnxylZRvLbJU20lBb6aZL8/QMcAF7+0H0CSxoJ8fYmF5bwZ
        Yyc2+GJOlZkK67khwyVTQipJR28wtATWChQl1GEvFKh1tfGV8Rh65EW1WbeA94Aq
        3Bvw8ShJLB9eZw38xM5wIguUyge/yEkOFAqfs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PGYuQgXVkxOT6tv8Pl4EkyIupGrPzZYv
        VQN0OhzVyWO8BS+bf8JL7Pr520LO3drnPoS2sLCcm3HkhoTD4tBlH3+YxbHmxBDj
        91mUXri/eP/mXoGcwPOfpihflx2ZciE9ISlVu90BuKGIXlJx3HMan3VR5EI9DKFx
        iHMvPvwbIX8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DFBF483147;
        Wed, 18 Nov 2020 02:02:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 720B783146;
        Wed, 18 Nov 2020 02:02:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        szeder.dev@gmail.com
Subject: Re: [PATCH v4 1/4] t1400: avoid touching refs on filesystem
References: <cover.1604501265.git.ps@pks.im> <cover.1605254957.git.ps@pks.im>
        <617d48b00a13c8ef82749f0b610997625f6cf222.1605254957.git.ps@pks.im>
        <20201113204031.GA780435@coredump.intra.peff.net>
        <X7TDxPFjrG4vruHx@ncase>
Date:   Tue, 17 Nov 2020 23:02:38 -0800
In-Reply-To: <X7TDxPFjrG4vruHx@ncase> (Patrick Steinhardt's message of "Wed,
        18 Nov 2020 07:48:36 +0100")
Message-ID: <xmqq5z63406p.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0BB922BE-296C-11EB-A7E5-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> Junio, shall I fix this typo with another version or will you fix this
> up locally?

Please make it a habit to check what is on 'seen' before asking.

Given we have timezone differences (and this late at local night I
am not in an environment in which I can check it myself easily),
doing so would be much faster.

Thanks.
