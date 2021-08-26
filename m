Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05277C432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 21:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAEF360FD8
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 21:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243660AbhHZVhg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 17:37:36 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63011 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243652AbhHZVhg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 17:37:36 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 698F114C4A0;
        Thu, 26 Aug 2021 17:36:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=EijZsuvT5Ntw
        iqDV2W45Y61rltC/KbnRMtCAfKZuvCg=; b=gTGScd/JjTUTzTVp1eYm4ghcri4S
        gZAHXt6mbat/SfAm7V+UZIX4wWEQ58HGmNZC1+vP6RjDhVZGh5t48fqOcszWzRQf
        u6gCv2rxWOvwOdsBe/74DwgORW3dcdIdXrtOf3CHWorLY33n3xp2VLlTHaghlmfB
        1yEjRnSnmWSrWRo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6219514C49E;
        Thu, 26 Aug 2021 17:36:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9817F14C498;
        Thu, 26 Aug 2021 17:36:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] column: fix parsing of the '--nl' option
References: <20210818092456.3045808-1-szeder.dev@gmail.com>
        <xmqqy28y4gqt.fsf@gitster.g> <20210826212529.GF2257957@szeder.dev>
Date:   Thu, 26 Aug 2021 14:36:43 -0700
In-Reply-To: <20210826212529.GF2257957@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message
        of "Thu, 26 Aug 2021 23:25:29 +0200")
Message-ID: <xmqqbl5jdh1w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B6255B4C-06B5-11EC-9DF0-FA11AF6C5138-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> Eleven other tests look just like the one I added.  I really don't
> think that doing it in some other way would gain us anything, but it
> would be inconsistent with the rest.

Fair enough.
