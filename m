Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43775C43334
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 19:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236407AbiGYTDK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 15:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236398AbiGYTDJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 15:03:09 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFC81DA6E
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 12:03:09 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8632B1353CE;
        Mon, 25 Jul 2022 15:03:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gIgsLEVSlSSguwtX6AdyQ1kNvxxEAuPesUokJL
        SaSrU=; b=RmZ6oSRF6IU3zMVjFM831fdrNVHqWsI1DyrKWfEjKAzLTEUYPKbIfw
        Di2jbKRBwBhR6yYSclxHMSriSX0bPXoFtDd9cc09v6J6zKJJHZU7xCmLj6vVODzR
        OZsf06Pt/mqN+3eAOqT1fv2ZIpjPk8a7L1u0pV+X9Fsz29fi83MKE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6B5941353CD;
        Mon, 25 Jul 2022 15:03:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 832C51353CA;
        Mon, 25 Jul 2022 15:03:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, ZheNing Hu <adlternative@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v5 0/8] Fix merge restore state
References: <pull.1231.v4.git.1658466942.gitgitgadget@gmail.com>
        <pull.1231.v5.git.1658541198.gitgitgadget@gmail.com>
Date:   Mon, 25 Jul 2022 12:03:02 -0700
In-Reply-To: <pull.1231.v5.git.1658541198.gitgitgadget@gmail.com> (Elijah
        Newren via GitGitGadget's message of "Sat, 23 Jul 2022 01:53:10
        +0000")
Message-ID: <xmqqh7353ti1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 698319F8-0C4C-11ED-A45E-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This started as a simple series to fix restore_state() in builtin/merge.c,
> fixing an issue reported by ZheNing Hu[3]. It now fixes several bugs and has
> grown so much it's hard to call it simple. Anyway...

Thanks.  Unless we hear any more comments, let's start merging it
down to 'next' soonish.

