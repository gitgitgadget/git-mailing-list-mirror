Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1321BC433F5
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 19:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351436AbiCOTI0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 15:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351372AbiCOTIH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 15:08:07 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DBA13D
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 12:06:54 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5E5841931FF;
        Tue, 15 Mar 2022 15:06:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZNBubC15lMJ7yBinN0ldAdlljuxZJ2vlrZ1f2z
        aWaV4=; b=pqvRCgPhs205Kdt6hpRn8Idw6tq34Wjys27q5bf8QCBqHrUkoqoJWI
        7a52PJ3EunRExk2UqYmfcqZ3qAikqx29GuuPUSvgCX5eZX7282JJJGxoeQCXVTPt
        3m3EZIzcViHLVp/yqmsVJImMRc9urBh0RUI/+v+fOy5+Vm1lPbtW0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 56EDE1931FE;
        Tue, 15 Mar 2022 15:06:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D5A111931FD;
        Tue, 15 Mar 2022 15:06:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 16/16] fsmonitor-settings: simplify initialization of
 settings data
References: <pull.1174.git.1647033303.gitgitgadget@gmail.com>
        <432f9ff9d92ff55216555864cb3571c94a2c6db9.1647033303.git.gitgitgadget@gmail.com>
        <xmqqpmmoqpp5.fsf@gitster.g>
        <33a9f751-6254-9b3e-6eb7-7844ac664e00@jeffhostetler.com>
Date:   Tue, 15 Mar 2022 12:06:50 -0700
In-Reply-To: <33a9f751-6254-9b3e-6eb7-7844ac664e00@jeffhostetler.com> (Jeff
        Hostetler's message of "Tue, 15 Mar 2022 14:26:04 -0400")
Message-ID: <xmqqee33dohh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 127C2670-A493-11EC-B617-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> Yeah if you haven't merged part2 to master yet, wait and i'll
> send a V7 of part2 that squashes in these fixups.
>
> and addresses any other comments on part2.5 itself.

Thanks.  I think that would be cleaner in the end.


