Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4848C0015E
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 18:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjHASMg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Aug 2023 14:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjHASMd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 14:12:33 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1612136
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 11:12:30 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 84D2018CEC2;
        Tue,  1 Aug 2023 14:12:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=UPlis7IGe/s/
        f3R68gVkYjynl2TOt0x0j5dXCD7Zj0o=; b=NlSVCF8ZUjGj07X8uEWUXZoCDJvn
        eDR+yZEVNZHczVSc0OUwgTcbbnY/4x4IgVYNyaP09iTCpN22EIZ235nzaj+juPIq
        /0sQbrH9KNUZoA0Aelmoejxu5u6DxTp7cx8LqFEobFP7SScnyTCn6v6fMOOoNiyt
        PfetWjPqxemUyog=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7C6AE18CEC1;
        Tue,  1 Aug 2023 14:12:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E3DAB18CEBE;
        Tue,  1 Aug 2023 14:12:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <nasamuffin@google.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2023, #07; Mon, 31)
References: <xmqqmszcynem.fsf@gitster.g>
        <CAJoAoZk1WiCSDqFXccG4FiwYhWUuWWmFz+ZqiXhacmfjZuE6FA@mail.gmail.com>
Date:   Tue, 01 Aug 2023 11:12:27 -0700
In-Reply-To: <CAJoAoZk1WiCSDqFXccG4FiwYhWUuWWmFz+ZqiXhacmfjZuE6FA@mail.gmail.com>
        (Emily Shaffer's message of "Tue, 1 Aug 2023 10:38:17 -0700")
Message-ID: <xmqqzg3abpis.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F9CFF6BA-3096-11EE-B0E2-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <nasamuffin@google.com> writes:

> On Mon, Jul 31, 2023 at 10:57=E2=80=AFAM Junio C Hamano <gitster@pobox.=
com> wrote:
>> * es/recurse-submodules-option-is-a-bool (2023-04-10) 1 commit
>>  . usage: clarify --recurse-submodules as a boolean
>>
>>  The "--[no-]recurse-submodules" option of "git checkout" and others
>>  supported an undocumented syntax --recurse-submodules=3D<value> where
>>  the value can spell a Boolean in various ways.  The support for the
>>  syntax is being dropped.
>>
>>  Have been expecting a reroll for too long.
>>  cf. <ZDSTFwMFO7vbj/du@google.com>
>>  source: <ZDSTFwMFO7vbj/du@google.com>
>
> Yeah, sorry about the annoying wait. It's not something I have time to
> reroll soon - but it's on the short list for "up next" bugs for my
> team to get a reroll. We still intend to reroll and push through, but
> I don't have an ETA. I'll leave it up to you to decide whether to keep
> it in seen or drop it with that information.

I actually do not quite understand this ;-) It wouldn't take more
than 20 seconds to read the "minimally touched-up version" sent
months ago https://lore.kernel.org/git/xmqqfs97cozz.fsf@gitster.g/
and say "yeah, that is perfect and please queue with the fixup" ;-)

Or are there still further changes in behaviours planned?

Thanks.
