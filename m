Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0C2C433E0
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 21:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5D6364E6E
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 21:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237006AbhBHV6N (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 16:58:13 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65179 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhBHV6D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 16:58:03 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D11B6A801B;
        Mon,  8 Feb 2021 16:57:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JaCIvEIBJ1+X/byPvIEovFafiGU=; b=oMei0x
        BuYXHH3sgSW2H0APic294lBiwf5M5nE3Mq3nO27V/BG/JBgRi1CFBRlUdfc4xJ97
        UIrhteGm9X3+GUNTm5JAofkkUgyRt/Ea/WylLHvqeMY2fcGI6dM7KoFHmC+Tp6vA
        QX+gQ1UNdXWBq+eumndS9WyGtW4MgY0NZo8EY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=P00TH9vLcQ4UcWoq07G2UK/yJbfArCKr
        pqPIngfSMb9yUbp7NuU3pvFM80sBVofcVTdIu07WqZewOcQwND3c/d0hLKXZvH7t
        tnigeqCPMTCyrilnfwGtfiXgLM32kLizBBK0cvitu3k9a1C10hw9p/VFvvhXCbxZ
        1N6P/rj7Mr4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C9259A801A;
        Mon,  8 Feb 2021 16:57:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4D067A8019;
        Mon,  8 Feb 2021 16:57:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com,
        christian.couder@gmail.com, phillip.wood123@gmail.com
Subject: Re: [PATCH v2 00/11][Outreachy] Improve the 'fixup [-C | -c]' in
 interactive rebase
References: <20210207181439.1178-1-charvi077@gmail.com>
        <20210208192528.21399-1-charvi077@gmail.com>
Date:   Mon, 08 Feb 2021 13:57:19 -0800
In-Reply-To: <20210208192528.21399-1-charvi077@gmail.com> (Charvi Mendiratta's
        message of "Tue, 9 Feb 2021 00:55:18 +0530")
Message-ID: <xmqqsg664400.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9DE06512-6A58-11EB-B745-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Charvi Mendiratta <charvi077@gmail.com> writes:

> This patch series is build on the top of "cm/rebase-i" in the 'next' branch and
> improves it. It fixup the source code of 'fixup [-C | -c]' command in the
> sequencer, do some fixes in rebase -i, improves the 'fixup_-C' like commands
> in lib-rebase.sh, update the test-script 't3437' and fixes a typo in the
> documentation.

Thanks.  I saw a couple of minor nits, but overall it was a pleasant
read.

