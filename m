Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DB7C433ED
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 21:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE4F9610CC
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 21:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244605AbhDPVnd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 17:43:33 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53134 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235540AbhDPVnd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 17:43:33 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A460A116FF8;
        Fri, 16 Apr 2021 17:43:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1HOI0iLF1fUMjOq2bTzkyC3OXK8=; b=CaCmMD
        DNClH0hdHF0Dows32/KWpNnfInOLzDjIcTwE6J+Lb9RNJ6y2KMj0esUtcU5a8Sxa
        dNAkmsZFUJqd0APtzh25u3BkWagz1D6gPOxr8qoQ/kD/AZotXPSz2HJ7VJvhUnHZ
        gYa/bhB6lVlnVcwvwOiAe8DClRtJfrGBPx1Is=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZYM8QXOxNCoOR8E89B2k5g3hvaQN9hxv
        3EvzdxfUP2qlY0NS/pcocbsQ5VpoIIaSfCgh/BTfNyXCDhRnYFuOwFY2kaUWXSpf
        +W0FgPK8nm6xbESjcQHhpwMlVPQzqDgzzPJJwd7gVY4K7iJHH9lbzbsBKQ8SrVuU
        aEea8FrdccQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9D3E8116FF7;
        Fri, 16 Apr 2021 17:43:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EDAEA116FF5;
        Fri, 16 Apr 2021 17:43:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        git@jeffhostetler.com
Subject: Re: [PATCH v2 0/5] Parallel Checkout (part 2)
References: <cover.1616015337.git.matheus.bernardino@usp.br>
        <cover.1617893234.git.matheus.bernardino@usp.br>
Date:   Fri, 16 Apr 2021 14:43:03 -0700
In-Reply-To: <cover.1617893234.git.matheus.bernardino@usp.br> (Matheus
        Tavares's message of "Thu, 8 Apr 2021 13:16:59 -0300")
Message-ID: <xmqqpmytkis8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B9BA31D6-9EFC-11EB-A699-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> This is the next step in the parallel checkout implementation. As
> mt/parallel-checkout-part-1 is now on master, this round is based
> directly on master.
>
> Changes since v1:

Now, I do not think we've seen any response to these messages.

It seems that review comments for the earlier round cf.
<CAP8UFD1stvx=2hBWyxmu75SXRzX-bHBfGr2jxWKgHdc85cfxRg@mail.gmail.com>

have been addressed?  Should we merge it down to 'next' now?

