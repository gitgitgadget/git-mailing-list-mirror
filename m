Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73BC6208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 14:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403779AbeHGRJs (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 13:09:48 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37399 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389230AbeHGRJn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 13:09:43 -0400
Received: by mail-wm0-f51.google.com with SMTP id n11-v6so18425532wmc.2
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 07:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=k/2Vmg6W3e78YzsE+eB9sv34SiK46RpcCOUMX9Hq8wM=;
        b=e1Y5b2dC/Zd4ksXPk4kYfwev0ZIDt2ifJQIsmBUbguMKfBG/9qczjRGSKXphrFvwQB
         k4FapNowdoSjl1qMbp18kwr+fcutAKYuJymkNicXQ61QEAQ4Y0s/SenFwkIhf45am3jX
         5s+mWffdWmkV2Wwz8bEYotCz5MhGn3ZUJzW8lfEOxPG6+7vydh7cQwGr9oQTHDxoMBgv
         GbgYIWS/oMgnfJwVMVR7ylDBzFOta/7yxN9ZTfEqsP6mmQzV4kclHzD1rmQSJsUzYFYo
         FkAXvDiveC9iqWh545PxXtSkn2BggDgfBBf9XmcmV8hYICrFbc027/ybyytNfwocqmQ/
         GuAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=k/2Vmg6W3e78YzsE+eB9sv34SiK46RpcCOUMX9Hq8wM=;
        b=qmvKXQWNo3vKIFE7BexRZFhHt9BzoLDJs0SyJ7o6eeTs9LNJbDWiRXZMm0k16t9nmT
         BrSq4Q954y0MDxAyKqe25dOYOS8z77KYANZ5NrrwQOcfultVAuBOKBYpYC+EW2HCXNi/
         CnrF6rpJ74EtKt9zQtkHt5di93hQnelD1pDvfy+Wh0JuSuzKfnPRxOxk4Iskppi8fC7C
         GtwET8GjACaoHHI28Tz6gClsXVgj37fIpkExK1HV+S+JhgMDkomT00HKcmf62qDPGwvU
         kqDQnh3YYR9kbiuEr/RVP3h6JJjIqGRMi8xB27Pb1aVUtWtcYOZeJCraWn5QpDuNb8Uw
         Lr2g==
X-Gm-Message-State: AOUpUlEce2lCgpIgkt/OIPHHa6ThZ49TjjVTRkxJwEYY69ejeB0Dth4X
        +dr3VHQQu1CmRE/9Lwb+S9J2dc+u
X-Google-Smtp-Source: AA+uWPyqwkMMWAM1OY7WugBxaMN9E6EBPZBDMNZF8jRIdm779P288gWG2JuugsTdjGy4FiVbyUApvA==
X-Received: by 2002:a1c:70b:: with SMTP id 11-v6mr1902185wmh.151.1533653700565;
        Tue, 07 Aug 2018 07:55:00 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l4-v6sm1519151wrv.23.2018.08.07.07.54.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 07:54:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2018, #02; Mon, 6)
References: <xmqqtvo7m8c0.fsf@gitster-ct.c.googlers.com>
        <87tvo6snll.fsf@evledraar.gmail.com>
Date:   Tue, 07 Aug 2018 07:54:59 -0700
In-Reply-To: <87tvo6snll.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 07 Aug 2018 08:21:58 +0200")
Message-ID: <xmqqa7pymdks.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Mon, Aug 06 2018, Junio C Hamano wrote:
>
>> * ab/newhash-is-sha256 (2018-08-06) 2 commits
>>  - doc hash-function-transition: pick SHA-256 as NewHash
>>  - doc hash-function-transition: note the lack of a changelog
>>
>>  Documentation update.
>>
>>  Will Merge to 'next'.
>
> The tip of gitster/ab/newhash-is-sha256 has a unicode-corrupted
> signed-off-by line from me. See
> https://github.com/git/git/commit/f855a19d45 not sure how that got
> there...

Hmph, it came from this message (most headers omitted)

    To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
    Message-ID: <20180804085247.GE55869@aiede.svl.corp.google.com>
    Content-Type: text/plain; charset=iso-8859-1
    Content-Disposition: inline
    Content-Transfer-Encoding: 8bit

    Subject: doc hash-function-transition: pick SHA-256 as NewHash

    ...

    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

and the body seems to be correct iso-8859-1.  "od -cx" tells me that
the file stores 0xf0 for that D looking thing, for example.  Could it
be mailinfo that screws up, I wonder.  A quick check with "git mailinfo"
does not give me anything suspicous---the info contents emitted to
its standard output is correctly converted to UTF-8.  Puzzled...

I read from public-inbox/git over nntp, if that matters.
