Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E87FA1F404
	for <e@80x24.org>; Wed, 15 Aug 2018 17:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbeHOUue (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 16:50:34 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35724 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729424AbeHOUue (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 16:50:34 -0400
Received: by mail-ed1-f67.google.com with SMTP id e6-v6so1253994edr.2
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 10:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=PBUrm22iJQxOTiPYJqGT6iofmVtWnr3v/ZuWOTxMUak=;
        b=AiywfujJ8/pmJ/MzlktPgnfSlh6k7FndufmkM5TKCyT3KXmRAkRkTgvN+5QJD6BOPF
         PBT88uE1Ma9eWwRh+lbS3enIpKHgimYE749XBchfqN6qGHIvPu2yeeXQz3eO91NsHRSL
         a7NTvd5iJ/PokiALgC4J3AtpnGgLCY3ceGzXnMjXVd+G4jILVYQP36/0GO5BCXgKmQI0
         aaznFSmCEAJRj671oAd+k1Ss30AOMxLzo3QsV3Cbe/O1k69CQyqxVNaat444mLc3j+K5
         iLeK+HuG4/H5zpBPlhRVBZVrOvvXUJ2srJW9IHat2bsRISnl81sYG143AoNoYi/68N7v
         +ADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=PBUrm22iJQxOTiPYJqGT6iofmVtWnr3v/ZuWOTxMUak=;
        b=eG/LniyMGoWUAe9fCYXa8ScODYfGb9tsnhCOU2uGig45AqABQ9/MkgbwjJzMgCsRUN
         T+NRvqrkuF9NhR9UnWLrL494CQbNydO+/s+NrflYbNSFj8jDvfHbvzBfpam2JywJs+bn
         6tP8om39o0BJnCEKe++2KzestF3bMDPcrukDtfeliHmTVlv3MDkJTBSbP/UqhMzA6rpu
         zY3Mo+AbHTZ+tkULye5PRk6IR+ced9D+esTCipmUoqX+38NdcVn/f//VrIc0uJAJHNMD
         QDTv+TGLex4vR08yjq35yoQHq0UMt2YMPlmUg2fqJgWbnDxVlpnE7ohY8gFF+cvM7Mbb
         49mg==
X-Gm-Message-State: AOUpUlHIrAhY+L2e0wwlBXHJrxvOjl1Z2Gu7DNcwrnXGryLozWcO0KSu
        zQNSPsjPur9gXg02vnk3QxQ=
X-Google-Smtp-Source: AA+uWPyszxMxpF5qjtL7LjdV0ryKCNdCGnm27pJ5E/4YDI1H+CI1AoY3PyyotdNYWsnfZsOrFFr9gg==
X-Received: by 2002:a50:9010:: with SMTP id b16-v6mr33349919eda.110.1534355843880;
        Wed, 15 Aug 2018 10:57:23 -0700 (PDT)
Received: from evledraar (h98111.upc-h.chello.nl. [62.194.98.111])
        by smtp.gmail.com with ESMTPSA id h8-v6sm9538645edi.68.2018.08.15.10.57.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 10:57:19 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eygene Ryabinkin <rea-git@codelabs.ru>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH] Makefile: extend NO_TCLTK=NoThanks to cover docs
References: <20180815151505.12011-1-avarab@gmail.com> <xmqq7ekrk1q0.fsf@gitster-ct.c.googlers.com> <xmqq1sazk12m.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqq1sazk12m.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 15 Aug 2018 19:57:19 +0200
Message-ID: <87lg97qzr4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 15 2018, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>>  # Guard against environment variables
>>>  MAN1_TXT =
>>> +MAN1_TXT_WIP =
>>> +TCLTK_FILES =
>>
>> The latter name loses the fact that it is to hold candidates to be
>> on MAN1_TXT that happen to be conditionally included; calling it
>> MAN1_TXT_TCLTK or something, perhaps, may be an improvement.
>>
>> The former name makes it look it is work-in-progress, but in fact
>> they are definite and unconditional part of MAN1_TXT.  Perhaps
>> MAN1_TXT_CORE or something?
>
> Sorry, I misread the patch.  You collect all possible MAN1_TXT
> candidates on _WIP, so "this is unconditional core part" is wrong.
> Work-in-progress still sounds a bit funny, but now I know what is
> going on a bit better, it has become at last understandable ;-)

Yeah maybe it should be *_TMP. It's because you can't assign to a make
variable twice (or rather, define a variable in terms of its previous
value via filter). Otherwise I would just munge it in-place.

>>> +ifndef NO_TCLTK
>>> +MAN1_TXT_WIP += gitk.txt
>>> +MAN1_TXT = $(MAN1_TXT_WIP)
>>> +else
>>> +TCLTK_FILES += git-gui.txt
>>> +TCLTK_FILES += gitk.txt
>>> +TCLTK_FILES += git-citool.txt
>>> +MAN1_TXT = $(filter-out \
>>> +		$(TCLTK_FILES), \
>>> +		$(MAN1_TXT_WIP))
>>> +endif
>
> I didn't notice it when I read it for the first time, but asymmetry
> between these two looks somewhat strange.  If we are adding gitk.txt
> when we are not declining TCLTK based programs, why can we do
> without adding git-gui and git-citool at the same time?  If we know
> we must add gitk.txt when we are not declining TCLTK based programs
> to MAN1_TXT_WIP in this section, it must mean that when we do not
> want TCLTK based programs, MAN1_TXT_WIP would not have gitk.txt on
> it, so why do we even need it on TCLTK_FILES list to filter it out?

The only explicitly listed files are those that don't match the wildcard
git-*.txt. Therefore if we want gitk.txt we need to explicitly list only
it, but if we don't want the TCL programs we also need to list the ones
that match git-*.txt.
