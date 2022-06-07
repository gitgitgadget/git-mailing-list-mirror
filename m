Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886BFC433EF
	for <git@archiver.kernel.org>; Tue,  7 Jun 2022 20:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356569AbiFGUR1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 16:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359619AbiFGUPs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 16:15:48 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA32F1C8A0F
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 11:28:23 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5FD82198DC3;
        Tue,  7 Jun 2022 14:28:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RbrcGAR0XA/mRbOpxIP9UuShvcWK7919iUTQek
        85ggQ=; b=yDvyAcDS/517VNC8NN9lV9LBhUFD0OQd7SKd3B0AMJ/wgN3ayGg8zW
        9jofkDTC5KSfRnvoDoTB08RBYPBEctbLrYak4xca7eamLIxvuGv3q10pEBF1n6pf
        lEQtPzbte+L5UxhrS2EoVYEfXauYHq/me+RGRHtB/o2Khl/gJUps0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 58438198DC2;
        Tue,  7 Jun 2022 14:28:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0214D198DC0;
        Tue,  7 Jun 2022 14:28:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Vicent Marti <tanoku@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH v2 0/3] bitmap-format.txt: fix some formatting issues
 and include checksum info
References: <pull.1246.git.1654177966.gitgitgadget@gmail.com>
        <pull.1246.v2.git.1654623814.gitgitgadget@gmail.com>
Date:   Tue, 07 Jun 2022 11:28:17 -0700
In-Reply-To: <pull.1246.v2.git.1654623814.gitgitgadget@gmail.com> (Abhradeep
        Chakraborty via GitGitGadget's message of "Tue, 07 Jun 2022 17:43:31
        +0000")
Message-ID: <xmqqfskgwcou.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9A9BD486-E68F-11EC-B8A8-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> There are some issues in the bitmap-format html page.

"First, it does not even exist!" before anything else ;-)

> For example, some
> nested lists are shown as top-level lists (e.g. [1]- Here
> BITMAP_OPT_FULL_DAG (0x1) and BITMAP_OPT_HASH_CACHE (0x4) are shown as
> top-level list). There is also a need of adding info about trailing checksum
> in the docs.
>
> Changes since v1:
>
>  * a new commit addressing bitmap-format.txt html page generation is added

Good.

>  * Remove extra indentation from the previous change

Good.

>  * elaborate more about the trailing checksum (as suggested by Kaartic)

Good.

Will take a look (and audiences are requested to do so, too).

Thanks.
