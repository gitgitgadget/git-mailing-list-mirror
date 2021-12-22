Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8ECC433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 22:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242070AbhLVWvf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 17:51:35 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54353 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242039AbhLVWvf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 17:51:35 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0F4CA162698;
        Wed, 22 Dec 2021 17:51:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=JH/Q8foo3jNKSXr8UgrhgA0ox78/wLzLtyPPrHjEiqY=; b=iH9t
        Tg1zsSxAi2qkcDnLFhEqoRnfk3CMDTN5qCq2E+zaFKbFX/rIhWnfocgT3yzRfMuz
        8eMnMF/aL7noB1HDsy0jvlv7rX7/i3Eg9hPCXByxyv2Jsvc1EZNnsSNB7sfSDw+F
        eM7ljPfpjHSDhx4jOSOW3K2yoSeFq2FS0HZ+A7c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 06E23162697;
        Wed, 22 Dec 2021 17:51:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 69004162695;
        Wed, 22 Dec 2021 17:51:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v5 00/16] Reftable coverity fixes
References: <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
        <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
Date:   Wed, 22 Dec 2021 14:51:30 -0800
Message-ID: <xmqq1r24fe31.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B4A33020-6379-11EC-AE0F-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This series was targeted to 'next'.
>
> This addresses some complaints from Coverity that Peff reported.
>
> v5:
>
>  * add generic record equality
>  * add generic record printing
>  * const correctness for record-reftable.h
>  * fix windows crash.
>  * 0-length memcpy paranoia
>  * drop unused file.

Thanks.  Will replace.
