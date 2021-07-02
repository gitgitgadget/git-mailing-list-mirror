Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1875C07E95
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 18:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFF5461402
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 18:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhGBSVZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 14:21:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63512 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhGBSVZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 14:21:25 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 369C6BE3CA;
        Fri,  2 Jul 2021 14:18:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=EkbaELP2uejp
        Zen3sNkxyTjshV75o/QBi9Gk6/07T4E=; b=IGa3CbWxEVZP/XvhS5/FKQs0hiIA
        nefs6kuF8DLIee1JMt+aqkV7XLe88iyvJRMFbVKvQ+RcabixFhbfPi961nsYdWyt
        htXxnFaoqFLWgY4iRm/UfD6M3aHSnSnRC3WAkBoHbZYDOPnuOw9JaaUJ3xVs4pLd
        1IR2zSfacN18i0g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C180BE3C9;
        Fri,  2 Jul 2021 14:18:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AC2A0BE3C7;
        Fri,  2 Jul 2021 14:18:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v7 0/3] maintenance: add support for systemd timers on
 Linux
References: <20210612165043.165579-1-lenaic@lhuard.fr>
        <20210702142556.99864-1-lenaic@lhuard.fr>
Date:   Fri, 02 Jul 2021 11:18:51 -0700
In-Reply-To: <20210702142556.99864-1-lenaic@lhuard.fr> (=?utf-8?B?IkzDqW5h?=
 =?utf-8?B?w69j?= Huard"'s
        message of "Fri, 2 Jul 2021 16:25:53 +0200")
Message-ID: <xmqq8s2opoj8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F40562D8-DB61-11EB-BFB0-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

L=C3=A9na=C3=AFc Huard <lenaic@lhuard.fr> writes:

> Hello,
>
> Please find hereafter a new reroll of my patchset to add support for
> systemd timers on Linux for the `git maintenance start` command.
>
> The changes compared to the previous version address the remarks
> raised during the previous review.

which are...?

>
> The patches are:
>
> * cache.h: Introduce a generic "xdg_config_home_for(=E2=80=A6)" functio=
n
> * maintenance: `git maintenance run` learned `--scheduler=3D<scheduler>=
`
> * maintenance: add support for systemd timers on Linux

Thanks, will replace.
