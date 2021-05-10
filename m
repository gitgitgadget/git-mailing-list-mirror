Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA926C43461
	for <git@archiver.kernel.org>; Mon, 10 May 2021 04:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEA0F613AB
	for <git@archiver.kernel.org>; Mon, 10 May 2021 04:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhEJEPo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 00:15:44 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54178 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhEJEPn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 00:15:43 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9EE3412E2AC;
        Mon, 10 May 2021 00:14:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=qBHw0V/80aXG
        ObJI6ZFaqMOO3V5c4nnldN8z/6MLXVU=; b=GMi+ETTbk4X6qgD3PokukDGSsH+2
        PnRmIXUtPxqu+MYA0fdhlKI8hzBJwWFhnDf4OW7gzBAJq8oADX4gRg5WOYp/8hWq
        sdOfTPd5qQk+zTQTkSoh2+t8hhfIGseMpP4ItjY4cPpqNPkkDoYHNJJbPJy49X31
        F8S70P8enEsXcBQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8B57C12E2AA;
        Mon, 10 May 2021 00:14:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BAAB912E2A9;
        Mon, 10 May 2021 00:14:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 2/2] pretty-formats.txt: add missing space
References: <cover.1620551314.git.martin.agren@gmail.com>
        <3d06c3beee0299db369f1dd859b092d529bd6846.1620551314.git.martin.agren@gmail.com>
        <CAOLTT8R2ACJtcL7esLd8AiSu22Wn2hrdVTwub-HXc-eT_U2-+w@mail.gmail.com>
        <CAN0heSqi9v3dGgGFSGB7J-17MJj9jOvMwC6x7pW1bRGwra5N2g@mail.gmail.com>
Date:   Mon, 10 May 2021 13:14:34 +0900
In-Reply-To: <CAN0heSqi9v3dGgGFSGB7J-17MJj9jOvMwC6x7pW1bRGwra5N2g@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Sun, 9 May 2021 17:27:55
 +0200")
Message-ID: <xmqqo8djrzrp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3AD4CBC2-B146-11EB-A0D8-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> Ah, thanks for the pointer. It looks like this was merged to "next" in
> 2320ad8fb0 ("Merge branch 'zh/pretty-date-human' into next", 2021-04-30=
), so a
> few days before you sent v4.
>
> Junio probably missed v4 entirely, or he might have responded with some=
thing
> like "v3 is already in next, so please build incrementally on top of it=
".
>
> Thanks for contributing this functionality. I quite like the "human" fo=
rmat.

Thanks, I think that is exactly what happened, except that I wrote
the message but it is still in my draft mailbox without being sent
;-)



