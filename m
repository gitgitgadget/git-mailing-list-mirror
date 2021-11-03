Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80ED7C433F5
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 16:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5847A6103B
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 16:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbhKCQf0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 12:35:26 -0400
Received: from pb-sasl-trial2.pobox.com ([64.147.108.86]:63242 "EHLO
        pb-sasl-trial2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhKCQfZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 12:35:25 -0400
X-Greylist: delayed 376 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Nov 2021 12:35:25 EDT
Received: from pb-sasl-trial2.pobox.com (localhost.local [127.0.0.1])
        by pb-sasl-trial2.pobox.com (Postfix) with ESMTP id 82EAA29185;
        Wed,  3 Nov 2021 12:26:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=q9bkcn+lYtZ3Jyp5U1Acd1MEsQ0=; b=Ng0Wvm
        +Q3RtcsHDbImrs9SPDrkrt8yxCoNUSKcwUtqMx8YWi4iKLKCIVBO2BJYCahLQWh+
        bs2UNEyOs6T9gpZu5tHsTom9BdTZKrspIFymuW6P+3/VigIogyrSc8P3+z8eUFRH
        aBFe5CIIQVE5EiDwq4SCsQR3saPhuQ097XuUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Xv9qnFh6M9ogP50fivRhvv9t++pHluED
        mmLrkvZ+6d69sYfiVTBX1eS5KzRQJ9LZlKdY55eWnfiztVumulkcxJb6ECsBeF2d
        ng8uizj3r+jMlSW+GgiVRx6Hf94kOY392gqiVE+AKCPu3lVEBpp7bVlWZZbbJGU4
        HOPC1Ue1wl4=
Received: from pb-smtp2.nyi.icgroup.com (pb-smtp2.pobox.com [10.90.30.54])
        by pb-sasl-trial2.pobox.com (Postfix) with ESMTP id 62A8A29182;
        Wed,  3 Nov 2021 12:26:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A63B3F356D;
        Wed,  3 Nov 2021 12:26:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>,
        Fabian Stelzer <fs@gigacodes.de>,
        ZheNing Hu <adlternative@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Matthias =?utf-8?Q?R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        Christopher =?utf-8?Q?D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <daniel@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Fangyi Zhou <me@fangyi.io>, Yi-Jyun Pan <pan93412@gmail.com>
Subject: Re: [PATCH v2] i18n: fix typos found during l10n for git 2.34.0
References: <20211031052156.5237-1-worldhello.net@gmail.com>
        <20211101021417.9549-1-worldhello.net@gmail.com>
        <7d9a893e-5dad-bd21-4ef7-6d47303abdc1@gmail.com>
Date:   Wed, 03 Nov 2021 09:26:30 -0700
In-Reply-To: <7d9a893e-5dad-bd21-4ef7-6d47303abdc1@gmail.com> (Bagas Sanjaya's
        message of "Tue, 2 Nov 2021 17:17:22 +0700")
Message-ID: <xmqqpmrh8atl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CDE7EE78-3CC2-11EC-83D6-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

>> diff --git a/ref-filter.c b/ref-filter.c
>> index 282cdad103..08a3f839c9 100644
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -1037,7 +1037,7 @@ int verify_ref_format(struct ref_format *format)
>>   		     format->quote_style == QUOTE_TCL) &&
>>   		     used_atom[at].atom_type == ATOM_RAW &&
>>   		     used_atom[at].u.raw_data.option == RAW_BARE)
>> -			die(_("--format=%.*s cannot be used with"
>> +			die(_("--format=%.*s cannot be used with "
>>   			      "--python, --shell, --tcl"), (int)(ep - sp - 2), sp + 2);
>>   		cp = ep + 1;
>>   
>
> Why not using \n?

It is not quite clear to me why it should.

Among the possible string that is (ep - sp - 2) bytes long (i.e.
--python, --shell, --tcl, --raw), even with the longest, the
resulting message would become

    fatal: --format=--python cannot be used with
    --python, --shell, --tcl.

that is unusually short with such a newline in the middle.
