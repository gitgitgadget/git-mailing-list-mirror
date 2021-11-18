Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCC9C433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 23:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CB4D61AA3
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 23:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbhKRXuQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 18:50:16 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53474 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbhKRXuQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 18:50:16 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4887D168B1C;
        Thu, 18 Nov 2021 18:47:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=M/vwMvpzZphF
        9z4p9s74MuNQvXhsDvVAqDvCeOUAO44=; b=Iko2dt3UyHV2MinG2nwg/agwrAhX
        iFzgCL4VpTGIS+4yt5RN6BWcj2SLcFcuU0vdevdj7dbersxwpmfR7FxX8pIdimAP
        OmQ7GxiV780J4/Bod/qktGuvZES8GhcSR3TABN8U4350RU6pR6R3Uvu31RJb0SEJ
        puUbomKZKX1/K5Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 42181168B1B;
        Thu, 18 Nov 2021 18:47:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 97CA2168B19;
        Thu, 18 Nov 2021 18:47:12 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Aleen via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Aleen =?utf-8?B?5b6Q5rKb5paH?= <pwxu@coremail.cn>,
        Aleen <aleen42@vip.qq.com>
Subject: Re: [PATCH v6 0/3] am: support --empty=(die|drop|keep) option to
 handle empty patches
In-Reply-To: <pull.1076.v6.git.1637232636.gitgitgadget@gmail.com> (Aleen via
        GitGitGadget's message of "Thu, 18 Nov 2021 10:50:33 +0000")
References: <pull.1076.v5.git.1637141636.gitgitgadget@gmail.com>
        <pull.1076.v6.git.1637232636.gitgitgadget@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Date:   Thu, 18 Nov 2021 15:47:11 -0800
Message-ID: <xmqqilwpuiv4.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DA19B984-48C9-11EC-87CD-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


As per https://git-scm.com/docs/SubmittingPatches#sign-off:

   Please don=E2=80=99t hide your real name.

I suspect your real name is not Aleen, but something with x and w in
it.


