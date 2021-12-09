Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8580CC433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 01:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238383AbhLIBGO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 20:06:14 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64024 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233885AbhLIBGM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 20:06:12 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 38120ED76B;
        Wed,  8 Dec 2021 20:02:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=ZYnQA4+PSxQThK9t9OhFnobX8OaklIAfUJ68N9Zfg3M=; b=qe5I
        iZCtoc2n5WwxHXSkXyRhfJBbmh6FYiTgd/D02LmUGWffo6OrnUo1DwKBPpMu6JzW
        I0/pq6WZu+SI335p257muBOyvSc/hShJotAXFEPHFwIL2dbzBTbxF+iuq5LEdDqG
        wQZdbSAel/B32/2Yq1VVveMRd9oZNOCibDmw20k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2EAD3ED769;
        Wed,  8 Dec 2021 20:02:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4BE3CED768;
        Wed,  8 Dec 2021 20:02:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2021, #01; Fri, 3)
References: <xmqqh7bpqhf0.fsf@gitster.g>
        <e1aadd47-533c-fd8b-4fae-f64a53c81ec9@gmail.com>
        <nycvar.QRO.7.76.6.2112081340420.90@tvgsbejvaqbjf.bet>
Date:   Wed, 08 Dec 2021 17:02:37 -0800
Message-ID: <xmqqzgpavbde.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B3E213C0-588B-11EC-83B6-C48D900A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Dscho spotted a typo which I was going to correct with a re-roll but I've been
>> holding off in case he has time to read the rest of the series.
>
> I would have loved to give this a much more in-depth review, but the days
> have become short on the North hemisphere, haven't they.

I am puzzled. What does the length of a day have anything to do with
anything in this age?

> In any case, the patch series looks good to me (personally, I do not care
> so much about typos as long as they aren't indicator of sloppiness, which
> in this case they aren't, I find your patches really well done).

Thanks for an ack.  It's Phillip's turn to react ;-)

Thanks, both.


