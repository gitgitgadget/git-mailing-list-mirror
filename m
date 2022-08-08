Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCA3C00140
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 21:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236481AbiHHVRe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 17:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234943AbiHHVRe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 17:17:34 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CF318B09
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 14:17:31 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 86C2213EEDE;
        Mon,  8 Aug 2022 17:17:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VP/TuoE1NN2mSnPbtwQVgr0FxlqWEhZR8jpqV3
        tVY6U=; b=LD1vfgj3LKwTJbrwsVfHbSa+KpfwNdNqBApftnXdMJ+hGr2Y/FI9Zh
        FhrUCRyPLF4bSVgnHxB0PGawB+ZwWz44pNJylv2sAU2jEN0clLchqAwtVsYSFlYi
        4DE4ksKtDsXCuHdsgX/o36WlO3hJ8vkKTp79hlFFVhNkCZfEihMjU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E5E713EEDD;
        Mon,  8 Aug 2022 17:17:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E3C6013EEDC;
        Mon,  8 Aug 2022 17:17:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        shaoxuan.yuan02@gmail.com, newren@gmail.com,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v3 0/4] reset/checkout: fix miscellaneous sparse index bugs
References: <pull.1312.v2.git.1659841030.gitgitgadget@gmail.com>
        <pull.1312.v3.git.1659985672.gitgitgadget@gmail.com>
Date:   Mon, 08 Aug 2022 14:17:28 -0700
In-Reply-To: <pull.1312.v3.git.1659985672.gitgitgadget@gmail.com> (Victoria
        Dye via GitGitGadget's message of "Mon, 08 Aug 2022 19:07:48 +0000")
Message-ID: <xmqq1qtqsadz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 82A4AEBA-175F-11ED-99EB-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Changes since V2
> ================
>
>  * Adjusted 'reset hard with removed sparse dir' test in
>    't1092-sparse-checkout-compatibility.sh' to avoid 'git rm' log message
>    conflicts with [1]

The topic looks quite ready for 'next'.

Thanks.

