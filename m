Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A304DC67871
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 00:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiJYAcD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 20:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiJYAbr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 20:31:47 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382853141A7
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 15:55:30 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BD38E1528DB;
        Mon, 24 Oct 2022 18:55:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=grYvlHdyiKYLddQh3f20eeknAKnbB2M/x8Llhj
        en/x4=; b=tzJVE9ZrhLVILSJWYd86o+m9kaviDbZXotFZQLPcPwEZ986XH7af3N
        5YPWG4Pq7XJ57b8NZYK4rs+Kia6yqIwY3FA7KEb0PBWZVTOQWsJCETNJrq1hdnmU
        WWGblOoTNTN6Tss9tHtpmhYIB1E8mNBJXBrIwe+FQrX+5cQ/87y0o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ABE921528DA;
        Mon, 24 Oct 2022 18:55:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BABB81528D8;
        Mon, 24 Oct 2022 18:55:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jerry Zhang via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jerry Zhang <jerry@skydio.com>
Subject: Re: [PATCH v5 0/6] patch-id fixes and improvements
References: <pull.1359.v4.git.1666307815.gitgitgadget@gmail.com>
        <pull.1359.v5.git.1666642064.gitgitgadget@gmail.com>
Date:   Mon, 24 Oct 2022 15:55:27 -0700
In-Reply-To: <pull.1359.v5.git.1666642064.gitgitgadget@gmail.com> (Jerry Zhang
        via GitGitGadget's message of "Mon, 24 Oct 2022 20:07:38 +0000")
Message-ID: <xmqqilk8rfvk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F481CD8A-53EE-11ED-888F-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jerry Zhang via GitGitGadget" <gitgitgadget@gmail.com> writes:

> These patches add fixes and features to the "git patch-id" command, mostly
> discovered through our usage of patch-id in the revup project
> (https://github.com/Skydio/revup). On top of that I've tried to make general
> cleanup changes where I can.

Thanks, let's move it forward.
