Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B14AC433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 17:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D27560E52
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 17:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbhINRtW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 13:49:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63038 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbhINRtO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 13:49:14 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1F038DD960;
        Tue, 14 Sep 2021 13:47:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xzJtaZoD+MuHyeB8cMjkszcVylXIZR9cjl4YUj
        p2eXA=; b=qMlX0LzSxpSIbzGGdt4+HeYB7sRese3ibHlH0Goxde5khdo8xIFatm
        uU+bumy1OQWCfCXFGyKc0EBH1X9AQB9aCOTgYUrYGQs3AVQpyzQurqylM2Mrw4jN
        7sUf3S2sU+h115XMPs3DWPfbz4vpz8qVPwn4uFyOdkHFzsey+J6rk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 15AB2DD95D;
        Tue, 14 Sep 2021 13:47:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 95E0EDD95C;
        Tue, 14 Sep 2021 13:47:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2021, #04; Mon, 13)
References: <xmqqtuinc3tx.fsf@gitster.g>
        <88bb51c3-b5ab-77df-f9fb-b9252c2b0fa6@gmail.com>
Date:   Tue, 14 Sep 2021 10:47:55 -0700
In-Reply-To: <88bb51c3-b5ab-77df-f9fb-b9252c2b0fa6@gmail.com> (Derrick
        Stolee's message of "Tue, 14 Sep 2021 09:33:29 -0400")
Message-ID: <xmqq7dfj2gms.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E445A216-1583-11EC-85ED-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> Perhaps this would be a good summary?
>
>   "git add", "git mv", and "git rm" have been adjusted to avoid
>   updating paths outside of the sparse-checkout definition unless
>   the user specifies a "--sparse" option.

Let me steal that.  A correction to the topic summary like this is
very much appreciated.
