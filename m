Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27038C433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 16:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240725AbiEYQf1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 12:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239205AbiEYQfZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 12:35:25 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AAF53B68
        for <git@vger.kernel.org>; Wed, 25 May 2022 09:35:20 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 373F212E4BF;
        Wed, 25 May 2022 12:35:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YBP+mUMJPSHAGC4t8IS/bAdvgI5yh/nKJKIVhS
        h+7sY=; b=ai2VBo6LNFEmmS6Z2c9zPIQ4Ji0VIiM9o15n2YTJUT85/i5SZeSeU7
        sbZ7U1QQojVTEeXHJM00fdtQEANIBSQjNzatmvtd2T0ZTlDMVPXhfua9BtE7buAz
        m+Qm1ANgskJjD8nHXC3p07YyLMhDsI6xfArb3/3h1yQUaSDgpgKfk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2CF0212E4BE;
        Wed, 25 May 2022 12:35:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8B1EB12E4BD;
        Wed, 25 May 2022 12:35:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v8 00/30] Builtin FSMonitor Part 3
References: <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
        <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
Date:   Wed, 25 May 2022 09:35:17 -0700
In-Reply-To: <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com> (Jeff
        Hostetler via GitGitGadget's message of "Wed, 25 May 2022 15:00:22
        +0000")
Message-ID: <xmqqy1yp8ta2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A9C92018-DC48-11EC-A204-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This version addresses the new t/helper/test-hexdump utility to emit an LF
> at the end. I also updated the test scripts to write hexdump output to a
> file and then grep that file to avoid having the tool being in the middle of
> a pipeline.

https://github.com/git/git/runs/6583917870 shows t7527 is not happy
in "win test (9)" job with the previous version.  It is unclear if
that has been addressed, but we'll see soon.

Will replace.  Thanks.
