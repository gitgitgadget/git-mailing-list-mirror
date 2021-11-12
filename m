Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE8BC433EF
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 04:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61EFB60E9B
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 04:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbhKLEqq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 23:46:46 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61702 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhKLEqp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Nov 2021 23:46:45 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4D3511679CA;
        Thu, 11 Nov 2021 23:43:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=vB3PcdE59Z5KrkHfZHVd6zzAmSeMjNWN0JHKD3rHWxY=; b=pa/3
        rUuOIfDNRnyyfgjPunptEITO07dpFaky5KixoQdftxtqGkV3IH5skyoKRd/g074Y
        D3yIUme0n8w/cprw0CIg5Gue+ihkAd25s+/Lwgf7f+WRHcGSrOMDNTOcX37hBdGL
        +VhQZpu9pMvOI1mC/90amHXuZFcGf16IrVDFk0s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 460931679C9;
        Thu, 11 Nov 2021 23:43:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A8D201679C8;
        Thu, 11 Nov 2021 23:43:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Ivan Frade via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Ivan Frade <ifrade@google.com>
Subject: Re: [PATCH v7 0/2] fetch-pack: redact packfile urls in traces
References: <pull.1052.v6.git.1635532975.gitgitgadget@gmail.com>
        <pull.1052.v7.git.1636588289.gitgitgadget@gmail.com>
Date:   Thu, 11 Nov 2021 20:43:51 -0800
Message-ID: <xmqq35o2j854.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 22E006C0-4373-11EC-9D10-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ivan Frade via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Changes since v6:
>
>  * Use specific hash sizes instead of hexsz
>  * Remove unnecessary env vars in tests
>  * Added comment on bit toggle
> Ivan Frade (2):
>   fetch-pack: redact packfile urls in traces
>   http-fetch: redact url on die() message

Thanks, will queue.
