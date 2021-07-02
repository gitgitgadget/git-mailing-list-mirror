Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BA7C11F68
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 15:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 421926142B
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 15:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbhGBPZs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 11:25:48 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54313 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbhGBPZs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 11:25:48 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D7F6114C872;
        Fri,  2 Jul 2021 11:23:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=FN+qiF7VWrnf
        9BkAxoFgrGyHNMtRWKo+36pwr6x0IRs=; b=Lse3WnZGNtgau74MeCWsFdU7XXzM
        SsiWUt2D2j2DJRL0gaAvkeY7nwwJcNjjO6cN13SiwU69hpfByePhGZ6zG1vJSN+1
        Qe18pL/73unCUBUj+qXrNewW+k0NpItrRQTjbiNVhiKHZdaPceSrvnSO9XmwMOxb
        /9iy4IkUg6k//+8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D04E514C871;
        Fri,  2 Jul 2021 11:23:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 30BC314C870;
        Fri,  2 Jul 2021 11:23:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Git List <git@vger.kernel.org>,
        Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>
Subject: Re: Should we do something with #git-devel on Freenode?
References: <CAJoAoZ=e62sceNpcR5L5zjsj177uczTnXjcAg+BbOoOkeH8vXQ@mail.gmail.com>
        <YKViF9OVLeA95JPH@google.com> <20210520071141.GZ8544@kitsune.suse.cz>
        <YKaaBj0KmJ3K5foC@coredump.intra.peff.net>
        <xmqqwnrtt84s.fsf@gitster.g> <87wnq8ap2n.fsf@evledraar.gmail.com>
Date:   Fri, 02 Jul 2021 08:23:11 -0700
In-Reply-To: <87wnq8ap2n.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 02 Jul 2021 14:15:10 +0200")
Message-ID: <xmqq35swrb8g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6A94FE4A-DB49-11EB-9F56-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I don't know if it was formally decided, but it seems the standup is in
> fact happening on liberachat recently. Could you update the calendar
> entry in your "Git" calendar[1] to s/irc.freenode.org/irc.libera.chat/g=
?
>
> 1. https://calendar.google.com/calendar/embed?src=3Djfgbl2mrlipp4pb6iei=
h0qr3so%40group.calendar.google.com

Will do.

I'll also add you to the editors of that calendar (Thomas Gummerer
has been a helping editor, now I'll volunteer you as well ;-)
