Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86D9C00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 21:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242194AbiHRVie (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 17:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241023AbiHRVic (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 17:38:32 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEC02AC6B
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 14:38:29 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2BAED13B9D1;
        Thu, 18 Aug 2022 17:38:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=I4G19/t8sI9w70qcuOxSp4eQA20u+TvUukv2TT
        HzLi0=; b=CHaDrbljia2kKmzcapEBo+R2aWE7W2GB1SpjIUzPURgtIfTwCm8fBC
        sy6TcFWO+HkSwdbFPSql5ywulElq0xywA8TJdKPbpogttmRdusRJd1n5f5jhN14k
        ksNqGdAIsD+bRtRL9iZ41cGDFsh01NMw1qCsJWaGws1DD2n8fC1kc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 230BA13B9D0;
        Thu, 18 Aug 2022 17:38:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8C63513B9CF;
        Thu, 18 Aug 2022 17:38:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH] fsmonitor: option to allow fsmonitor to run against
 network-mounted repos
References: <pull.1326.git.1660855703816.gitgitgadget@gmail.com>
        <xmqq5yipnsl6.fsf@gitster.g>
Date:   Thu, 18 Aug 2022 14:38:27 -0700
In-Reply-To: <xmqq5yipnsl6.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        18 Aug 2022 14:35:01 -0700")
Message-ID: <xmqq1qtdnsfg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 18FB5AF4-1F3E-11ED-A483-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Eric DeCosta <edecosta@mathworks.com>
>>
>> Though perhaps not common, there are uses cases where users have large,
>> network-mounted repos. Having the ability to run fsmonitor against
>> network paths would benefit those users.
>>
>> As a first step towards enabling fsmonitor to work ...
>
> Didn't we already see the first step and got it reviewed?  I think
> I've already merged the last round to 'next'.
>
> Puzzled...

Ah, OK, so this is not exactly the "first step", but builds on top
of the previous one?  At least the patch needs a better title to
make it distinguishable from the other one.

Will queue to wait for others to review.

Thanks.
