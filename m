Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37E5C433EF
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 20:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349233AbiARU1T (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 15:27:19 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61668 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349231AbiARU1K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 15:27:10 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E48E617DD6A;
        Tue, 18 Jan 2022 15:27:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GrIwDVrp251VSxCv1rPi/LaySRzBf34tPLvBap
        gQwTc=; b=tvB0s+velYzpb51ep9qRZXHfCy14BYSGXDNI+iSa/w3oBF3jZCNGy4
        IrjET/CMbvCP0pjyTpXXMc8D7M39GBWjajHNBDas2HJ4govDXtJ9VRz5oQmR6L1E
        5DIIH1ilDcF7envtdszjHW7hGYDCpvMNQRyFmrfT9BpzrFteRYflM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DC36317DD69;
        Tue, 18 Jan 2022 15:27:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 52AD817DD65;
        Tue, 18 Jan 2022 15:27:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: ds/sparse-checkout-requires-per-worktree-config (was Re: What's
 cooking in git.git (Jan 2022, #04; Fri, 14))
References: <xmqqy23h4nss.fsf@gitster.g>
        <a876f4e0-e3b3-d3a3-e469-927669622119@gmail.com>
Date:   Tue, 18 Jan 2022 12:27:05 -0800
In-Reply-To: <a876f4e0-e3b3-d3a3-e469-927669622119@gmail.com> (Derrick
        Stolee's message of "Tue, 18 Jan 2022 11:08:20 -0500")
Message-ID: <xmqq8rvcssbq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 00FEA0C0-789D-11EC-A610-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 1/14/2022 11:37 PM, Junio C Hamano wrote:
>
>> * ds/sparse-checkout-requires-per-worktree-config (2022-01-14) 6 commits
>>  - worktree: copy sparse-checkout patterns and config on add
>>  - sparse-checkout: use repo_config_set_worktree_gently()
>>  - config: add repo_config_set_worktree_gently()
>>  - worktree: add 'init-worktree-config' subcommand
>>  - config: make some helpers repo-aware
>>  - setup: use a repository when upgrading format
>> 
>>  "git sparse-checkout" wants to work with per-worktree configration,
>>  but did not work well in a worktree attached to a bare repository.
>> 
>>  Expecting an update.
>>  cf. <1db0f601-4769-15c0-cd58-ecddfa1fc9d5@gmail.com>
>>  source: <pull.1101.v3.git.1640727143.gitgitgadget@gmail.com>


> Sorry for the delay. I've spent the last two weeks with my
> family under quarantine for COVID.
>
> I will update this topic this week.

Sorry to hear that.  I hope everybody is not hurt too badly.

Take your time, be safe and be well.

Thanks.
