Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC10BC433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 23:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236688AbiDMXe7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 19:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiDMXez (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 19:34:55 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358322CE30
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 16:32:31 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7678412D35B;
        Wed, 13 Apr 2022 19:32:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=zRQU/eUpb8uf
        IxUcqq7vPb6WSAgFhtJmIpscSU7zb3U=; b=IW341a2dRaFm5pv9F0YGlVY2hc1E
        OPgHp4rlOKeiUCzGbu/TETWd+rnwFzRvyoqBUjKMVGkRSPwBOM3ROB6b77PPDp5j
        ZUcY2jjXju4pOOi8VGYo3hKOsqRqPseLANhyXIm0Iqoq0pYNkuILhqRcKAiYcpBx
        hRb8OrQQsP839h0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E78812D35A;
        Wed, 13 Apr 2022 19:32:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D49E812D359;
        Wed, 13 Apr 2022 19:32:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: ab/plug-leak-in-revisions
References: <xmqq8rsab5do.fsf@gitster.g>
        <220413.86bkx4eobr.gmgdl@evledraar.gmail.com>
Date:   Wed, 13 Apr 2022 16:32:28 -0700
In-Reply-To: <220413.86bkx4eobr.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 13 Apr 2022 22:08:54 +0200")
Message-ID: <xmqq35ig5zlf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FC40061E-BB81-11EC-BE43-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I think it should be ready with my just-submitted re-roll, which fixes =
a
> trivial nit spotted by Phillip Wood by removing a useless NULL check:
> https://lore.kernel.org/git/cover-v6-00.27-00000000000-20220413T195935Z=
-avarab@gmail.com/

Last time I checked, the last three patches haven't made to the lore
archive yet.  We have other things to do while waiting for them, so
there is no need to rush or resend ;-)

