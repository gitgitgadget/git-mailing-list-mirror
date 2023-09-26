Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AA0E7E650
	for <git@archiver.kernel.org>; Tue, 26 Sep 2023 16:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235372AbjIZQmv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Sep 2023 12:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235387AbjIZQms (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2023 12:42:48 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A79BF
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 09:42:37 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4B70119B5D2;
        Tue, 26 Sep 2023 12:42:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=S1eUHV+RZF5A/OYLTmv6KNXYYBWa1ZPalQRs/B
        zk7p4=; b=qvj6i+R6wDs9yZ9aKR+CjBstRklzjGB74vibwgZkIlKvpNyWrB0V2d
        XgsuVJUDPkiVXdbyITwItLoF17Uw5MePZvuZEtePm8BKt4k5f8DrwAy2BaxfqBTF
        mAZi9FovanTnVBdovnMVu5M3/dL8xYz1mrEwbI4S2oriJvn09Xgn4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 41AD519B5D0;
        Tue, 26 Sep 2023 12:42:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A27BC19B5CF;
        Tue, 26 Sep 2023 12:42:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Soref <jsoref@gmail.com>
Cc:     Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Josh Soref via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] pretty-formats.txt: fix whitespace
In-Reply-To: <CACZqfqCfvWASMPMxRpRuAUQPcprcB4RHxxke_qTZ3bFGLf3T8Q@mail.gmail.com>
        (Josh Soref's message of "Mon, 25 Sep 2023 22:51:03 -0400")
References: <pull.950.git.1695391818917.gitgitgadget@gmail.com>
        <f3081838-ca50-4a7d-b2fc-6f0f1f1364a8@app.fastmail.com>
        <CACZqfqCfvWASMPMxRpRuAUQPcprcB4RHxxke_qTZ3bFGLf3T8Q@mail.gmail.com>
Date:   Tue, 26 Sep 2023 09:42:34 -0700
Message-ID: <xmqqo7hoophh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B24F27F4-5C8B-11EE-A299-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Soref <jsoref@gmail.com> writes:

> As it (IMO) takes effort (admittedly trivial, and quite likely
> habitual) to insert a second space, I assume that this was a desired
> thing and the one space was the aberration, hence the patch went in
> favor of two spaces.

Back in typewriter days, people were taught to leave two spaces
after a full stop, because on monospace output it was easier to read
that way.  Then the desktop publishing software came and people were
encouraged to leave the appearance up to the software.

So to old timers who have already been trained to type two spaces
after a sentence, it takes more effort not to type the space bar
twice.

But as I said already, I personally feel that the consistency
guidelines around this area should be:

 (1) it would be nice if a new document does not use mixed style, but

 (2) it is not worth the patch noise only to "fix" them one way or
     the other.

Here "patch noise" does not primarily mean the effort a producer of
such a patch spends making sure what they did is correct.  The cost
of making sure unrelated mistakes do not slip into the codebase and
documentation without being noticed is much higher for such a patch
that ought to be a mechanical conversion.

Thanks.
