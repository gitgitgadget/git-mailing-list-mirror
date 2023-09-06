Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430DBEE14A8
	for <git@archiver.kernel.org>; Wed,  6 Sep 2023 15:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242745AbjIFP6Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Sep 2023 11:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjIFP6P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2023 11:58:15 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BF31724
        for <git@vger.kernel.org>; Wed,  6 Sep 2023 08:58:12 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 18D1C2ACFB;
        Wed,  6 Sep 2023 11:58:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=rc3h70vr6xcwLXR66s+UAlFD8ROdd452VpuSo2
        /nP4k=; b=ftDxE5pQblhv9sXJqwzd3HvATbiwJlwmurzw5RYPIrZAEYN5L7z2Pf
        rrFPwiUKqVAzdtCT5XMClzt8wKSRAyWlijgQhnaptpRHcSqhUL/MTXDhw0RDHjou
        Ss2ZSvdzLlJ8ugvD39HKj7Bs5mogPr374xo2F7yvEAHg311RuxApo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 112E62ACF9;
        Wed,  6 Sep 2023 11:58:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B47912ACF7;
        Wed,  6 Sep 2023 11:58:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 1/1] doc/diff-options: fix link to generating patch section
In-Reply-To: <87tts7pzl2.fsf@osv.gnss.ru> (Sergey Organov's message of "Wed,
        06 Sep 2023 09:47:53 +0300")
References: <87zg20qzhg.fsf@osv.gnss.ru> <xmqq34zsqlr3.fsf@gitster.g>
        <87tts7pzl2.fsf@osv.gnss.ru>
Date:   Wed, 06 Sep 2023 08:58:07 -0700
Message-ID: <xmqqpm2vnvjk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2C6FD06A-4CCE-11EE-A061-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> In fact I just realized that removing conditionals in fact *fixes* those
> documents by providing proper link in them as well, so I'll think of
> better description taking into account your observation as well, and
> then will re-roll.

Thanks.
