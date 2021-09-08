Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE65C433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 00:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F0DE6054F
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 00:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236196AbhIHAcW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 20:32:22 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65325 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbhIHAcV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 20:32:21 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DE41014626F;
        Tue,  7 Sep 2021 20:31:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GN+KwLb/TXcoXLpB4y6DCIN8ZBHPGdKK2Sp9wy
        b856Y=; b=U48kyK3wXi8lGm4m8z3FBvMshY5Lct/4hp5lntStZcRGweds3ft8Wh
        4qSvvIwHRpGZlFC/DheTZUNMLARZBrvT9euUNav/BVdYwsxX4GxW4gzOXoqhZJEr
        2tzdwLArrhUffrjHEgSr0bKHu3wAXp8yqbwn1r3UE/WM7OURn0aF8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D60FE14626E;
        Tue,  7 Sep 2021 20:31:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2BE0314626C;
        Tue,  7 Sep 2021 20:31:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>, avarab@gmail.com,
        christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, jrnieder@gmail.com,
        kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com, rafaeloliveira.cs@gmail.com,
        sunshine@sunshineco.com
Subject: Re: [GSoC] [PATCH v5 0/9] submodule: convert the rest of 'add' to C
References: <20210807071613.99610-1-raykar.ath@gmail.com>
        <20210810114641.27188-1-raykar.ath@gmail.com>
Date:   Tue, 07 Sep 2021 17:31:10 -0700
In-Reply-To: <20210810114641.27188-1-raykar.ath@gmail.com> (Atharva Raykar's
        message of "Tue, 10 Aug 2021 17:16:32 +0530")
Message-ID: <xmqq1r5z9acx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 11A89F62-103C-11EC-8606-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Atharva Raykar <raykar.ath@gmail.com> writes:

> NOTE: This series uses (ar/submodule-add-config):
> https://lore.kernel.org/git/20210806140431.92018-1-raykar.ath@gmail.com/

I didn't see anybody comment on this round (and do not think I saw
anything glaringly wrong).

Is everybody happy with this version?  I am about to mark it for
'next' in the next issue of "What's cooking" report, so please
holler if I should wait.

Thanks.
