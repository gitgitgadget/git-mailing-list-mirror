Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAEE81F453
	for <e@80x24.org>; Sat,  3 Nov 2018 10:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbeKCTOC (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 15:14:02 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:37550 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbeKCTOB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 15:14:01 -0400
Received: by mail-wm1-f43.google.com with SMTP id p2-v6so3761782wmc.2
        for <git@vger.kernel.org>; Sat, 03 Nov 2018 03:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=EaJ+ms/4CcTF7uFhl7E+fdio3k0CRTJ4kboweiNHB1Q=;
        b=sA0rb//OlZ09rDvljbIYGy37f7Bssw1t6yu2XpNUT1wKXJ1HxxxjiKPqKg+dlgrIKw
         pBN+gfPdPyb42SRCfm2CwEwcPBhWQLiCwd6miJY2J/QcbpQYvbvL26KQrSEsEgBDuPyQ
         R6l4UW/lYSusZP8SL84cC0n+oGVcX+Vwpc4pO3VwxI+fLVnXsF0bwCCjnMOP5QuHOhU0
         7KfcYmxM2rnu8vjCB7ML3TuTHoTRBuBKH/MopAr/HZRiLuLP1nl+nUQVo+B42kuLUpBA
         PcOWDLK/htJjn2BW55piKjvV14CL3z1lZTRnvAX57SUipQIQHuzql2I2mpdOyJe/lrGY
         zV0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=EaJ+ms/4CcTF7uFhl7E+fdio3k0CRTJ4kboweiNHB1Q=;
        b=D0hmLm/NEB10xz/ojd1+53dSfKujcrd7yP6c5VQfi3UHCabYy/QwtT3t7F6DZHZwWS
         OI7ph7c6wvL8oDGG6/jg9GqBWLii0lthByj1tXGQP2jQo0qSTukGWOsjOXfZbkNxRk2k
         NXz3lEALkrS/iQInyDNrcHKRBKKhIqgyyitQhQ5E9JruJ6O2ViVy/MQA1ZK8pJAu7aQP
         B6gPskkgDSE52xmmqX2ZO3kI2sCxgcAK2RVOm6AvhHueyrpVUbz7fLGGdyDKZr6XZp6N
         UUtihrpGUvXQ0q2StDwHpmd8zqw6/206ZCaaizYX6p1Vr59C9JKBGMc8QwpZG8VxGeHn
         Nxeg==
X-Gm-Message-State: AGRZ1gIAnRpOFdDeBIrO9NUBIBgQiG1GyyNSi2XLuOQJ1uLWdgRd6vNH
        TQNcMGy+aue4FMir72pDcL4=
X-Google-Smtp-Source: AJdET5ekTjfOSlQxxpInr5fCCMIZIfTrABuBCav1tvMSp7ZEFZ0eW223HCih5gb/nWh/nPY/x0IwSg==
X-Received: by 2002:a1c:bce:: with SMTP id 197-v6mr446704wml.15.1541239392861;
        Sat, 03 Nov 2018 03:03:12 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y19-v6sm17756569wma.7.2018.11.03.03.03.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 03 Nov 2018 03:03:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
Cc:     Derrick Stolee <stolee@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git Test Coverage Report (Friday, Nov 2)
References: <784741be-6045-12bb-75b9-0df6f4c612b7@gmail.com>
        <xmqqva5en832.fsf@gitster-ct.c.googlers.com>
        <1541231868.1028.2.camel@gentoo.org>
Date:   Sat, 03 Nov 2018 19:03:09 +0900
In-Reply-To: <1541231868.1028.2.camel@gentoo.org> (=?utf-8?Q?=22Micha?=
 =?utf-8?Q?=C5=82_G=C3=B3rny=22's?= message of
        "Sat, 03 Nov 2018 08:57:48 +0100")
Message-ID: <xmqqr2g2mqaq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michał Górny <mgorny@gentoo.org> writes:

> As for how involved... we'd just have to use a key that has split
> signing subkey.  Would it be fine to add the subkey to the existing key?
>  It would imply updating keyids/fingerprints everywhere.

Yes, that "everywhere" is exactly what I meant by "how involved",
and your suggestion answers "very much involved".

If we can easily add _another_ key with a subkey that is not the
primary one we use for other tests, without touching the existing
key and the existing tests that use it (including the one I touched
below--- we'd want to see a sig with a key that is not split is
shown with the same %GF and %GP), while adding a handful of new
tests that create signed objects under the new & split key and 
view them with %GF and %GP, then the end result would be that we
managed to add a new test case where %GF/%GP are different without
making very much involved changes.  I guess that was what I was
getting at.

Thanks.

>
>> 
>>  t/t7510-signed-commit.sh | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
>> index 19ccae2869..9ecafedcc4 100755
>> --- a/t/t7510-signed-commit.sh
>> +++ b/t/t7510-signed-commit.sh
>> @@ -176,8 +176,9 @@ test_expect_success GPG 'show good signature with custom format' '
>>  	13B6F51ECDDE430D
>>  	C O Mitter <committer@example.com>
>>  	73D758744BE721698EC54E8713B6F51ECDDE430D
>> +	73D758744BE721698EC54E8713B6F51ECDDE430D
>>  	EOF
>> -	git log -1 --format="%G?%n%GK%n%GS%n%GF" sixth-signed >actual &&
>> +	git log -1 --format="%G?%n%GK%n%GS%n%GF%n%GP" sixth-signed >actual &&
>>  	test_cmp expect actual
>>  '
>>  
