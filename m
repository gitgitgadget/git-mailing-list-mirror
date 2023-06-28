Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8C8EB64DA
	for <git@archiver.kernel.org>; Wed, 28 Jun 2023 22:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjF1Wvb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jun 2023 18:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjF1Wup (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2023 18:50:45 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B9835A6
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 15:47:48 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 779EA27301;
        Wed, 28 Jun 2023 18:47:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Yy4ca7p4ccmaVffgAS2+jgOtw+3Sy9FJDqr1Yp
        qkjHo=; b=m8dfVeTT1VORpqxumIgqwG4hI3woEC5Oz5QEfs5hbZQo0fgPueICy9
        UXPl0Qig6JIRDU69twGYFc10vf7dSFy37A14ZidQXLyUJHJ9aEKpnuKJOCkhEKcs
        CwA2Zm/sgHzHMynmByIxWhcas9rburK2/4jWnCxlbcsmZX6qqbD/s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 70A9F27300;
        Wed, 28 Jun 2023 18:47:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1ADEF272FF;
        Wed, 28 Jun 2023 18:47:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Emily Shaffer <nasamuffin@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v5 00/11] config: remove global state from config iteration
References: <20230628222326.116535-1-jonathantanmy@google.com>
Date:   Wed, 28 Jun 2023 15:47:42 -0700
In-Reply-To: <20230628222326.116535-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Wed, 28 Jun 2023 15:23:26 -0700")
Message-ID: <xmqqa5wjb3w1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CB9554E4-1605-11EE-AF11-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> As promised, this version addresses the comments on v3.
>> 
>> = Changes since v4
>> 
>> - Squash 6-7/12 since `test_must_fail` doesn't catch BUG()
>> - Move a hunk to later in the series where it belongs
>> - Replace a memcpy with `*a = *b`
>> 
>> = Changes since v3
>> 
>> - Rebase onto newer 'master'
>> - Move the 'remove UNUSED from tr2_cfg_cb' hunk from 9/12 -> 8/12. It should
>>   have been there all along; v3 8/12 didn't build at all.
>
> Looks like all my comments have been addressed, so this patch set looks
> good to me.

Thanks.  Queued.
