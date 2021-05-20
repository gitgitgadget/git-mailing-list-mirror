Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436E7C433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 21:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03CD3613BF
	for <git@archiver.kernel.org>; Thu, 20 May 2021 21:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhETVVr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 17:21:47 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51388 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhETVVq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 17:21:46 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8F3F811D7D2;
        Thu, 20 May 2021 17:20:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zJKEC1eee+e8XBXp2ABs3JYXVz1+sEh3VgEqYq
        srG+I=; b=hfQ7ClgB8MWdlrvd/f0NjgnNJ+egieWygkTJIBXJuylbbe37Hehqns
        hktrZyFXkBgTJPS+HtdqxPpN8cOZG2xqWXSLHvohH30poFbV87hqT7lAoeXbu8xm
        upqTOxKXQnBHas/0i1XWhgznLvzNmlavSwQpkXOc86+qgfEYG7VrI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 87CA911D7D1;
        Thu, 20 May 2021 17:20:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B6A7E11D7D0;
        Thu, 20 May 2021 17:20:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Git List <git@vger.kernel.org>,
        Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>
Subject: Re: Should we do something with #git-devel on Freenode?
References: <CAJoAoZ=e62sceNpcR5L5zjsj177uczTnXjcAg+BbOoOkeH8vXQ@mail.gmail.com>
        <YKViF9OVLeA95JPH@google.com> <20210520071141.GZ8544@kitsune.suse.cz>
        <YKaaBj0KmJ3K5foC@coredump.intra.peff.net>
Date:   Fri, 21 May 2021 06:20:19 +0900
In-Reply-To: <YKaaBj0KmJ3K5foC@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 20 May 2021 13:19:02 -0400")
Message-ID: <xmqqwnrtt84s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2F3A39DC-B9B1-11EB-8F71-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> decision. Likewise for irc. I don't think #git or even #git-devel has
> any official status. It is simply where people doing things chose to go.
> Now they may choose to go somewhere else, but they don't necessarily
> have to do it as a unit.

FYI I contacted https://libera.chat/ to register "as a project",
primarily to prevent other folks squat on #git and #git-*; if we
decide to move our bi-weekly "Git Standup" there, it may turn out to
be useful.


