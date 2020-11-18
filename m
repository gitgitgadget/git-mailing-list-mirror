Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAEAC63798
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 20:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97430246C9
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 20:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZiJ5r1Sn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbgKRUuj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 15:50:39 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61283 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbgKRUui (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 15:50:38 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C886E10EC92;
        Wed, 18 Nov 2020 15:50:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mduEgBFPCGymLYsyhz10Y9+4DF4=; b=ZiJ5r1
        SnX4tryfigmhDzIu+dzdxaiTjc0FifuVKd6ZJNRrXc5JD3NEmXe1srbq3bDJ2+wc
        e00UlvMaW9SJhE7u9kHOIQGOVFRMddkA4Pe53XSfaC8g/VCmvSdAWvXJ78Bt45Ut
        NtDyRRIhuAr1mEAoyVloERdSC+Kjv3x2+MA6o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WWUIR5DDJFxpquFdzNR+bbjVQ2xbADrH
        phcBhcKTwj1XWXQqLlbBde2UUu9UhptieK0yi5x2bDxkuctbFf3o13GhhFiRB+pY
        rIpwusPKOL1bx2rZtYdbUbPknphm9FWiffcYUUWGaXecBygt9rjoORjt/pIn842q
        nIZvL4O+AVU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BF25910EC91;
        Wed, 18 Nov 2020 15:50:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 17F0C10EC90;
        Wed, 18 Nov 2020 15:50:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] t3040: remove stale note
References: <pull.793.git.1605727526797.gitgitgadget@gmail.com>
Date:   Wed, 18 Nov 2020 12:50:32 -0800
In-Reply-To: <pull.793.git.1605727526797.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Wed, 18 Nov 2020 19:25:26
        +0000")
Message-ID: <xmqqwnyiz8x3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B41C675E-29DF-11EB-90A7-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> This comment was most likely a "note to self" during the development of
> 1c3e5c4ebc3 (Tests for core subproject support, 2007-04-19) and is
> neither needed nor comprehensible at this point. Let's remove it.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     t3040: remove stale note
>     
>     And yet another thing I noticed while working on 
>     https://github.com/gitgitgadget/git/pull/762.

It seems that all test updates from you today are some form of
refinement to the 27-patch series we have in 'seen'.  I'll resolve
conflicts in favor of these new ones as they look strict improvement
(modulo @{2} thing I mentioned separately) in the meantime, but
let's not forget to remove them from a reroll of the large series.

Thanks.
