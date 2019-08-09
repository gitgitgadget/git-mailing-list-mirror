Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37FC01F731
	for <e@80x24.org>; Fri,  9 Aug 2019 17:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407357AbfHIRpv (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Aug 2019 13:45:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54601 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfHIRpv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Aug 2019 13:45:51 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D2B4615F97D;
        Fri,  9 Aug 2019 13:45:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+QdENR3oVmJ7QM3bpIrYQBQpxkg=; b=nlIXtz
        VqQAlT2UYUgeYsZdz1u8ja9LScndyABprkpcgDZPSv5axUSkY8QPhUOcSm/aRWod
        HF0P7gb4pmLs7FDhLI5qLcuHGhR5Wd67OntcnOI08u0+F/lqNFtu4iXo8Ca0iTjg
        4JdC4kyYYRkZfV1gA+Peh3bj73GetQUXV0Jg4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QANT66+FFxluOX6pC2usMfM1UT1ovu89
        lmcYfJSaPte6SdphjKJaSvVEx8sreS2p2GI0OEojUJOTh2jXIs1XlNDhbp1c+Zz9
        AaMaboL7E/dCSy2OWKzl2MUkKvdMLmFfQpcUXKinbhh0RyWsdZ+++dhNZyV8pruZ
        iL6pznETgQU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C99B615F97C;
        Fri,  9 Aug 2019 13:45:48 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3A6F415F97B;
        Fri,  9 Aug 2019 13:45:48 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Christian Couder' <christian.couder@gmail.com>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2019, #06; Thu, 25)
References: <xmqq36itprzo.fsf@gitster-ct.c.googlers.com>
        <20190809001315.GA87896@syl.lan>
        <3C7105E5-5DE1-42DC-A9A4-65C061FD6139@dereferenced.org>
        <001e01d54ebb$9a1ab4b0$ce501e10$@nexbridge.com>
        <20190809162900.GA9094@sigill.intra.peff.net>
Date:   Fri, 09 Aug 2019 10:45:47 -0700
In-Reply-To: <20190809162900.GA9094@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 9 Aug 2019 12:29:01 -0400")
Message-ID: <xmqq36iadygk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 85836884-BACD-11E9-91B3-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I don't know of any plans for checkout in particular, but I think the
> docs for restore/switch make it clear that it's way too early to start
> scripting around them:
>
>   $ git grep EXPERIMENTAL Documentation/
>   Documentation/git-restore.txt:THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
>   Documentation/git-switch.txt:THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.

Would it ever be OK to script around checkout, restore and/or switch
Porcelain commands?
