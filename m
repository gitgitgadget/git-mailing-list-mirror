Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FBEC433F5
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 20:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245177AbiCNU4a (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 16:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234775AbiCNU43 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 16:56:29 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934CF3D1FB
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 13:55:18 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1CF93188BC3;
        Mon, 14 Mar 2022 16:55:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WAzQEv/GGdkhasQTB+Jao+dMal9y3SxUSze5iS
        YdnHs=; b=jXbt0RK+W3ccEjUaCilygkRVWjmiZRumbhc6IOAgjudZL/KTzM5UZD
        P0DhGLXg+7tBLw3VhgH/E8KDHtmsixolVNiC/3yF766WebyTthHFkYUapO52TbtS
        AM2EIiCnWyA7s57TEtpK/jbMhriRPP+yosSFytTRfYcIcrtRG/Ay4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0208D188BC2;
        Mon, 14 Mar 2022 16:55:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CF331188BC1;
        Mon, 14 Mar 2022 16:55:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 5/9] git-sparse-checkout.txt: shuffle some sections
 and mark as internal
References: <pull.1148.git.1646725188.gitgitgadget@gmail.com>
        <pull.1148.v2.git.1647054681.gitgitgadget@gmail.com>
        <7333198b7785ff4ab6d424b3384c9e4d264e96b2.1647054681.git.gitgitgadget@gmail.com>
Date:   Mon, 14 Mar 2022 20:55:13 +0000
In-Reply-To: <7333198b7785ff4ab6d424b3384c9e4d264e96b2.1647054681.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Sat, 12 Mar 2022
        03:11:17 +0000")
Message-ID: <xmqqsfrkp83y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0C2559AA-A3D9-11EC-B30E-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -CONE PATTERN SET
> -----------------
> +INTERNALS -- CONE PATTERN SET
> +-----------------------------

Ah, this is why I was confused during my review of an earlier step,
where it refered to this (and the other) sections as "sections on
'pattern set'", because I was reading the end-result of applying the
whole series.

With this change, shouldn't the reference be updated?

