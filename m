Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9718FC433E6
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 19:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E89C64EC3
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 19:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbhBATuZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 14:50:25 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58449 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbhBATtI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 14:49:08 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A44B3B34EC;
        Mon,  1 Feb 2021 14:48:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=T/a/m/vG9DAhP6x2IvLuw5duvns=; b=Tvf0Jj
        T3mJI5i+WDgDbPcW9S1F7+cKOPX8qg9QMMUBcU87o9Z41WKN1A8GY47XnIJn+iEP
        f9Ue0BRV4up0VXMUiwECuj1QHwzTIXgfLW9e5ve7Lt52T/K2VlVZAyah7LdAxcJ5
        rZbMgxep/3qKpnIge/T/ghI7v9MlqLxdI8rg0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NC/ylmGippTmtUa4wti7X2YmzyD698VU
        DfyJa3eSgCBBlbFcEGhVV3W1FEn+TE4dK0/B06V/x1bpf35y0UKE95HpBJisBLlC
        RygB0nZcRMNq9SFNbjtK4YRKGOMQ4SDSh7TMgRxLtxcHTWr3GmTVPcLWUL2eQLOd
        CNLEPSpZs/U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9BFD8B34EB;
        Mon,  1 Feb 2021 14:48:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 26FF6B34EA;
        Mon,  1 Feb 2021 14:48:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: What's cooking in git.git (Jan 2021, #06; Sat, 30)
References: <xmqqsg6infev.fsf@gitster.c.googlers.com>
        <CAPSFM5fLcSBmcGTLaPuoKKHO0qv3fKB5q-XvXv5emWfLYpFv=w@mail.gmail.com>
Date:   Mon, 01 Feb 2021 11:48:24 -0800
In-Reply-To: <CAPSFM5fLcSBmcGTLaPuoKKHO0qv3fKB5q-XvXv5emWfLYpFv=w@mail.gmail.com>
        (Charvi Mendiratta's message of "Mon, 1 Feb 2021 21:21:03 +0530")
Message-ID: <xmqqr1lzlgc7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7279449E-64C6-11EB-B69E-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Charvi Mendiratta <charvi077@gmail.com> writes:

> It seems that a lot of tests are failing in macOS.

That is caused by a separate topic, I think.

The mention of 3415 is a leftover from an older round, I think.  It
seems we have an all-green build of 'seen' with this topic in it.

Thanks.
