Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78977C433EF
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 01:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiC2BDg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 21:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiC2BDe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 21:03:34 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B0F23FF05
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 18:01:49 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 304B41016D5;
        Mon, 28 Mar 2022 21:01:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QdpQouPTzwLhJIanNvuFh7DAS7XKXx5qQBZTxh
        t//Kk=; b=VVC+VINSa+Upb/Q0LHPwchGvZmcjZKCZQCOAm563QeqcmOJgk6mVw+
        iPfAo9SdUmR8aCsRIKxqd6MbHAm+BPorXQQcMkTTtHgFTGj3W0VAlU2KzQ0RS8O3
        WJ42KXx02OwYuswPFts8HX9dK4Rl2fOnfo9Ir9LiGH+ju2spcgNcQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1DF231016D4;
        Mon, 28 Mar 2022 21:01:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7765C1016D3;
        Mon, 28 Mar 2022 21:01:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fernando Ramos <greenfoo@u92.eu>
Cc:     git@vger.kernel.org, davvid@gmail.com, sunshine@sunshineco.com,
        seth@eseth.com, levraiphilippeblain@gmail.com,
        rogi@skylittlesystem.org, bagasdotme@gmail.com
Subject: Re: [PATCH v7 3/4] vimdiff: add tool documentation
References: <20220328223019.271270-1-greenfoo@u92.eu>
        <20220328223019.271270-4-greenfoo@u92.eu>
        <YkI5Afkyr9H6teMw@zacax395.localdomain>
Date:   Mon, 28 Mar 2022 18:01:45 -0700
In-Reply-To: <YkI5Afkyr9H6teMw@zacax395.localdomain> (Fernando Ramos's message
        of "Tue, 29 Mar 2022 00:39:08 +0200")
Message-ID: <xmqqy20ty3k6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CE6FABBE-AEFB-11EC-B0D1-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fernando Ramos <greenfoo@u92.eu> writes:

> When applying this patch I still get "indent with spaces" errors:
>
>     .git/rebase-apply/patch:121: indent with spaces.
>                ------------------------------------------
>     .git/rebase-apply/patch:122: indent with spaces.
>                |             |           |              |
>     .git/rebase-apply/patch:123: indent with spaces.
>                |             |           |              |
>     .git/rebase-apply/patch:124: indent with spaces.
>                |   LOCAL     |   MERGED  |   REMOTE     |
>     .git/rebase-apply/patch:125: indent with spaces.
>                |             |           |              |
>     warning: squelched 61 whitespace errors
>     warning: 66 lines add whitespace errors.
>
> The thing is these are no real errors (I really want to use spaces here).
>
> Am I doing something wrong?

Yes, the project does not want you to use spaces here.  Doesn't
AsciiDoc do the right thing if you used a tab instead of indenting
with 8 spaces?
