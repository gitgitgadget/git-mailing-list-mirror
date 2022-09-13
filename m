Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB59C6FA82
	for <git@archiver.kernel.org>; Tue, 13 Sep 2022 18:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbiIMSfJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Sep 2022 14:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbiIMSes (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2022 14:34:48 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C87280019
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 10:54:11 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8142F1A71F9;
        Tue, 13 Sep 2022 13:54:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uk9ET5rBs8oXvoVXwROCdJRuLfSvrCuLULRghV
        wKf6s=; b=qPSOpgTd7vRo5xuthLax/34IYIGjpplVA6b48SXOgIrX6Ap981kZqh
        huxAy4zLV+nT+0TsSkB+cEvSIKGyftuXVfbJGN0gL2F/2e7A/zNk5wmKTCjs7vbg
        k1ngBOGu9APo2yWCTP8emEVi0bMr9z2pAsauauTkQyeTf0aK4Da/8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6DC7F1A71F8;
        Tue, 13 Sep 2022 13:54:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0E0EB1A71F7;
        Tue, 13 Sep 2022 13:54:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        Johannes.Schindelin@gmx.de, steadmon@google.com,
        chooglen@google.com, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH] Documentation: add ReviewingGuidelines
References: <pull.1348.git.1662747205235.gitgitgadget@gmail.com>
Date:   Tue, 13 Sep 2022 10:54:05 -0700
In-Reply-To: <pull.1348.git.1662747205235.gitgitgadget@gmail.com> (Victoria
        Dye via GitGitGadget's message of "Fri, 09 Sep 2022 18:13:25 +0000")
Message-ID: <xmqqr10f88jm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 100882E2-338D-11ED-B6AE-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Victoria Dye <vdye@github.com>
>
> Add a reviewing guidelines document including advice and common terminology
> used in Git mailing list reviews. The document is included in the
> 'TECH_DOCS' list in order to include it in Git's published documentation.
>
> Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Helped-by: Derrick Stolee <derrickstolee@github.com>
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---

I've commented on the text but haven't seen anybody else reviewing.
No interest?  Everybody silently happy?

