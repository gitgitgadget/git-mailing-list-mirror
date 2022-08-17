Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A6DC25B08
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 21:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238605AbiHQVb1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 17:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241899AbiHQVbV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 17:31:21 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881D6A222D
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 14:31:20 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5D59212E446;
        Wed, 17 Aug 2022 17:31:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7ltOodFWrQ+zLk8tEy1EGVeTYNXy/ld8DhQuCg
        R2MD4=; b=AWHTvq6hfVDQnrH9MZZ8WY5PNpQPKnTchXnlBVUplIrFEZS0OUEKRB
        gr5WJ4IARX3SNR1L3aUTBnLFhlpSOcheRO6xkqa8iuoRVbtuHoHNVFEtSrylv9ne
        BzrKsMrRG//j1fHfd7MmeEvseNhKEE6NG1qnakRe8ao2KpUEz7pcU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 54B6E12E445;
        Wed, 17 Aug 2022 17:31:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A1AA312E444;
        Wed, 17 Aug 2022 17:31:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 0/3] Fixups for cw/submodule-merge-messages
References: <pull.1325.git.1660696081.gitgitgadget@gmail.com>
        <pull.1325.v2.git.1660718028.gitgitgadget@gmail.com>
Date:   Wed, 17 Aug 2022 14:31:16 -0700
In-Reply-To: <pull.1325.v2.git.1660718028.gitgitgadget@gmail.com> (Elijah
        Newren via GitGitGadget's message of "Wed, 17 Aug 2022 06:33:45
        +0000")
Message-ID: <xmqqsflutv4r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EDB9E786-1E73-11ED-8355-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Elijah Newren (3):
>   merge-ort: remove translator lego in new "submodule conflict
>     suggestion"
>   merge-ort: add comment to avoid surprise with new sub_flag variable
>   merge-ort: provide helpful submodule update message when possible

Thanks.  The last step was especially the pleasant one.
