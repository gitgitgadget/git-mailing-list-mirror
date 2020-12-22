Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A091EC433E0
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 07:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61BCB23120
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 07:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbgLVHOX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 02:14:23 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55726 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgLVHOX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 02:14:23 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3173B10C342;
        Tue, 22 Dec 2020 02:13:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SzClFVkcjKxnrKrdl9Uyv/YD01E=; b=AsVDKP
        dz1oDy1/ORIgStaZZR/jBXpOR55d9+fM3wStJY3y30jRRZ4PDYXuSdGGYTB6kcHi
        N1VXU/CoUFtxp3icONVXWQshBMhK9mliA3b52DYEHAdtwm7+Gw9MJlMrYDTDRKRr
        R3WUJpdBCdgFCV4upb4mCU3mM59goN/5Far0k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MVhRRoqi2knj6DYZ0Rpd0rjMCAINRElp
        4vl2ggTKLEqiaur9ccesKAe/Toql0pAIvjMsZQPD2b/EQAMl4U8yM+8z5XjT7Hq+
        o9/YWrqF+AuSrkzdc3vyQ/LJ+56PkYd3u+VUvOs/pEUj/K3uJ3GzfKdOZbQeg/Bq
        FYlsxAKOZsI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1EE3910C341;
        Tue, 22 Dec 2020 02:13:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5C8DE10C33F;
        Tue, 22 Dec 2020 02:13:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     David Aguilar <davvid@gmail.com>, Seth House <seth@eseth.com>,
        Christian Couder <christian.couder@gmail.com>,
        git@sfconservancy.org,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Code of conduct violation?
References: <20201217175037.GA80608@ellen>
        <5fdc0e6dd79a7_f2faf208a1@natae.notmuch>
        <20201218023534.GA117762@ellen>
        <5fdc18a91c402_f2faf20837@natae.notmuch>
        <20201218054947.GA123376@ellen>
        <5fdc7a7d3a933_f4673208d0@natae.notmuch>
        <20201219001358.GA153461@ellen>
        <xmqq1rfmqc8g.fsf@gitster.c.googlers.com>
        <20201221042501.GA146725@ellen>
        <5fe033e0ec278_96932089d@natae.notmuch>
        <20201221073633.GA157132@ellen>
        <CAJDDKr6LrBMyfdp5Tutp29W9OqhbW4ffcP5e6PD8ruyxk3rQxA@mail.gmail.com>
        <5fe134eeaec71_11498208f9@natae.notmuch>
Date:   Mon, 21 Dec 2020 23:13:36 -0800
In-Reply-To: <5fe134eeaec71_11498208f9@natae.notmuch> (Felipe Contreras's
        message of "Mon, 21 Dec 2020 17:51:10 -0600")
Message-ID: <xmqqv9cuia8v.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 368270E4-4425-11EB-9337-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> David Aguilar wrote:
>> Just a heads-up that Felipe has a history on this list of creating
>> long, never-ending, pointless rant threads so sometimes the best
>> course of action is to ignore him.
>
> I think this can be considered a personal attack, which goes against the
> code of conduct.

A PLC member here.

As CoC document outlines in its Enforcement section, the project
leadership committee will review complaints of this kind, and may
issue a statement later, but we do not encourage list participants
to hold People's court publicly on the matter.

Thanks.

