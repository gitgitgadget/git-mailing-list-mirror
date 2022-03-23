Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557DBC433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 21:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241152AbiCWVnB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 17:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234033AbiCWVnA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 17:43:00 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D7885952
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 14:41:30 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 840971885A4;
        Wed, 23 Mar 2022 17:41:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MKt7DnGNsl9gwDzPurqsG2AScmp/lHtM36rCty
        hNIXQ=; b=HHkNssnQu3gfXMqV2Z4QwsLvgdV2KfAWOS00FRJu8kGuudUsbEvRsD
        K/lcO9xhjlbludbB1zEFYdKOdWC/WSBbRpf8cs2nEMFwOmFQy9J+P24/wDD+EdPK
        5S8vQc9pknUznd7n6T0G1GCtkCKIbu+0T6NudvUovOYxMS+twbHho=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6A7851885A3;
        Wed, 23 Mar 2022 17:41:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C69541885A2;
        Wed, 23 Mar 2022 17:41:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2 0/3] reset: make --no-refresh the only way to skip
 index refresh
References: <pull.1184.git.1647894889.gitgitgadget@gmail.com>
        <pull.1184.v2.git.1648059480.gitgitgadget@gmail.com>
Date:   Wed, 23 Mar 2022 14:41:26 -0700
In-Reply-To: <pull.1184.v2.git.1648059480.gitgitgadget@gmail.com> (Victoria
        Dye via GitGitGadget's message of "Wed, 23 Mar 2022 18:17:57 +0000")
Message-ID: <xmqq5yo4qrcp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FEADFF0A-AAF1-11EC-AAA3-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Changes since V1
> ================
>
>  * Dropped patch that removed '--refresh', again allowing both
>    '--no-refresh' and '--refresh' as valid options.

Makes sense.  Thanks for suggesting this, Phillip.

>  * Updated documentation of "--refresh" option to remove unnecessary
>    "proactively".

OK.

>  * Reworded commit titles to change "deprecate" to the more accurate
>    "remove".

OK.

Will queue.  Thanks.
