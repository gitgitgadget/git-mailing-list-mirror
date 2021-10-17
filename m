Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0E4C433EF
	for <git@archiver.kernel.org>; Sun, 17 Oct 2021 01:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D967961053
	for <git@archiver.kernel.org>; Sun, 17 Oct 2021 01:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241375AbhJQBRA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Oct 2021 21:17:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63353 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbhJQBRA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Oct 2021 21:17:00 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0FB81E2A13;
        Sat, 16 Oct 2021 21:14:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=0jP9t5I9rQcr
        uygqd0oN/R5IxXwWnhsSdFoO+/lk0HU=; b=UAao2ppbsQ804mZ/B9pkDjfXULM4
        tfJDRwZE4G9gxaO5Q/rc7Nhupn+sMbn3ETSMwv8T2rHtC3z6GVcwyoUzTcdOoLNt
        1AgOSDMMDTGw0OIq32BKMj5IPql8tmYcIZSl8lF5YYDwBdo5mZ+hB25wKt9eGux8
        dmxDODSPKeagRmY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 07C3DE2A12;
        Sat, 16 Oct 2021 21:14:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 712E2E2A10;
        Sat, 16 Oct 2021 21:14:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: Build failure of 'seen'
References: <48748e0e-7c18-b7ff-e1c3-ac0733cc7d34@ramsayjones.plus.com>
Date:   Sat, 16 Oct 2021 18:14:49 -0700
In-Reply-To: <48748e0e-7c18-b7ff-e1c3-ac0733cc7d34@ramsayjones.plus.com>
        (Ramsay Jones's message of "Sun, 17 Oct 2021 00:18:19 +0100")
Message-ID: <xmqqo87o1mgm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A062F7E2-2EE7-11EC-8951-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Hi Junio,
>
> Tonight's build of 'seen' failed for me (on Linux and Cygwin):

Yes, I saw the same with the report at

https://lore.kernel.org/git/xmqqh7djba6e.fsf@gitster.g/

the ball is in =C3=86var's court.

Thanks.
