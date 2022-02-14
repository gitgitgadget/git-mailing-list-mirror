Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52AAC433EF
	for <git@archiver.kernel.org>; Mon, 14 Feb 2022 17:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357012AbiBNRYD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 12:24:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbiBNRYA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 12:24:00 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB4E652DE
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 09:23:52 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7B711186358;
        Mon, 14 Feb 2022 12:23:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=404e8XOb/rTU9K1Bi3pKcGcn1xGVG/q211DN/M
        kVVPE=; b=Mi1z1EfCT2cLQ9XDBMK6sODjV/x4icCwIeJabZOuCCyN85PMfRswaL
        pMgu/iUVVaWWa7M9NSxleLxRKZBckOr24SfXst40yAWjQqxwuIPIWYsrC9wSpBI9
        sjq9Qkb5silMtwPsSzo9MDN3xvjhvqYQ6eNDZuMeGLpHnhThSvs/Y=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 74855186357;
        Mon, 14 Feb 2022 12:23:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D3633186356;
        Mon, 14 Feb 2022 12:23:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        zoltan.klinger@gmail.com,
        Patrick Marlier <patrick.marlier@gmail.com>
Subject: Re: [PATCH] clean: Use past tense for msg_remove, msg_skip_git_dir,
 and msg_skip_cwd
References: <20220210024138.157327-1-bagasdotme@gmail.com>
        <CABPp-BEguZQMTjDxEpMqKwKpDdPj9yWbL5T_wRJhD3KDJK5=UQ@mail.gmail.com>
Date:   Mon, 14 Feb 2022 09:23:48 -0800
In-Reply-To: <CABPp-BEguZQMTjDxEpMqKwKpDdPj9yWbL5T_wRJhD3KDJK5=UQ@mail.gmail.com>
        (Elijah Newren's message of "Sat, 12 Feb 2022 14:29:35 -0800")
Message-ID: <xmqq8rud4b17.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DFBD94CE-8DBA-11EC-877B-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> This strikes me as an unnecessary or at least insufficiently motivated
> patch.  The difference between "Removing <path>" and "Removed <path>"
> is lost in the noise when there is no user-input or other behavior
> slowing these down, and they are removed at the speed the machine can
> remove.

True.
