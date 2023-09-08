Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADFEEEB570
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 21:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344646AbjIHV5m (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 17:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245413AbjIHV5l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 17:57:41 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7841DC
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 14:57:37 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0D37A1B0D35;
        Fri,  8 Sep 2023 17:57:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=MLAt+9XRO6EYao0YXIJkTiFh0cWNIdxeFi/V/Y
        i1JLA=; b=ULRAb/zJenYmc2F0Cwkr+5DZvekt1vyM4iqj7fVNxPaig/v15OAPUQ
        1+HbrFwQjoezhnv1VIoFFNaSpc9CIg1Usy7VRVCwwXVPXF2ylu1MtCnTEwYT3Rpe
        KNy2fwDtMfXiXrKOtdpDZydjLLOhFbWqNlDRti0udKK/+AQyKza7U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 055F71B0D34;
        Fri,  8 Sep 2023 17:57:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 698421B0D33;
        Fri,  8 Sep 2023 17:57:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Linus Arver <linusa@google.com>
Subject: Re: [PATCH v3 09/13] trailer --parse docs: add explanation for its
 usefulness
In-Reply-To: <ef6b77016cd50c438fb58d79ffb10f748ddc5244.1694125210.git.gitgitgadget@gmail.com>
        (Linus Arver via GitGitGadget's message of "Thu, 07 Sep 2023 22:20:05
        +0000")
References: <pull.1564.v2.git.1691702283.gitgitgadget@gmail.com>
        <pull.1564.v3.git.1694125209.gitgitgadget@gmail.com>
        <ef6b77016cd50c438fb58d79ffb10f748ddc5244.1694125210.git.gitgitgadget@gmail.com>
Date:   Fri, 08 Sep 2023 14:57:35 -0700
Message-ID: <xmqq7cp0s4z4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B89BD9D8-4E92-11EE-9FD0-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  --parse::
>  	A convenience alias for `--only-trailers --only-input
> -	--unfold`.
> +	--unfold`. This makes it easier to only see the trailers coming from the
> +	input without influencing them with any command line options or
> +	configuration variables, while also making the output machine-friendly with
> +	--unfold.

Nicely explained.  Without a concise explanation like this, it is
hard to see what the value of the "convenience" alias actually is.
