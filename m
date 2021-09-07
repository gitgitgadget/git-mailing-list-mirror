Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC569C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 17:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93AC4610C8
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 17:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbhIGRkp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 13:40:45 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50602 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhIGRko (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 13:40:44 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9D2C215F13A;
        Tue,  7 Sep 2021 13:39:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=pLYJAH7W6Rme
        PsaamJ1tZKOFFbJbOXXuE3tgn9sgCgs=; b=PDissUldbK1guEmXU6ripjCNkzLL
        BsahMAR3c6tzpqDsORDg5VXCZirg3+MBDJdB3bkwUOtuAsSIChQzJOt8i3QFBMBd
        UOIvzs4EetdSy3yI3sOkLMEaUA1/PJXdSz3ZaoqbyybhlbnASnnJY2nE5Xx4gAuV
        jN7MmAGpblxytr0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7F7AF15F139;
        Tue,  7 Sep 2021 13:39:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C324F15F137;
        Tue,  7 Sep 2021 13:39:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>
Cc:     Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2021, #01; Thu, 2)
References: <xmqq35qmiofp.fsf@gitster.g>
        <CAPUEspgnRFNRoFuEvP1hpY3iKukk3OnF4zk85wkdkmiVuPuRTw@mail.gmail.com>
        <87tuiynhq4.fsf@evledraar.gmail.com> <xmqq8s09e5i0.fsf@gitster.g>
Date:   Tue, 07 Sep 2021 10:39:33 -0700
In-Reply-To: <xmqq8s09e5i0.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        06 Sep 2021 14:52:39 -0700")
Message-ID: <xmqq35qgcmju.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 90DEA1F8-1002-11EC-8E59-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Mon, Sep 06 2021, Carlo Arenas wrote:
>>
>>>> * fs/ssh-signing (2021-08-29) 9 commits
>>...
>>     I'm also interested in this one. My reading of
>>     <9075cdd1-e34d-5dcb-f2b8-69ae4abf587b@gigacodes.de> is that the au=
thor
>>     plans to re-roll it sometimes around mid-September. I personally p=
unted
>>     on reviewing the current version while waiting for that.
>
> Ouch.  Let's eject it and wait for the promised reroll, then.

Actually, let's not do so immediately.  As I wrote in
https://lore.kernel.org/git/xmqq4kawcmqg.fsf@gitster.g/ I'd like to
wait and decide after seeing how big the fix need to be.

Thanks.
