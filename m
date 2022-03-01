Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD740C433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 19:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiCATGI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 14:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiCATGH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 14:06:07 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5AD3E0FB
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 11:05:25 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 21C39112B27;
        Tue,  1 Mar 2022 14:05:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vkRiwG0rAvTrPbaNkTpzZXyNI6keHzU2qWKnQc
        jjMI8=; b=NNrMYShbZ1T+hui7d/uz+t/MDq3K3u9mgGMF7MVeEzOFJoOvWRllIe
        P+SBhANR8X27sggJKj6ZbyvzwFB64Gia1HyVvGJ35rSoBoxX1k5P36vyUpGnLTzZ
        ZOXjLRS9Y/2qCjqj+8/iAsPn4p5nbkSQfKRdD77NjHINiz7F7tG+A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1A239112B26;
        Tue,  1 Mar 2022 14:05:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 841EC112B25;
        Tue,  1 Mar 2022 14:05:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v6 00/30] Builtin FSMonitor Part 2
References: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
        <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
Date:   Tue, 01 Mar 2022 11:05:23 -0800
In-Reply-To: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com> (Jeff
        Hostetler via GitGitGadget's message of "Tue, 01 Mar 2022 18:43:02
        +0000")
Message-ID: <xmqq35k1qyrw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8CA596B8-9992-11EC-BF6C-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Here is V6 of Part 2 of my builtin FSmonitor series.
>
> This version contains mostly cleanup based on feedback from V5. Of note:
>
>  * I squashed in the 1_file fix for p7519.
>  * I squashed in a commit from part 3 to optionally print the "running
>    daemon on..." message on stderr.
>  * I added a note to the documentation about incompatible changes around
>    core.fsmonitor.
>  * Removed/rephrased some obsolete NEEDSWORK items.
>
> Tao has an ongoing parallel series to fix test-chmtime on Windows.
> https://lore.kernel.org/all/pull.1166.git.1646041236.gitgitgadget@gmail.com/
>
> If that lands first, we should be able to drop my 't/helper/test-chmtime:
> skip directories on Windows' commit.
>
> A followup Part 3 will contain additional refinements to the daemon and
> additional tests. I drew the line here between Part 2 and 3 to make it
> easier to review.

Hopefully this round will quickly be reviewed solidly to merge it
down to 'next' and lower.

Will queue.

Thanks.
