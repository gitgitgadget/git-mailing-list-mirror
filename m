Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF87C433EF
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 06:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1156F60F21
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 06:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239633AbhIFGuU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 02:50:20 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56068 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhIFGuT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 02:50:19 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 57372154D0E;
        Mon,  6 Sep 2021 02:49:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=VF0cKEL9hXUc
        YvqdWrnrCpEAoaCc8SNw9LqCOfNeOn8=; b=DeWAd3Cn4eDhBKbzmopYJmln+ssn
        WIjgJX1wHadO/mUc8rRdrJOaivKqczF+jLmS9HNAxpcLwi44jJHa6X4FX+Vs0XiB
        ++wxRK2USsnLSp5B4YCQyC+uFJYuQ1ceAogKh4c54n7dqI6EUH8Z7xj9gkgYwjD8
        hrLkxu/kgujRvzg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4E984154D0D;
        Mon,  6 Sep 2021 02:49:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 95039154D0C;
        Mon,  6 Sep 2021 02:49:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org,
        Carlo Arenas <carenas@gmail.com>, felipe.contreras@gmail.com,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH RESEND v3] make: add INSTALL_STRIP option variable
References: <20210905110417.35702-1-bagasdotme@gmail.com>
        <xmqqwnnuesrf.fsf@gitster.g> <YTWG8xpoxXvRkoNV@danh.dev>
Date:   Sun, 05 Sep 2021 23:49:10 -0700
In-Reply-To: <YTWG8xpoxXvRkoNV@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcuG6p24g?=
 =?utf-8?B?Q8O0bmc=?= Danh"'s message of
        "Mon, 6 Sep 2021 10:11:47 +0700")
Message-ID: <xmqqh7eydwrd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8B6BB280-0EDE-11EC-AB6F-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> So, here is my SoB, too:
>
> Signed-off-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@g=
mail.com>

Thanks.
