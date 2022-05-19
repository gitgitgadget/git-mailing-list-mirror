Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14334C433EF
	for <git@archiver.kernel.org>; Thu, 19 May 2022 19:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241726AbiESTYH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 15:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244552AbiESTYE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 15:24:04 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41DBD02B1
        for <git@vger.kernel.org>; Thu, 19 May 2022 12:23:54 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B16F71168E5;
        Thu, 19 May 2022 15:23:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=id9RQe57H6vb4OUQFWFM4x5sQ1DMins5LPOQhM
        bIdq8=; b=dMFYcCewMiieOzSDj3dIkz53N9Y9N6drjzRnxGMJnujjQF10FxwuHw
        QSnklwzw1DrEFq2him9ftET6y9d+6ioUKRFVoCKn6mg/wp4ttYm2ZEidhxQOKbB6
        55eWZvp9SCFFWQy6w57La8993ih+jKX41olQnK9zTkdf67XtoyzzI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A86A51168E4;
        Thu, 19 May 2022 15:23:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 12DE21168E2;
        Thu, 19 May 2022 15:23:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>, rsbecker@nexbridge.com,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v5 0/7] scalar: implement the subcommand "diagnose"
References: <pull.1128.v4.git.1652210824.gitgitgadget@gmail.com>
        <pull.1128.v5.git.1652984283.gitgitgadget@gmail.com>
Date:   Thu, 19 May 2022 12:23:51 -0700
In-Reply-To: <pull.1128.v5.git.1652984283.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Thu, 19 May 2022 18:17:56
        +0000")
Message-ID: <xmqq7d6hnx6g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 38057E84-D7A9-11EC-84B2-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Changes since v4:
>
>  * Squashed in Junio's suggested fixups
>  * Renamed the option from --add-file-with-content=<name>:<content> to
>    --add-virtual-file=<name>:<content>

;-)  5 letters shorter and is a good name.

>  * Fixed one instance where I had used error() instead of error_errno().

Looks good.

Thanks.  Will replace and queue.
