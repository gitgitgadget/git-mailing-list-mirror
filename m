Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AAFC433F5
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 00:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiBRADV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 19:03:21 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiBRADU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 19:03:20 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9897745074
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 16:02:59 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 86916111C87;
        Thu, 17 Feb 2022 19:02:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YTGHikqNVj19V1j4MlDyz8znPDHKw+uhjkozUY
        eEPxs=; b=u2FxyDcmRl+5AtGXmqFTLJDxtiz7ioBWyGh6s6S5buH2lP/to8TCTy
        sGgJ59406ua7dLypW0FzbQDTAtoYKx3jmylrQWXS9EIxSWd5Cf7Ecu4Cth9Y+WhM
        4Zsbj9bO5WkErEEMcwoaS8V8XftYyDVNAOdLbxACZedPibFPYcYuM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7EF6F111C86;
        Thu, 17 Feb 2022 19:02:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EBC75111C85;
        Thu, 17 Feb 2022 19:02:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 0/7] reftable: avoid reading and writing empty keys
References: <pull.1185.git.git.1642010868.gitgitgadget@gmail.com>
        <pull.1185.v2.git.git.1645106124.gitgitgadget@gmail.com>
Date:   Thu, 17 Feb 2022 16:02:54 -0800
In-Reply-To: <pull.1185.v2.git.git.1645106124.gitgitgadget@gmail.com> (Han-Wen
        Nienhuys via GitGitGadget's message of "Thu, 17 Feb 2022 13:55:17
        +0000")
Message-ID: <xmqq4k4x59e9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1FF77592-904E-11EC-B96A-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> this series makes sure that the object record does not have to consider
> empty keys (and therefore, a NULL memcpy destination)
>
> while we're at it add some more tests, and fix a naming mistake.

Looking good.  Will queue.

Thanks.
