Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA47D207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 21:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934387AbcI2Vbo (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 17:31:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59994 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934363AbcI2Vbn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 17:31:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4D5A842DF3;
        Thu, 29 Sep 2016 17:31:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=wvLlzERePYTz
        DHdDU2id+jhoCgQ=; b=LAs0QieHZy0G72VgnihZ56KivS5F/O0XFkRY5IgxkvAu
        gQziZaHvTq3g5lx4QKLbcTVMglT/lpLX8lRX/CVlUGSu3zcnGX/rrzCMFikxkMOe
        U/tf4LAT1aFOkvlBlpPvCwCDngTpuVXQD3h/FDT4vHatrFS4yCrBzAgFUM13jU8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Wpk0/u
        bmLYvSvD9m9cOQeFbZOB9QMWL7gqR6OgsW0fMY5aH1wrKGUMPwYoAfOyH85MJqNW
        k4CyDO7TE3Awv7LOKVGoWX9mz/n6xdqOtPCa9DlHkejDZRD075+QbsikNGN2OFaA
        dLAZi7aG7Bz/0qQ2DP66f0gsYW5ClPnIj4pTs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 457E342DF2;
        Thu, 29 Sep 2016 17:31:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B7FFD42DF1;
        Thu, 29 Sep 2016 17:31:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>, git@vger.kernel.org,
        Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2 02/11] i18n: add--interactive: mark simple here documents for translation
References: <1472646690-9699-1-git-send-email-vascomalmeida@sapo.pt>
        <1472646690-9699-3-git-send-email-vascomalmeida@sapo.pt>
        <xmqqmvivy4i9.fsf@gitster.mtv.corp.google.com>
        <1475159493.2435.7.camel@sapo.pt>
        <xmqqfuoihc1m.fsf@gitster.mtv.corp.google.com>
        <07371844-7fde-5b7f-b9e1-7db1a54fdbb5@gmail.com>
Date:   Thu, 29 Sep 2016 14:31:38 -0700
In-Reply-To: <07371844-7fde-5b7f-b9e1-7db1a54fdbb5@gmail.com> ("Jakub
        =?utf-8?Q?Nar=C4=99bski=22's?= message of "Thu, 29 Sep 2016 23:27:24
 +0200")
Message-ID: <xmqq1t02e6kl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1C37610A-868C-11E6-BE3F-C26412518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> W dniu 29.09.2016 o 19:05, Junio C Hamano pisze:
>> Vasco Almeida <vascomalmeida@sapo.pt> writes:
>>=20
>>> On the other hand, would it make sense to translate these commands? I=
f
>>> so, we would mark for translation the commands name of @cmd in
>>> main_loop().
>>>
>>>  sub main_loop {
>>> -       my @cmd =3D ([ 'status', \&status_cmd, ],
>>> -                  [ 'update', \&update_cmd, ],
>>> -                  [ 'revert', \&revert_cmd, ],
>>> -                  [ 'add untracked', \&add_untracked_cmd, ],
>>> -                  [ 'patch', \&patch_update_cmd, ],
>>> -                  [ 'diff', \&diff_cmd, ],
>>> -                  [ 'quit', \&quit_cmd, ],
>>> -                  [ 'help', \&help_cmd, ],
>>> +       my @cmd =3D ([ __('status'), \&status_cmd, ],
>>> +                  [ __('update'), \&update_cmd, ],
>>> +                  [ __('revert'), \&revert_cmd, ],
>>> +                  [ __('add untracked'), \&add_untracked_cmd, ],
>>> +                  [ __('patch'), \&patch_update_cmd, ],
>>> +                  [ __('diff'), \&diff_cmd, ],
>>> +                  [ __('quit'), \&quit_cmd, ],
>>> +                  [ __('help'), \&help_cmd, ],
>>=20
>> I don't know offhand.  If the code to prompt and accept the command
>> given by the user can take the translated word (or a prefix of it),
>> theoretically I would say it could be made to work, but to me it is
>> dubious the benefit outweighs its downsides.  It would make teaching
>> Git and troubleshooting over the phone harder, I would guess.
>>=20
>>  A: "Hi, I am in a 'git add -i' session."
>>  B: "Give 's' at the prompt."
>>  A: "My Git does not seem to take 's' as a valid command."
>>  B: "What? I've never seen that problem."
>>  ... back and forth wastes 10 minutes ...
>>  A: "By the way, I am running Git in Portuguese."
>
> Also, for one-letter commands to work (there is setting where you
> don't even need to press enter, IIRC) all those translations would
> have to be chosen to begin with different letter, isn't it?

The original was written with an explicit expectation that these
command words will not be translated adn chose words that do not
share the first letter exactly for that reason.

Having said that, if somebody is willing to i18n the command words,
I'd expect that the command line prompt interaction would be updated
to take the unique prefix instead of the "first byte", and if that
happens, I think the resulting system would at least be internally
consistent.

It is still dubious to me if the benefit of i18n outweighs its
downsides, though.



