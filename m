Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B4AC4332F
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 18:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbiJNS55 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 14:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbiJNS54 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 14:57:56 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E8C1D375D
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 11:57:53 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A9C301C3D5E;
        Fri, 14 Oct 2022 14:57:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ObP7bYTpyXbyzcP7gsqZMPO81IBHkrvJgFUtL0
        QGqBA=; b=bbLIC5fGy2NCFeolJUBFkjUse0mTPiR+C9gKq32wjTwMFNT39olXnt
        Ow+qaQekvd7t4mjvh1G+NpNLbAlaJlmxfDlXYALEmK2pMLdo546lL0QujqBdkfCw
        uMzDD3+dBrTMupTF0f9Y91N0qxKoT9Vd12XEOsUH2spp4Gjx1+zp8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A0FCB1C3D5D;
        Fri, 14 Oct 2022 14:57:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6BB6C1C3D5C;
        Fri, 14 Oct 2022 14:57:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        nsengaw4c via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, nsengaw4c <nsengiyumvawilberforce@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH v3] [OUTREACHY] t1002: modernize outdated conditional
References: <pull.1362.v2.git.git.1665733647421.gitgitgadget@gmail.com>
        <pull.1362.v3.git.git.1665734502591.gitgitgadget@gmail.com>
        <xmqqv8om9yaz.fsf@gitster.g>
        <f064ce46-8ed0-a9c1-8df5-5c258677d95f@github.com>
        <CAPig+cT=bJ7BP9CDh5-oYYF376vVxsh7E0UAE_QN0wfAgR3AAg@mail.gmail.com>
        <cc0a6adb-d894-77b3-2a65-9042237c07b5@github.com>
Date:   Fri, 14 Oct 2022 11:57:47 -0700
In-Reply-To: <cc0a6adb-d894-77b3-2a65-9042237c07b5@github.com> (Derrick
        Stolee's message of "Fri, 14 Oct 2022 13:54:39 -0400")
Message-ID: <xmqqlepi8c7o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 188FA814-4BF2-11ED-8A8C-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> Nsengiyumva: you'll want to be careful to edit your pull request
> description on GitHub before running the "/submit" chatop. Your
> current description has a paste of your commit message followed by
> the contributing template. The pull request description becomes
> your cover letter (in the case of multiple patches) or a commentary
> section after the commit message (in this case of a single patch).
>
> The description is a good place to say things like "I started
> working on this because of a mailing list thread..." or "I'm not
> sure if I've tested everything enough".

Good advice.

> The "cc:" lines should _not_ be in the commit message at all, which
> is what's visible in the patch.

I agree that it would probably be better without CC: in the trailer
in this case.  Some projects seem to use the CC: in the trailer to
signal that these people have been notified, without implying
anything about their reaction (i.e. when the author cannot use
reviewed-by or acked-by).  We are not that large a community, so I
personally do not see a need to use such a trailer around here.  But
that is only a local convention in this project.

Thanks.

