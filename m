Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439FDC433EF
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 23:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236983AbiFIX4L (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 19:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiFIX4J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 19:56:09 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C17220EA
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 16:56:08 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8B4D9118F8E;
        Thu,  9 Jun 2022 19:56:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=6xXDncqtiew8Lr7H7bG/8gkD14DdnyLBNBRDHped1Ys=; b=ASmB
        BGnMUisuBPu089SlnVUn/NAAgK41ZuKf+DeUDTBCjBRUbq64IahClQJOnCKWje2J
        EUNmdgN93oGkQTmFBMKnxa4ft3WJKCxJnIj6CpagGd2PoULsdG0njpW/Kr2PDmDX
        lcjXrDOw9Q+meudHZs/1PlNqzOgngjMgwcUVYRg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 73277118F8D;
        Thu,  9 Jun 2022 19:56:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 85727118F8B;
        Thu,  9 Jun 2022 19:56:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/2] ci(GitHub): mark up compile errors, too
References: <pull.1253.git.1654774347.gitgitgadget@gmail.com>
Date:   Thu, 09 Jun 2022 16:56:05 -0700
Message-ID: <xmqqbkv1gzmy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BA336568-E84F-11EC-A8D8-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Just like we mark up test failures, it makes sense to mark up compile
> errors, too.
>
> In a sense, it makes even more sense with compile errors than with test
> failures because we can link directly to the corresponding source code in

Absolutely ;-).
