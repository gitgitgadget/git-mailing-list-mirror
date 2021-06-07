Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439A2C47094
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 18:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1681760FEB
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 18:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhFGS6h (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 14:58:37 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57910 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbhFGS6h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 14:58:37 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B48BB132729;
        Mon,  7 Jun 2021 14:56:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NwTBuddhCIeAiauUmrKSXHj8J7J8QH7LqWRdFP
        K5mBw=; b=ZyAeCRPkkxlFmIcFc6lVxa3XeDY09/qyhBv4q1F4JAhJ51gf4qL8i+
        8Yhv2bMeRiEmrM/0XwszA/0Qpv8VaI89dK9XkN1tNmoz0RC0j0cLmmjbmx81YF/i
        +vjnyY60lQ2P2q5h0/ON1188CKwN4bQNigzgQVbHW/ktb83G8ODT0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ACEC6132728;
        Mon,  7 Jun 2021 14:56:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 004DE132727;
        Mon,  7 Jun 2021 14:56:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        stolee@gmail.com, jrnieder@gmail.com, emilyshaffer@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 4/4] CodingGuidelines: recommend singular they
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
        <d2c079264955b3bd6c3a5ef77a9c3684206f8475.1623085069.git.gitgitgadget@gmail.com>
Date:   Tue, 08 Jun 2021 03:56:41 +0900
In-Reply-To: <d2c079264955b3bd6c3a5ef77a9c3684206f8475.1623085069.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Mon, 07 Jun 2021
        16:57:48 +0000")
Message-ID: <xmqq4ke9v6za.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 197DADBC-C7C2-11EB-B7AF-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> To futher justify singular "they" as an acceptable grammatical concept,
> I include the careful research of brian m. carlson who collected their
> thoughts on this matter [2] (lightly edited):

The use of "their" here I found going overboard, given that (1) it
is outside the topic of this change, where you are not referring to
a non-specific person, and (2) as Brian's siglines indicate, the
preferred pronouns for the particular person you are referring to is
"he/him or they/them".

> + When referring to an anonymous user, use singular "they/them" pronouns
> + as opposed to choosing between "he/him" and "she/her". Do not use more
> + complicated constructs such as "he or she" or "s/he". This recommendation
> + also applies to code comments and commit messages.

Short and sweet.
