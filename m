Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6BCC433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 18:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240100AbhLGS2Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 13:28:24 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50625 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235273AbhLGS2X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 13:28:23 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2A2D715472D;
        Tue,  7 Dec 2021 13:24:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AGYuVXrMzv4llE8knPQqgKP7jcUutekIV6P/PD
        SVOFI=; b=RV5z1WQlfce0gkU/3990b6FFEp9ZpypDjsMPVo6rwuG0peMZPREh5D
        OazxI62QTZgpHthNB4kPHcRo2GRst3mT4pSuM6yoWBlTTbX2qURJgnKENEWOnNO0
        EgiauofTUesUnwMsPJxd6oda/bpTvvzSWoTS8VOnnDESKhovzLm8M=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2235C15472C;
        Tue,  7 Dec 2021 13:24:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0C3F415472A;
        Tue,  7 Dec 2021 13:24:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Aleen via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Aleen =?utf-8?B?5b6Q5rKb5paH?= <pwxu@coremail.cn>,
        Aleen <aleen42@vip.qq.com>
Subject: Re: [PATCH v17 0/3] am: support --empty=(die|drop|keep) option and
 --allow-empty option to handle empty patches
References: <pull.1076.v16.git.1638853295.gitgitgadget@gmail.com>
        <pull.1076.v17.git.1638865913.gitgitgadget@gmail.com>
Date:   Tue, 07 Dec 2021 10:24:45 -0800
In-Reply-To: <pull.1076.v17.git.1638865913.gitgitgadget@gmail.com> (Aleen via
        GitGitGadget's message of "Tue, 07 Dec 2021 08:31:50 +0000")
Message-ID: <xmqqlf0w8e8i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F516F15A-578A-11EC-9361-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Aleen via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Since that git has supported the --always option for the git-format-patch
> command to create a patch with an empty commit message, git-am should
> support applying and committing with empty patches.
> ...
> Changes since v16:
>
>  1. fix typo from "had" to "has" in the comment.

I read the patches in full again and saw some issues that want to be
fixed, but overall it was a pleasant read.

Thanks.
