Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF40C433EF
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 21:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92B3A6103D
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 21:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbhIFVxu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 17:53:50 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54359 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236600AbhIFVxt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 17:53:49 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B89D01596B0;
        Mon,  6 Sep 2021 17:52:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ScczZ+T4uuHG
        FKxjKVZSyfoHa165PBCOxpKaeNkOrws=; b=SMplPHgx0qrarTQVHw1k7sDUH7o1
        GkUdAia4T/2ZU4DEKxs8IM41G3QtEDBEh7FHD+KePzvuER4DDKEDmBwDECODeHdJ
        a+Zhh2jfsaY+HVeNwos21eXYa1ka475lvqeVy8/i5mk86rxKNDStlS3ZFQ6vJz+a
        g85fm+te3IyOANs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B11A41596AF;
        Mon,  6 Sep 2021 17:52:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0518A1596AE;
        Mon,  6 Sep 2021 17:52:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2021, #01; Thu, 2)
References: <xmqq35qmiofp.fsf@gitster.g>
        <CAPUEspgnRFNRoFuEvP1hpY3iKukk3OnF4zk85wkdkmiVuPuRTw@mail.gmail.com>
        <87tuiynhq4.fsf@evledraar.gmail.com>
Date:   Mon, 06 Sep 2021 14:52:39 -0700
In-Reply-To: <87tuiynhq4.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 06 Sep 2021 12:02:26 +0200")
Message-ID: <xmqq8s09e5i0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C2270CEC-0F5C-11EC-8A4E-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Mon, Sep 06 2021, Carlo Arenas wrote:
>
>>> * fs/ssh-signing (2021-08-29) 9 commits
>...
>     I'm also interested in this one. My reading of
>     <9075cdd1-e34d-5dcb-f2b8-69ae4abf587b@gigacodes.de> is that the aut=
hor
>     plans to re-roll it sometimes around mid-September. I personally pu=
nted
>     on reviewing the current version while waiting for that.

Ouch.  Let's eject it and wait for the promised reroll, then.

Thanks.
