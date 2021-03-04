Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15C7C433DB
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 23:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B99764FF0
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 23:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbhCDXiI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 18:38:08 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52021 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbhCDXiG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 18:38:06 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 186A0A9384;
        Thu,  4 Mar 2021 18:38:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=869pLbXZjIOKJQwY1zNwV3FH9Fw=; b=EheR//
        rIEkTHYBqWrejAURmcYpM5/DHnvQv6WSrYSRgMUoVYtkYg2I11CekEi2vQ/nAPaU
        gI3cdJWFTkH/8sgrULz590f9Kon4eN6OaNqZ7QCnOZIahoZkU0zBW69Ey6j5fdkU
        itRry7goZGZqthM9qV4trouf+mBxXUWLt1XeI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=s/VvBcFWvR4Fj1NCcE/twz2NdhOYsA5k
        LTeJ9FxD/1XRLHZGSuxU3i/CRG9MNWvkWB6kGZDL3OWjElQ8jFLuBtGhKL0JEBVq
        8O34PWv9OUey312Qzc7CfPPYn5/RX26bJJQDs1ii2mToSrA7zpOOEBuhP1d14C9P
        G3INcucF6vw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 10FDEA9383;
        Thu,  4 Mar 2021 18:38:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6FB2EA9381;
        Thu,  4 Mar 2021 18:38:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] Documentation/RelNotes: improve release note for rename
 detection work
References: <pull.974.git.git.1614898292503.gitgitgadget@gmail.com>
Date:   Thu, 04 Mar 2021 15:38:04 -0800
In-Reply-To: <pull.974.git.git.1614898292503.gitgitgadget@gmail.com> (Elijah
        Newren via GitGitGadget's message of "Thu, 04 Mar 2021 22:51:32
        +0000")
Message-ID: <xmqqpn0ebicj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AAFDE95C-7D42-11EB-A38C-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> The former wording could be seen as hinting that more performance
> improvements will come in 2.32, which is true, but ...

It is somewhat dissappointing to hear that, as the above "hinting"
was exactly what I wanted to achieve by leaving "continues" in
there.

Will queue, though.
