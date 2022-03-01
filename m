Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD826C433FE
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 19:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiCATHz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 14:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiCATHx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 14:07:53 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4EA3E0FB
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 11:07:12 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D6F1318D480;
        Tue,  1 Mar 2022 14:07:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=o5blSqXm4Fb5fub7tBS1UOAjDN8HJlgU2i3n1q
        9YYW8=; b=FHdNqMu9dK+/21RPzXalsRZhKoLKthAjg3lcp/nhcy0pDXOSVJY6Im
        aW6vEtWlUgkdiaYB4eBQV/siGzmDcLaF12qz+zglUKGNP9M3F9s2MnRrw8lBvd47
        91KVt7lUiPnbg1rXg8hT4Mj1t71d6/Sl23SOYeCBsJwQYK/WkQvFs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D018518D47F;
        Tue,  1 Mar 2022 14:07:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4E91B18D47D;
        Tue,  1 Mar 2022 14:07:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/9] ci: make Git's GitHub workflow output much more
 helpful
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
        <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com>
Date:   Tue, 01 Mar 2022 11:07:08 -0800
In-Reply-To: <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Tue, 01 Mar 2022 10:24:40
        +0000")
Message-ID: <xmqqy21tpk4j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CB1A0DC0-9992-11EC-A881-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Changes since v1:
>
>  * In the patch that removed MAKE_TARGETS, a stale comment about that
>    variable is also removed.
>  * The comment about set -x has been adjusted because it no longer applies
>    as-is.
>  * The commit message of "ci: make it easier to find failed tests' logs in
>    the GitHub workflow" has been adjusted to motivate the improvement
>    better.

Will queue.  Thanks.
