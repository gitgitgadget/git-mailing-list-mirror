Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF5FC433EF
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 19:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243321AbiAJTL5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 14:11:57 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50962 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240681AbiAJTL4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 14:11:56 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4EF8C17F2F5;
        Mon, 10 Jan 2022 14:11:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xjdhTm5zraqCmC3ru1DcBtXkWStcx7IOfvZGSG
        O21VE=; b=idnkgAOMg1mv6hs/E4dU4ISWvs/yh+/p9J8jwvHF4xgEtR1cppHUiB
        I0NsGB9yjJAeKo1B5avOlXMx3xOlaq+lf03SiTp27EAlRF/QYZUBAXcpRINWkmfI
        IgWQzBlfyFDIxXQ3FuJHWidKgbrDzi/gIsAaN2hgLZC/lFEQiqPaw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4748317F2F4;
        Mon, 10 Jan 2022 14:11:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B392017F2F3;
        Mon, 10 Jan 2022 14:11:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     John Cai <johncai86@gmail.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood123@gmail.com
Subject: Re: [PATCH v7 1/2] name-rev: deprecate --stdin in favor of
 --annotate-stdin
References: <pull.1171.v6.git.git.1641423600.gitgitgadget@gmail.com>
        <pull.1171.v7.git.git.1641425372.gitgitgadget@gmail.com>
        <153f69ea9b6cfc3fff47c91fa237cf97efd6bfae.1641425372.git.gitgitgadget@gmail.com>
        <56FFAD1E-D081-4D13-A12E-DD6807375B69@gmail.com>
        <xmqqo84j1oel.fsf@gitster.g>
        <A869C5DC-98D0-4093-90ED-5F7933041968@gmail.com>
Date:   Mon, 10 Jan 2022 11:11:52 -0800
In-Reply-To: <A869C5DC-98D0-4093-90ED-5F7933041968@gmail.com> (John Cai's
        message of "Mon, 10 Jan 2022 14:01:06 -0500")
Message-ID: <xmqqo84jz9qf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2BF877A6-7249-11EC-9FCD-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

John Cai <johncai86@gmail.com> writes:

>> As I said, my mention of hidden vs non-hidden was not my preferrence
>> of non-hidden over hidden, but was soliciting opinions from others,
>> so I was a bit surprised to see a reroll to change only that thing
>> and nothing else so soon.
>>
>> But if it is your preference to leave it unhidden for now, that is
>> fine as well.  I have no strong preference over the matter either
>> way.
>
> I think it makes sense in this first iteration to keep it
> non-hidden for visibility purposes.  Maybe in the next release we
> can make it hidden before we move it altogether.

I think that is a sensible way forward.


