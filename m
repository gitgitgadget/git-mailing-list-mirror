Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB531C433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 21:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbhLVVqM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 16:46:12 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50117 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhLVVqL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 16:46:11 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8B0D4151723;
        Wed, 22 Dec 2021 16:46:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GXFmfErp54aCw/MgJmLjzdnRMoqDk4Ib3hItsR
        ryGek=; b=eyBnPqAmXrodzpTIZs+7+VgXtCdkj9nMuQNeDSLFLrjK+N4ZA7Xe9V
        6zgR+IZYO0UJpB2kcc5cXE7C74v60nwA9JGlHfG6ziK6k1gdWB0tTZ8m9+wjyetM
        LI0054Hwzzz0HUbUunUAyUoSXDvUi4KSbr3791M+cAVRDWiqAwK/s=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8307E151722;
        Wed, 22 Dec 2021 16:46:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DE5B9151720;
        Wed, 22 Dec 2021 16:46:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joel Holdsworth <jholdsworth@nvidia.com>
Cc:     git@vger.kernel.org,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Luke Diamand <luke@diamand.org>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
Subject: Re: [PATCH v3 0/2] git-p4: remove "debug" and "rollback" verbs
References: <20211222145552.93786-1-jholdsworth@nvidia.com>
Date:   Wed, 22 Dec 2021 13:46:05 -0800
In-Reply-To: <20211222145552.93786-1-jholdsworth@nvidia.com> (Joel
        Holdsworth's message of "Wed, 22 Dec 2021 14:55:50 +0000")
Message-ID: <xmqqbl18ia8y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9171E24E-6370-11EC-93A4-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joel Holdsworth <jholdsworth@nvidia.com> writes:

> git-p4 contains a selection of verbs for various functions of the
> script. The "debug" and "rollback" verbs appear to have been added early
> in the development life of git-p4. They were once used as debugging
> tools, but are no longer being used either by developers or users, and
> are largely undocumented. Removing these verbs simplifies the script by
> removing dead code, and increases usability by reducing complexity.
>
> This third version of the patch-set adds more detail to the commit
> messages.
>
> Joel Holdsworth (2):
>   git-p4: remove "debug" verb
>   git-p4: remove "rollback" verb
>
>  git-p4.py | 76 -------------------------------------------------------
>  1 file changed, 76 deletions(-)

Thanks for updates.  

Will queue (and would appreciate acks and cheers from other
stakeholders in git-p4).
