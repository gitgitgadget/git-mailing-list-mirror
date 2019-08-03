Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A2A91F731
	for <e@80x24.org>; Sat,  3 Aug 2019 14:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfHCOsW (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Aug 2019 10:48:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63415 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfHCOsW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Aug 2019 10:48:22 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CADE617405E;
        Sat,  3 Aug 2019 10:48:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pRZ4dZngvdbyJZwNOCZHSkPUKc8=; b=tcgDJ4
        38uwh4uCkiN338eawMMzDyWRyi0B2qgTTfAmUryLPlL+gkpvDmaZ09p2tY4baP8+
        6y8dD+FxW82muYD1ATe/3Q8m18eUEtEOku9n5BVdzBpcTcCIUc6eAXBmtH5GvnAj
        NTGzbShEY7vQ8vuFW5DvLsuUa4e8gfb4ElZjg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PZdpr6xBmBB9KD2TpltLPQpCBrAV7yRx
        ChTHtNJ7L9w/eb3kp6jZaabQCHOe3Yac74b3e/vDX564efrYaxPtPBkvf/4l2Cd2
        5xxv8Fo+EVCsPFLLbmQ9wcSGOTefS75xGNr1bolWmwbd70tZyp5147+ivGiCrF85
        g2IR8XZV8kE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BFA8F17405D;
        Sat,  3 Aug 2019 10:48:21 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 37DE517405C;
        Sat,  3 Aug 2019 10:48:21 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Mark Rushakoff via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/1] Fix two documentation typos
References: <pull.304.git.gitgitgadget@gmail.com>
Date:   Sat, 03 Aug 2019 07:48:20 -0700
In-Reply-To: <pull.304.git.gitgitgadget@gmail.com> (Mark Rushakoff via
        GitGitGadget's message of "Fri, 02 Aug 2019 22:33:50 -0700 (PDT)")
Message-ID: <xmqqsgqii9u3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BCEBDDE4-B5FD-11E9-B929-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Mark Rushakoff via GitGitGadget" <gitgitgadget@gmail.com> writes:

> I noticed a couple typos while reading through some manpages. 
>
> First was "...if it is does not..." which just contained an extraneous "is".

Thanks.

> Then I noticed a "can not" and updated that and other occurrences in
> Documentation to cannot. The glossary sentence with "can not" was
> "Consequently, an object can not be changed." To me, that reads like "it is

Hmph, I am not a native speaker, but I have to say that this is the
first time I heard that "I can not drive" to mean "I have a choice
of not driving (even though I am capable of driving)".

