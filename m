Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA962C433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 23:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbiBXXG7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 18:06:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiBXXG6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 18:06:58 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054CD270253
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 15:06:27 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A88A518426E;
        Thu, 24 Feb 2022 18:06:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=b4cky0GQFqd7g8dLTrUFk7JNvYyHu3+F+UBPtS
        bcgLM=; b=YRme8AmdMpD8Zkt/B+KClu91Ig34pa33F0wf1mLNfxLlwKgVEbkNiX
        0+cGJXVXrXM2tnuUzU3pFYXB3NxqBKt8pbpVTbbGzVvXrXXMe4eC3igd6dwHTcVE
        rBeYy0bg9pWWS1qFDfrcZqMNfPYEbKOTdF3aqRov8AaaY3U8HtB3o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A170F18426D;
        Thu, 24 Feb 2022 18:06:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E3E6318426C;
        Thu, 24 Feb 2022 18:06:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/7] Commit-graph: Generation Number v2 Fixes, v3
 implementation
References: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
        <xmqqsfs8j60g.fsf@gitster.g>
Date:   Thu, 24 Feb 2022 15:06:22 -0800
In-Reply-To: <xmqqsfs8j60g.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        24 Feb 2022 13:42:39 -0800")
Message-ID: <xmqqwnhjj24x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 630C871E-95C6-11EC-BD2F-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> I'm submitting these two things together so we can see them all at once, but
>> I'd be happy to split this into two series. The first four patches are
>> important bug fixes, so we can consider them as higher-priority.
>>
>> Thanks, -Stolee
>
> Thanks, will take a look.

Overall it was a pleasant read, even though my reading hiccupped in
a few places.  It does look like two separate topics, one of which
builds on the other.
