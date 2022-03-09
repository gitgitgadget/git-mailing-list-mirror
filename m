Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BB6C433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 18:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235550AbiCIS42 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 13:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiCIS41 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 13:56:27 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C16574BF
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 10:55:28 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A7077123376;
        Wed,  9 Mar 2022 13:55:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=f4oRnt1YyuU1FxsxpZAC+Cu8ZIowy1S1iUaaWn
        JblyI=; b=PqAjD/W1oU5o5JH2E0vUcE07YfBSWbTCU5nyI2KSUxeDRUEe+QZ18/
        cOrTqp+LDvTfHJXpoCzUW9bq6YAaqvFlwKuyQXQjuqH/XCypvbJezUPDmCJAtH39
        VWFGFLfIttaiqzF2UTkYglioKMoC2awTN/yr8Isocry5lcxrDQgpI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 95736123375;
        Wed,  9 Mar 2022 13:55:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B3C59123374;
        Wed,  9 Mar 2022 13:55:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH] name-rev: make --stdin hidden
References: <pull.1225.git.git.1646774677277.gitgitgadget@gmail.com>
Date:   Wed, 09 Mar 2022 10:55:22 -0800
In-Reply-To: <pull.1225.git.git.1646774677277.gitgitgadget@gmail.com> (John
        Cai via GitGitGadget's message of "Tue, 08 Mar 2022 21:24:37 +0000")
Message-ID: <xmqqo82fklb9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 79D8A6EE-9FDA-11EC-901A-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> In 34ae3b70 (name-rev: deprecate --stdin in favor of --annotate-stdin),
> we renamed --stdin to --annotate-stdin for the sake of a clearer name
> for the option, and added text that indicates --stdin is deprecated. The
> next step is to hide --stdin completely.

May be.  As 34ae3b70 is not even in any released version yet, it is
a bit premature to talk about "The next step".  Perhaps hold onto
this change for a few releases?

Thanks.
