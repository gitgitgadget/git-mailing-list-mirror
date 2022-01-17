Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9E1C433F5
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 19:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242803AbiAQTL1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jan 2022 14:11:27 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61886 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242794AbiAQTLZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jan 2022 14:11:25 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9059010FE77;
        Mon, 17 Jan 2022 14:11:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HHx+opTjhpNVQmQSKrddhE5WFcJyp+b0FJOkbF
        rqSnQ=; b=ZZULAms7M8poDdgCEA2HLCTiHfAnRYAcQjgXtX1D37BzByqsPnmCfR
        r8Rt0WHjcPb4d22WFt+h5LPVsl1fdior/QPGcwpfVJMCCYnU4KPycednxcZj9RKK
        0w9CUJJMDpRSAe47VmtPA5hBZUIOaw8lv+sZqgJMlxIJ/m29PXAds=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8862510FE75;
        Mon, 17 Jan 2022 14:11:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E8D7410FE74;
        Mon, 17 Jan 2022 14:11:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH 4/7] reftable: avoid writing empty keys at the block layer
References: <pull.1185.git.git.1642010868.gitgitgadget@gmail.com>
        <e4c1cc58265ca7ae7b32b9faf41324883011d1a6.1642010868.git.gitgitgadget@gmail.com>
        <xmqqpmovds5q.fsf@gitster.g>
        <CAFQ2z_NLauUqf8FdWbQVxVmqx5xQ11E5t5SwDDyKyLSa9QU8KA@mail.gmail.com>
Date:   Mon, 17 Jan 2022 11:11:22 -0800
In-Reply-To: <CAFQ2z_NLauUqf8FdWbQVxVmqx5xQ11E5t5SwDDyKyLSa9QU8KA@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Mon, 17 Jan 2022 14:10:42 +0100")
Message-ID: <xmqqlezeuqhx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 431C3DF2-77C9-11EC-8D99-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

>> I see that the hn/reftable-coverity-fixes topic, which the commit is
>> a part of, has been expecting a reroll since last year---are you
>
> I sent a reroll on Jan 12. As that has had more scrutiny, it's best if
> that lands first. This series is less urgent.

Hmph, it probably was missed during pre-release freeze.

https://lore.kernel.org/git/e16bf0c5212ae85daa0d6aa2c78d551824b542bd.1640199396.git.gitgitgadget@gmail.com/

not showing the updated ones did not help, either but stuff outside
the upcoming release are not urgent right now, so it is OK.

Thanks.


