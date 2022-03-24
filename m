Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57352C433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 21:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240605AbiCXVwa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 17:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiCXVw3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 17:52:29 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB924AC938
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 14:50:56 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2D8F4106443;
        Thu, 24 Mar 2022 17:50:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=g+AZFnUw0hOZYTKmYUVc7bRcMFrK3qS5Y3QCDY
        c2bSE=; b=p9SM5IyX6LmkqgL7mjFvs8dKpVv7ta5UeXF7I3nPsovmMlC+qZ3C7n
        BAlJbM0dRSFv4zSEsZGBlKsXPFfiIvl1Sag5j3ARyU6+xtIXVa6KU671B27knUjQ
        cvhqmXl79hHdFjDydrCScXiYIleitunHFuSX+egGAv6cNgU7sd6o4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1F663106442;
        Thu, 24 Mar 2022 17:50:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 89DF3106441;
        Thu, 24 Mar 2022 17:50:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 00/27] Builtin FSMonitor Part 3
References: <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
        <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 14:50:54 -0700
In-Reply-To: <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com> (Jeff
        Hostetler via GitGitGadget's message of "Thu, 24 Mar 2022 16:50:53
        +0000")
Message-ID: <xmqq4k3nf29t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7B7FC94E-ABBC-11EC-BD56-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Here is V4 of Part 3 of my builtin FSMonitor series. This version has been
> updated to depend upon V8 of Part 2.

Thanks.  Queued.

