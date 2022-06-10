Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464DFC433EF
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 17:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346688AbiFJRBL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jun 2022 13:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240898AbiFJRBK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jun 2022 13:01:10 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CDF32ED4
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 10:01:08 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6166713DFD2;
        Fri, 10 Jun 2022 13:01:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0gJALlm66j2HUaffSlXvcgF2Ftw8c9PconfCrx
        NH8ts=; b=nph9+4chVgTV0kzCDb8rynUXf6FcGv7oB3ohrPOQaJMFKiHizMFMD6
        mMm1aH54eCrAzbFQFwlWif0o/WD+vZI5vHN2Qtl+wKxYtIgJuoU/2+5KJhEd90iv
        LODIhLQylNdlRsdepKOR0jPj/KELCx5ul4Gg0rZy4hfNEn0JWPMPY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 861E013DFD0;
        Fri, 10 Jun 2022 13:01:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D99B013DFCF;
        Fri, 10 Jun 2022 13:01:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH v3 0/3] bitmap-format.txt: fix some formatting issues
 and include checksum info
References: <pull.1246.v2.git.1654623814.gitgitgadget@gmail.com>
        <pull.1246.v3.git.1654858481.gitgitgadget@gmail.com>
Date:   Fri, 10 Jun 2022 10:01:02 -0700
In-Reply-To: <pull.1246.v3.git.1654858481.gitgitgadget@gmail.com> (Abhradeep
        Chakraborty via GitGitGadget's message of "Fri, 10 Jun 2022 10:54:38
        +0000")
Message-ID: <xmqq8rq4fo6p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EA12FE3A-E8DE-11EC-9A57-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> There are some issues in the bitmap-format html page. For example, some
> nested lists are shown as top-level lists (e.g. [1]- Here
> BITMAP_OPT_FULL_DAG (0x1) and BITMAP_OPT_HASH_CACHE (0x4) are shown as
> top-level list). There is also a need of adding info about trailing checksum
> in the docs.

Quite honestly, I am not sure if a piecemeal "let's make
<pre>...</pre> a bit prettier" is worth our time.  Especially
relative to the importance of adding missing information to the
documentation.

So, if this round (I haven't looked at the formatting changes at all
yet) turns out to be still not doing the HTML properly, I'd suggest
shuffling the patches around, add missing information so that readers
can get the corrections in text regardless of the rest of HTMLify
effort.  We'll see.

Thanks.
