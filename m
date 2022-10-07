Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5207C433F5
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 16:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiJGQq4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 12:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiJGQqy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 12:46:54 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77B16AA07
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 09:46:53 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5123A1B6103;
        Fri,  7 Oct 2022 12:46:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uvAS3+tZR6jcMSBeoHxK/183dKiil/EPr0C/Y5
        yRsY4=; b=n0fV/oJOFtOnJQ8Z3bmuf2dkPrfuy/9xlTypu8Qtr5JVS6Fyfn3Niw
        fRnOQ1668LXc3SvPegdMFg0ACpoQ6OGRx/df4Lcr8iScyeGSG2LzvvxCj0iL0F8+
        2NLT4JHNjb33EC23Y7O6bh0Vx8uGfquoZxxkmogs8PDzrXa3S3JK8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4A3C51B6101;
        Fri,  7 Oct 2022 12:46:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 722A51B60FF;
        Fri,  7 Oct 2022 12:46:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH 00/15] run-command API: pass functions & opts via struct
References: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com>
        <52ca644a-0719-0ee6-56bd-a4b2686ae204@gmail.com>
Date:   Fri, 07 Oct 2022 09:46:47 -0700
In-Reply-To: <52ca644a-0719-0ee6-56bd-a4b2686ae204@gmail.com> (Phillip Wood's
        message of "Fri, 7 Oct 2022 10:59:45 +0100")
Message-ID: <xmqqk05bh98o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A2C2496C-465F-11ED-B806-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> Overall this looks good, I've left a few comments as I feel some of
> the patches are either redundant or could be helpfully squashed into
> an adjacent patch to reduce the amount of churn within this series.
>
> Best Wishes
>
> Phillip

Thanks for a review.
