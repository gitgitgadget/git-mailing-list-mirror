Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70510EB64DD
	for <git@archiver.kernel.org>; Tue, 25 Jul 2023 21:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjGYVqy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jul 2023 17:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjGYVqx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2023 17:46:53 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868AB1FDD
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 14:46:52 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E0B96190BB5;
        Tue, 25 Jul 2023 17:46:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8zWqWycfJBZ5Q5sZFmTxuAKWTUvHYLN0kLMEe9
        sw2W4=; b=fMyR+KfU8bN9KejnMfrO1Dy0ScCSPUm/Oe5P2ALp5EPmbyaYRgelFc
        KFqTP47D+0K3Si90MAVQTX3adAtOJCeRpp1ahP1vaaJ00NkxFDJnrCzjP3lb+sBX
        0qfdCApjAnftxrmUpybIOZMKUuu5kQbuS0ckOYs4bpe5fwmAc24bE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D960B190BB4;
        Tue, 25 Jul 2023 17:46:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4F039190BB2;
        Tue, 25 Jul 2023 17:46:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kousik Sanagavarapu <five231003@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Siddharth Singh <siddhartth@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH v5 0/2] Add new "describe" atom
References: <20230723162717.68123-1-five231003@gmail.com>
        <20230725205924.40585-1-five231003@gmail.com>
Date:   Tue, 25 Jul 2023 14:46:49 -0700
In-Reply-To: <20230725205924.40585-1-five231003@gmail.com> (Kousik
        Sanagavarapu's message of "Wed, 26 Jul 2023 02:21:20 +0530")
Message-ID: <xmqq4jlrirzq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C3816E52-2B34-11EE-81D2-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kousik Sanagavarapu <five231003@gmail.com> writes:

> Thanks for the review on the previous version of this series. Here is a
> quick re-roll to address the minor changes that you left on the previous
> version (apart from the suggestions to PATCH 1/2).
>
> Please queue this instead.

"! -> test_must_fail" has already been corrected locally yesterday
before I pushed the integration results out, so I'd skip this round.
