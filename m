Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0B0E78495
	for <git@archiver.kernel.org>; Sun,  1 Oct 2023 22:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235427AbjJAV5K (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Oct 2023 17:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235414AbjJAV5J (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2023 17:57:09 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2244BC9
        for <git@vger.kernel.org>; Sun,  1 Oct 2023 14:57:07 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 50805245BD;
        Sun,  1 Oct 2023 17:57:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=DICZ7pQ+25GYfF/6MhM68IXwF8XQOL7Qav/0xO
        LX91E=; b=Sm4UJcF0ZfiWoe6y7OwAD/CIbKl87X5hUFfU90igVv4da0E4+so7Xd
        55aEiSnC+T3SsEJEDYCv5s8wUVc4xn+0+AKlVknoZKeVG125NuRiTIAGFcBZDU0I
        2LSyFc0/RaXCkX0dFblIGEqH/YA3sRalxmpEXvl2Pyo3YgJZK+gOA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 48BB2245BB;
        Sun,  1 Oct 2023 17:57:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AC040245B7;
        Sun,  1 Oct 2023 17:57:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "cousteau via GitGitGadget" <gitgitgadget@gmail.com>,
        Josh Soref <jsoref@gmail.com>
Cc:     git@vger.kernel.org, cousteau <cousteaulecommandant@gmail.com>
Subject: Re: [PATCH] git-status.txt: fix minor asciidoc format issue
In-Reply-To: <pull.1591.git.1696193527923.gitgitgadget@gmail.com> (cousteau
        via GitGitGadget's message of "Sun, 01 Oct 2023 20:52:07 +0000")
References: <pull.1591.git.1696193527923.gitgitgadget@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date:   Sun, 01 Oct 2023 14:57:01 -0700
Message-ID: <xmqq7co6f1le.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 74019D10-60A5-11EE-BECF-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"cousteau via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Javier Mora <cousteaulecommandant@gmail.com>
>
> The paragraph below the list of short option combinations
> isn't correctly formatted, making the result hard to read.

In <pull.1590.git.1695392082207.gitgitgadget@gmail.com>, Josh fixed
this issue a bit differently but in the same spirit, and the fix in
38a15f47 (Documentation/git-status: add missing line breaks,
2023-09-22) is about to hit the 'master' branch.

Thanks.

[Reference]

* https://lore.kernel.org/git/pull.1590.git.1695392082207.gitgitgadget@gmail.com/

