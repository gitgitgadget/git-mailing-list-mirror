Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F69C433E0
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 05:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A87CA2251F
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 05:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgLWFCz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 00:02:55 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52225 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbgLWFCy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 00:02:54 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4DB3DA521D;
        Wed, 23 Dec 2020 00:02:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=R/Ly5mjFV/troG4Yu/0zDq/Pibk=; b=o+vLu0
        tYlSAKj8raQz23U7+niyNuBfsbaDUr77yKmhbbTXPs9N9ktWkvx4J3D3OrfExFxL
        IsVRSM1vbvyX5H1MGFL2N2dQzLnT2uJ6gBTs8YlUHYDrJ1nc3+3wK2fWVxC8+MAN
        2sTQyRAGc/CiEOhRFe4kqvUHPPYG6JBwQZdAg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FLri/khOwBKyAw0LoXk4OcrXgs8BS0yX
        CKbtUSnlv5mZLxS/7Yp7sRVtUY6QmbhmMwgPQ+HzPEJLkRdAfH7TVJTLMSLrL5ta
        YteV9YFIWYtC+JIT5OZ2U46PRgKo4KZfjynC+bplK1XczRSs/fZbUy/jx5XFrjjC
        Xe1IH87Jfyo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 36149A521C;
        Wed, 23 Dec 2020 00:02:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ACB36A521B;
        Wed, 23 Dec 2020 00:02:12 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        David Aguilar <davvid@gmail.com>, Seth House <seth@eseth.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        git@sfconservancy.org
Subject: Re: Code of conduct violation?
References: <5fdc18a91c402_f2faf20837@natae.notmuch>
        <20201218054947.GA123376@ellen>
        <5fdc7a7d3a933_f4673208d0@natae.notmuch>
        <20201219001358.GA153461@ellen>
        <xmqq1rfmqc8g.fsf@gitster.c.googlers.com>
        <20201221042501.GA146725@ellen>
        <5fe033e0ec278_96932089d@natae.notmuch>
        <20201221073633.GA157132@ellen>
        <CAJDDKr6LrBMyfdp5Tutp29W9OqhbW4ffcP5e6PD8ruyxk3rQxA@mail.gmail.com>
        <5fe134eeaec71_11498208f9@natae.notmuch>
        <20201222150124.mnfcyofm4qyvvj4n@yadavpratyush.com>
        <5fe2c64bd3790_17f6720897@natae.notmuch>
Date:   Tue, 22 Dec 2020 21:02:12 -0800
In-Reply-To: <5fe2c64bd3790_17f6720897@natae.notmuch> (Felipe Contreras's
        message of "Tue, 22 Dec 2020 22:23:39 -0600")
Message-ID: <xmqq5z4tdsiz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 04B2ACFC-44DC-11EB-B047-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Pratyush Yadav wrote:
> ...
> But I'm not going to pretend I'm fine with a change I disagree with; I'm
> not. Especially when nobody is paying me to do this.

I presume that at this point you are no longer talking about the
inappropriateness of the phrase "never-ending pointless rant".
Perhaps it is time to change the subject line.

If you still are, then please disregard the rest of the message.

>> The community needs to do its part in making you and everyone else
>> feel welcome. At the same time you need to do your part in making
>> contributors, especially the new ones, feel welcome and appreciated.
>> Being overly critical can turn developers away from the project.
>
> Who are you talking about? I'm the one who made the contribution.

What does the "change you disagree with" you mention above refer to?
Changes suggested by reviewers to add per-tool knob?
