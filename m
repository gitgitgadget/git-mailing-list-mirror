Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89215C433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 00:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380911AbiDUAFq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 20:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiDUAFp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 20:05:45 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD873B013
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 17:02:57 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C4725187FC4;
        Wed, 20 Apr 2022 20:02:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1nIoVwhoXlpz5EUUMnaUp9SQWFCHYl1dLwt8uL
        iE/FA=; b=gNDvmb/Z6nHLG08LcF/62VRfGhT0a4UDBl6FZGXuuaUk3zZMhTHnvh
        J5NIVxM42dkoUDwc9eVX1Th5aZw1vwEjPFt/BlSvL4p8DRadmsO1xnOtb4/+Ezpd
        44KlTk/96rLlAojtKXRBP8kyY9vyyGIwM20LTOxkIh5xyoVzIWd/4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BCFE9187FC3;
        Wed, 20 Apr 2022 20:02:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 491A4187FC1;
        Wed, 20 Apr 2022 20:02:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v5 00/28] Builtin FSMonitor Part 3
References: <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
        <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
Date:   Wed, 20 Apr 2022 17:02:52 -0700
In-Reply-To: <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com> (Jeff
        Hostetler via GitGitGadget's message of "Wed, 20 Apr 2022 20:42:50
        +0000")
Message-ID: <xmqqr15rl2vn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 63FD9B3E-C106-11EC-96C6-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Here is version 5 of FSMonitor part 3. This version:
>
>  * refactored the submodule test in commit 23 to let me reuse parts of it in
>    a later commit.
>
>  * Added a new commit 28 to silence a stray warning when FSMonitor is
>    implicitly started in a recursive git submodule absorbgitdirs call and
>    receives the --super-prefix argument. The warning was harmless, but was
>    confusing to users.

I've replaced the series and rebuilt 'seen' with it.  After I push
the result out, I'll call it a day.

Thanks.
