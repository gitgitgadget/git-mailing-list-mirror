Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C5A41F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 23:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbeK0KaJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 05:30:09 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61085 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbeK0KaJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 05:30:09 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F076C115E7A;
        Mon, 26 Nov 2018 18:34:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cXzGrxQ+QtFaoifKNT68uCc2pug=; b=qSc9s2
        eMxwDEqI0ziNsL7oDMbY6Q29w2QmLzZwfNY+Fd3LLMtzbCO/vOzuTf68hG+wdqxQ
        bNNvHnBVWc+2kNqRUo89cFp0mwrksWH+sMBuOAgH171gw1zbj+vXgHH+/p3fmyjK
        LwwAXHz716XNVbaQ29BgSAfdhAW32s42agXSQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=V+4lXKS6wgv7eIg4AUqdi8f4hVTM3/EZ
        8d9juMK7xdm2PKKoirZb2t20BD6dOHfIlxXG2ovN2QzIz6/H774sXdUtiM3oSjuO
        puRHO2ejRuku0XtQ4rr1n21zOSiqDBpNLT55Ib8rt4evZOwACU11q/aHERDGxv6s
        +f51+iQum4g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D588A115E78;
        Mon, 26 Nov 2018 18:34:18 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4E00F115E74;
        Mon, 26 Nov 2018 18:34:18 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Nov 2018, #06; Wed, 21)
References: <xmqqlg5m7qlb.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kZ5UaUUjMPV-ev7CdQ0yEa9AM3LGGC7tjUK0mFcuyBvbw@mail.gmail.com>
Date:   Tue, 27 Nov 2018 08:34:17 +0900
In-Reply-To: <CAGZ79kZ5UaUUjMPV-ev7CdQ0yEa9AM3LGGC7tjUK0mFcuyBvbw@mail.gmail.com>
        (Stefan Beller's message of "Mon, 26 Nov 2018 13:57:27 -0800")
Message-ID: <xmqqr2f7v2fa.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CB239BDE-F1D3-11E8-AC70-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> * sb/submodule-recursive-fetch-gets-the-tip (2018-10-31) 11 commits
>> [...]
>>
>>  "git fetch --recurse-submodules" may not fetch the necessary commit
>>  that is bound to the superproject, which is getting corrected.
>>
>>  Is the discussion on this topic over?  What was the outcome?
>
> Please don't merge down the topic in the current state.

Thanks.  It won't happen until the final anyway ;-)
