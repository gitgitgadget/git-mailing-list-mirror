Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48882C001B0
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 21:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjHIVPe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 17:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbjHIVP3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 17:15:29 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773582129
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 14:15:24 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D644E189D82;
        Wed,  9 Aug 2023 17:15:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GFtuYCVOaJ0kyZahPTuZYNiK+tjmc6Xk6/lH9H
        1ZDC8=; b=H5W9uYT0EQbPiJY0df44ZP4u0WnaGpX+GnbMeNIO6xrHbqBpjTFP15
        e9gyOvHohOvztPs6cVMLUAGXbkOF4Dlqpi29Y5qnuTcX0qL483q+AqT01jqSLvyg
        CQDRYUjAxFv7ROYE0giZfKsXemyFjefR3Hyagic/0XfrKVVM+aV0A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CEE5F189D80;
        Wed,  9 Aug 2023 17:15:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4138C189D7F;
        Wed,  9 Aug 2023 17:15:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/1] t/lib-rebase: (mostly) cosmetic improvements to
 set_fake_editor()
References: <8ce40f48-f36f-9e81-1a3f-9d8b170c4a0f@gmail.com>
        <20230809171531.2564785-1-oswald.buddenhagen@gmx.de>
Date:   Wed, 09 Aug 2023 14:15:22 -0700
In-Reply-To: <20230809171531.2564785-1-oswald.buddenhagen@gmx.de> (Oswald
        Buddenhagen's message of "Wed, 9 Aug 2023 19:15:30 +0200")
Message-ID: <xmqqh6p7lxxx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DA54683E-36F9-11EE-B51F-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> An update to the documentation, and two minor functional changes that don't
> actually change anything given current use cases, and are therefore basically
> documentation updates as well.
>
> Oswald Buddenhagen (1):
>   t/lib-rebase: improve documentation of set_fake_editor()
>
>  t/lib-rebase.sh | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)

Now I lost track.  This is slightly different from one of the steps
in the three-patch series.  Were the other two steps retracted?

My time quota today to pick up newly sent patches has run out, and
we will be in pre-release freeze period any time now, so there is no
need for an immediate response, but please help readers easily see
which ones are proposed updates that are still surviving.

Thanks.
