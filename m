Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE0BC4363A
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 17:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA62E20725
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 17:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aC3v0K7C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgJ2Ruc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 13:50:32 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60124 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgJ2Rub (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 13:50:31 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A33CE101EA3;
        Thu, 29 Oct 2020 13:50:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=2nxgbxBzUXfY
        4Ais+5jEZk+zM/4=; b=aC3v0K7CcoAf+B2VwPKbxRQmXxfme5OPe8unz/cWHN51
        6BVuhdTphbYvk2Use8e8T8HUE2/pTYH6M4SQVzcZ8/VoaYYuCGxctZ2K+DCILwcm
        e9981s3j2WQjDhqZZgaWBmdrYndBaVZmWPcExdG0xe06m5+S8M9j+6zcY/j5D8w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Rf5QjH
        78NaR+qCZqZY7oe1Z5b909EsmKxwbhCLq4HquXQFFV9K0EQUQw+0u6JyXdQtywK0
        zDNHFofCpHoLyGcRaRL15h/JYICjx5vdEg+XKE2tEV67J3t1Mv7c1YY0yU7flF8L
        ULnsHyAPttC2jC92cW48jTchzrtdbyASlU7TA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9BACC101EA2;
        Thu, 29 Oct 2020 13:50:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E57DC101E9E;
        Thu, 29 Oct 2020 13:50:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?utf-8?B?0JvRkdGI0LAg0J7Qs9C+0L3RjNC60L7Qsg==?= 
        <lesha.ogonkov@gmail.com>, Stefan Haller <lists@haller-berlin.de>,
        Alexey via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>
Subject: Re: [PATCH] Fix zsh installation instructions
References: <pull.814.git.git.1593687080695.gitgitgadget@gmail.com>
        <xmqqr1to8dv9.fsf@gitster.c.googlers.com>
        <abc4ab95-ed65-1d6b-e964-73734c08cda9@haller-berlin.de>
        <CAMP44s3=CUmx_7DCExK7L4trZvQTxO67Qk20eexsP3su-3RyKQ@mail.gmail.com>
        <abc34ced-0c0f-4024-a50c-30e4ca31b325@haller-berlin.de>
        <CAKU+SVKad4q-2tTrYXa+DJBz5UJOtndEe3-4Uvnd5GZ92543ng@mail.gmail.com>
        <xmqqwnzbbfsi.fsf@gitster.c.googlers.com>
        <CAMP44s2DR=pV3frOePMbSyikA-KonZ5XWD7o5SqKhUbzohAFtQ@mail.gmail.com>
Date:   Thu, 29 Oct 2020 10:50:25 -0700
In-Reply-To: <CAMP44s2DR=pV3frOePMbSyikA-KonZ5XWD7o5SqKhUbzohAFtQ@mail.gmail.com>
        (Felipe Contreras's message of "Tue, 27 Oct 2020 19:45:00 -0600")
Message-ID: <xmqqtuuc7wgu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3A47DF42-1A0F-11EB-83A9-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Tue, Oct 27, 2020 at 2:00 PM Junio C Hamano <gitster@pobox.com> wrot=
e:
>>
>> =D0=9B=D1=91=D1=88=D0=B0 =D0=9E=D0=B3=D0=BE=D0=BD=D1=8C=D0=BA=D0=BE=D0=
=B2  <lesha.ogonkov@gmail.com> writes:
>
>> So,... even though it may look to more experienced zsh users that it
>> is unnecessary to document it in this file, in your opinion, it is a
>> good idea to mention "compinit" to help less experienced users?
>
> The first time you run zsh you are greeted with a configuration dialog
> that includes this question:

Ahh, yes, that reminds me why I gave up trying it out the last time.
The large dialog asking my permission to contaminate ~/.* was simply
too scary and distasteful for a "dip my toe in the water" sightseer.

> If you don't turn on completion, the completion doesn't work for *any* =
command.
>
> I think most users would understand why git completion doesn't work if
> completion doesn't work for any command.

OK, that sort of makes sense.

> I would rather leave it out.

Makes sense.  Instead of adjusting my rerere database for that,
ejecting lo/zsh-completion topic would be easier---what the other
half of that patch does is already in your 29-patch series.

Thanks.
