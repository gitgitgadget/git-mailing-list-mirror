Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C482FC433F5
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 21:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98C4F6109F
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 21:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbhKEVsb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 17:48:31 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60122 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbhKEVs3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 17:48:29 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0E195150F91;
        Fri,  5 Nov 2021 17:45:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OZn+TMdamOqSKOevJOgCpYrsCRvMSFntbAL9dV
        MR2bQ=; b=Lsr2XUhAFSjbEA2UaATSyKI7tDPPN4vutlLT9+uc5qMQwmsU31OotH
        gqqmzG20kIRv4MBQ0eHmZXCc6Tfi2CkREbbSIJ48qTbdIS85PXaEGHtvHrihRiSr
        jUWkdr4ec5V/jQckvoC/SV4XAKwjmMVEIL8knKKXGKWa8CTk0NNh4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 06A95150F90;
        Fri,  5 Nov 2021 17:45:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B0F34150F8F;
        Fri,  5 Nov 2021 17:45:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, philipoakley@iee.email,
        eschwartz@archlinux.org, Carlo Arenas <carenas@gmail.com>,
        Jeff King <peff@peff.net>, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2] async_die_is_recursing: work around GCC v11.x issue
 on Fedora
References: <pull.1072.git.1635990465854.gitgitgadget@gmail.com>
        <pull.1072.v2.git.1635998463474.gitgitgadget@gmail.com>
        <xmqqzgqk2zsl.fsf@gitster.g>
Date:   Fri, 05 Nov 2021 14:45:44 -0700
In-Reply-To: <xmqqzgqk2zsl.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        03 Nov 2021 23:35:54 -0700")
Message-ID: <xmqqfssawa2f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BB66A3E6-3E81-11EC-B70E-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Thanks for coming up with a clearly written description and a clean
> fix so quickly.
>
> Will apply.

FWIW, this is now in all my integration branches that may trigger CI
tests.  Again, thanks for a quick fix.

