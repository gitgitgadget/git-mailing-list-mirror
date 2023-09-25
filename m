Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36658CD54BE
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 19:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbjIYTKE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 15:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjIYTKD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 15:10:03 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9671995
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 12:09:57 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 356E72208E;
        Mon, 25 Sep 2023 15:09:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=L+ZWJb3y0dop
        H9NNmp02PyV1A6LgzYd+ZDCoFOkfI/M=; b=gSyflxgPJFlcjIM48cCSjha5Rdt+
        SjMglnhdwGlWYViAfVWaDk4AIwbi4tyITtyEOfl7Z5Z6UzHu0w+QOUePxHe4+DA7
        EcrM6TTxBfW74+OoYN+kz1CQk08npWJpMCAIl3y93cb30X6s6j9BDWarvcm1WDlV
        KsBMKclBC2UTUNs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2D43C2208D;
        Mon, 25 Sep 2023 15:09:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A71AC2208C;
        Mon, 25 Sep 2023 15:09:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 0/7] CMake(Visual C) support for js/doc-unit-tests
In-Reply-To: <pull.1579.v3.git.1695640836.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Mon, 25 Sep 2023 11:20:29
        +0000")
References: <pull.1579.v2.git.1695070468.gitgitgadget@gmail.com>
        <pull.1579.v3.git.1695640836.gitgitgadget@gmail.com>
Date:   Mon, 25 Sep 2023 12:09:52 -0700
Message-ID: <xmqq34z2t6gv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1BC43CC0-5BD7-11EE-AF19-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> The recent patch series that adds proper unit testing to Git requires a
> couple of add-on patches to make it work with the CMake build on Window=
s
> (Visual C). This patch series aims to provide that support.
>
> This patch series is based on js/doc-unit-tests.
>
> Changes since v2:
>
>  * Thanks to Phillip Wood's prodding, I managed to avoid the "Empty
>    Namespace" problem in Visual Studio's Test Explorer.

Thanks.  Will replace.

>      +            =E2=97=A2 =E2=97=88 git
>      +             =E2=97=A2 =E2=97=88 t
>      +              =E2=97=A2 =E2=97=88 suite
>      +                 =E2=97=88 t0000-basic
>      +                 =E2=97=88 t0001-init
>      +                 =E2=97=88 t0002-gitfile
>      +                 [...]

I somehow liked this part of the log message very much ;-)
