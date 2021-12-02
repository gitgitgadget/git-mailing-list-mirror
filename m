Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9939C433F5
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 07:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355833AbhLBHlz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 02:41:55 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62776 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345659AbhLBHlv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 02:41:51 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E81F217673B;
        Thu,  2 Dec 2021 02:38:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2D59jOdo+vbP7Zr5psdaCCXBK11dIWueO+nEUU
        qeMLw=; b=lMOr4H9TSE0HvU2L0n9pEQRRyCORyR0tqlEXmOK7qu7reNujuGKZum
        EHxYB4VnJA3I3Fnx3yLar40ouiELB+PhGf0GE6FV8McKilsYc4UmfOjWjBsN7I/Z
        87gyzcHrmxwDnRjULJxxD18OVuLyonoQkh32ktkwW2l5Ib0zcJjFA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E275317673A;
        Thu,  2 Dec 2021 02:38:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9DE37176739;
        Thu,  2 Dec 2021 02:38:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] http-backend: give a hint that web browser access is
 not supported
References: <20211202003900.26124-1-jengelh@inai.de>
Date:   Wed, 01 Dec 2021 23:38:24 -0800
In-Reply-To: <20211202003900.26124-1-jengelh@inai.de> (Jan Engelhardt's
        message of "Thu, 2 Dec 2021 01:39:00 +0100")
Message-ID: <xmqqee6vwj67.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D58162E0-5342-11EC-B435-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jan Engelhardt <jengelh@inai.de> writes:

>  http-backend.c          | 36 +++++++++++++++++++++++++++-----
>  t/t5561-http-backend.sh | 46 ++++++++++++++++++++---------------------
>  2 files changed, 54 insertions(+), 28 deletions(-)
>
> diff --git http-backend.c http-backend.c
> index 3d6e2ff17f..f7858e9c49 100644
> --- http-backend.c
> +++ http-backend.c

Please fix your format-patch settings.  The comparisons should be
between a/http-backend.c and b/http-backend.c and not between the
same path at the top-level.

Everybody uses -p1 patches around here and their tools are set-up to
handle -p1 patches.

Thanks.
