Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2C5C433E0
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 17:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAB3464E83
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 17:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbhBWRea (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 12:34:30 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51336 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233735AbhBWReY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 12:34:24 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 14079BBA47;
        Tue, 23 Feb 2021 12:33:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZIMnXSS4HRI5o4Y8yieIb7xrMt4=; b=o10ajf
        lx0YfRYhLPkT2nZNIIuIoc09gBXtOh0lECBy46IG6h/hvQtNlb+jZwCrNU5COJOd
        +mAxqpmIb6p0MkAKqCReOMAdim/sDnbu8H3dP6u+MwKLf8A/JDZjstBMqCVR9hxg
        vWgOkjgIO/knGDDpc5C5+oxRedE6b8tpAlEYw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Q4Z7n8RhZ9rcYSahyv9mIVQEKAvKPSsT
        cxo9+nWkMThnjH+S58SOCNwInEVQSYxbQBr/7NS51afCgPuR4YrbhnzDttMYJO5z
        RIaoH8o0iyGdiHNsL1Hn95xzOmV4iCldNTsysYsBc753RNcwOga4Ukdy3G1x/HIY
        0ubhQNOHp+w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0C253BBA46;
        Tue, 23 Feb 2021 12:33:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 87762BBA45;
        Tue, 23 Feb 2021 12:33:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shubham Verma <shubhunic@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 00/10] Modernizing the t7001 test script
References: <20210211194704.28913-1-shubhunic@gmail.com>
        <xmqqk0rewa82.fsf@gitster.c.googlers.com>
        <CAD=kLptZS28NH53qEQ48eD7yT-GZ4Xx4Uc4oGAJD-g_UwQFRUg@mail.gmail.com>
Date:   Tue, 23 Feb 2021 09:33:36 -0800
In-Reply-To: <CAD=kLptZS28NH53qEQ48eD7yT-GZ4Xx4Uc4oGAJD-g_UwQFRUg@mail.gmail.com>
        (Shubham Verma's message of "Tue, 23 Feb 2021 13:56:15 +0530")
Message-ID: <xmqqft1m4rkf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 42F90F68-75FD-11EB-8180-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shubham Verma <shubhunic@gmail.com> writes:

> Hello Junio,
>
> I already corrected the author-name spelling in this v3 series
> but I looking at the last "What's Cooking" message and saw that
> Modernizing the t7001 test script series described as
> "Expecting the final version with corrected author attribution".

I looked at it on Feb 12 and requeued already, but the entry in the
what's cooking report was left stale by mistake.

Thanks for pinging.
