Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE780EB64D8
	for <git@archiver.kernel.org>; Fri, 16 Jun 2023 16:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343668AbjFPQ4P (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jun 2023 12:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345998AbjFPQ4B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2023 12:56:01 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F883C13
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 09:54:22 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8C623236FE;
        Fri, 16 Jun 2023 12:54:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ve/c5ujDtBe90mQt6Zth61XFwD5AEJ60Xc4M2t
        92cKA=; b=LjtwXObi2Gtzp35vDKC5rtwZovKjSW5aFaxSiajIOji0ciNrcivIkG
        gCsosWbDfUICZUj72tBOrIhfZjKC4DyOKvGltF56KOAL+4B+vw9ZOnXTQp6ETg+k
        rlHaGHp/K5YTC1mG4hEf1CpSGq4R5GyhXMm9lMCy1w4OAZjNWeueE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 850E6236FD;
        Fri, 16 Jun 2023 12:54:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A52C1236FC;
        Fri, 16 Jun 2023 12:54:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH v4 0/2] credential: improvements to erase in helpers
References: <pull.1525.v3.git.git.1686809004.gitgitgadget@gmail.com>
        <pull.1525.v4.git.git.1686856773.gitgitgadget@gmail.com>
        <xmqqh6r8v3es.fsf@gitster.g>
        <20230615212116.GA39325@coredump.intra.peff.net>
Date:   Fri, 16 Jun 2023 09:54:04 -0700
In-Reply-To: <20230615212116.GA39325@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 15 Jun 2023 17:21:16 -0400")
Message-ID: <xmqqfs6rqrf7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 67745BAC-0C66-11EE-A1A5-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> That said, I just re-reviewed the patches themselves, and everything now
> looks good to me.

Thanks for writing and reviewing.

Queued.
