Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA5FC54EE9
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 00:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbiI1AlD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 20:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiI1AlC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 20:41:02 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24CE1B5259
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 17:41:00 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CD94713F55D;
        Tue, 27 Sep 2022 20:40:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=rUA1oL3LRudeop/IWJWroRoy2LETJq3H8WniTEwQeWI=; b=wo29
        DA/IfOSEGMf9A/zNmsNelcOlAStYfOnbt6xrxH4zopKIoKyQ+XdMHNnFMiaRTTXj
        dOcKmuQ6FVIaEsAUkDkn5roqoFEdF+yVdyIpLbf+Pb1k6xHr7AjBeOipAKGcduCw
        yE2Dbedq05EUXZQAAa7azmggk2UhllitxoXpquo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C613913F55C;
        Tue, 27 Sep 2022 20:40:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3FF4213F55B;
        Tue, 27 Sep 2022 20:40:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "skrab-sah via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, skrab-sah <skrab.sah@gmail.com>
Subject: Re: [PATCH] abspath.h is created.
References: <pull.1345.git.git.1664294909011.gitgitgadget@gmail.com>
Date:   Tue, 27 Sep 2022 17:40:58 -0700
Message-ID: <xmqq8rm41gbp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 389F5458-3EC6-11ED-B2F0-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"skrab-sah via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/abspath.h b/abspath.h
> new file mode 100644
> index 00000000000..edebc3a53ba
> --- /dev/null
> +++ b/abspath.h
> @@ -0,0 +1,9 @@
> +/* This file was automatically generated.  Do not edit! */

No thanks.

I suspect this change is taking us in a wrong direction.  People
grep for function and struct declarations in <*.h> files and expect
to find the associated comments.
