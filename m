Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DE171F404
	for <e@80x24.org>; Wed, 28 Feb 2018 22:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935316AbeB1WRd (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 17:17:33 -0500
Received: from mail-wr0-f172.google.com ([209.85.128.172]:42914 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935237AbeB1WRb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 17:17:31 -0500
Received: by mail-wr0-f172.google.com with SMTP id k9so4053628wre.9
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 14:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oSOSLbrQPofFEXrOG0ovTZxI9kVfA06ZFszJsVXQcLw=;
        b=uIUoVQ2pyfjvBlBKBC27FNVu5L0ZxSl3if+twUjc1Nt+dyACDy+S9M9PYTqmrqOqIM
         9xmjGId2Uco06xdJ6wvUk1KqsfESF2rENPr1miS+F0CpFQXBjiVZ6BsdW1oVl5E1+rgc
         bYGBzMfdTyDsbHEbBRFR2C7bNOP+lmWc+//MnnpRZU6qSYwSO9cXkiZJs9YRp4btKdwa
         WTd1ZbVqwEzvuVplliqhVn4m0NanDBDYSTA3R+26Nrykonwl5/K+qyAoc8cXNJxdpdXJ
         KNiiFmMf8WI7c5zWaBImJTB9kR1iS8RbXVWo2UsyCTpm4z+G/Zzt27UxNbSHS0R32KzD
         5wHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oSOSLbrQPofFEXrOG0ovTZxI9kVfA06ZFszJsVXQcLw=;
        b=prE2LdixSZRoq0vL/D18EGuRtIPVJI2pr7WpyCbHRRKw5oF/uru3ldQYDQclOJaSLg
         V8GVVUSinBIKueT1MVppQm5OTOJqQKnLfSjV/N5K/MzISU8cJl9OhxdOx/s7vkN7kWtr
         PfwXSr3iJeMvINDfyxri2ZAq1rGW6hgYT7hHy5jXYIJGeUq9FoTOLi0sq0utibcEGUEz
         3fZvabe0Zc4T2aS4VnCJKHyyW7vPG9gyua/92kS+IhDfW6Nuiehng+hLhwp3DN9oF0EY
         YjRlHrv6ErahqYfibkPDWCGuO/tEPqavFmLiKaL0b/423Q+XVwu6oCb9H/iDn4WfCuwf
         VTgA==
X-Gm-Message-State: APf1xPBn5lkokxAaL1Pk6MrUAFpdZJ2MMv0FYnWtJEumqHKip+U30fvz
        51IpEcuYzjplnOjLJQaze5940vy1
X-Google-Smtp-Source: AH8x2254gVLoxDhVnt9si5CONdtqoIwVOrlBd2YYZ96oOJeA+e+hkzV+zPxlDzFQYt/tlPl/qabNNA==
X-Received: by 10.223.135.17 with SMTP id a17mr16978098wra.126.1519856250482;
        Wed, 28 Feb 2018 14:17:30 -0800 (PST)
Received: from [192.168.0.104] (AToulouse-658-1-45-219.w86-221.abo.wanadoo.fr. [86.221.52.219])
        by smtp.gmail.com with ESMTPSA id u22sm2675550wrf.86.2018.02.28.14.17.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Feb 2018 14:17:29 -0800 (PST)
Subject: Re: [GSoC][PATCH] userdiff: add built-in pattern for golang
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
References: <20180228172906.30582-1-alban.gruin@gmail.com>
 <CAPig+cTOv+jAQHA8p76MHcbbvv4SAs4y_1BxeRpexWwTT4+8hA@mail.gmail.com>
 <763c5ee4-0bee-7f76-1e2a-4ad07a813e29@gmail.com>
 <CAPig+cQ6awH8KfX3C+=OwE3qJLJPQyAt_dmQvMw1NLNnCT73RQ@mail.gmail.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Message-ID: <b9aa0939-8b20-0f35-84f4-5b519080ca34@gmail.com>
Date:   Wed, 28 Feb 2018 23:17:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cQ6awH8KfX3C+=OwE3qJLJPQyAt_dmQvMw1NLNnCT73RQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 28/02/2018 à 23:00, Eric Sunshine a écrit :
> On Wed, Feb 28, 2018 at 4:31 PM, Alban Gruin <alban.gruin@gmail.com> wrote:
>>>> diff --git a/userdiff.c b/userdiff.c
>>>> @@ -38,6 +38,15 @@ IPATTERN("fortran",
>>>> +PATTERNS("golang",
>>>> +        /* Functions */
>>>> +        "^[ \t]*(func[ \t]*.*(\\{[ \t]*)?)\n"
>>>
>>> Why is the brace (and possible following whitespace) optional?
>>> Considering that the language demands that the brace be on the same
>>> line, I'd think the brace should be mandatory.
>>
>> I did this to support non-standard formatting. It's a niche case though,
>> maybe we could only support the standard formatting and modify the doc
>> to reflect this change.
> 
> As noted, unlike 'struct' and 'interface', the brace for a 'func'
> _must_ appear on the same line; that's a requirement of the language.
> Placing it on a line is not an option.
> 
>     % cat >foo.go<<\EOF
>     package foo
>     func foo() {
>     }
>     EOF
>     % go build foo.go
> 
> Versus:
> 
>     % cat >bar.go<<\EOF
>     package bar
>     func bar()
>     {
>     }
>     EOF
>     % go build bar.go
>     ./bar.go:2:6: missing function body
>     ./bar.go:3:1: syntax error: unexpected semicolon or newline before {
> 
> So, the regex probably ought to be strict about expecting the brace on
> the same line as 'func'.
> 

Yes, but I can split the line like that:

    % cat >baz.go<<\EOF
    package baz
    func baz(arg1 int64,
    	arg2 int64) {
    }
    EOF
    % go build baz.go

This complies to the standard formatting (at least, gofmt doesn't change
it), but making the regex strict about the brace would cause it to
ignore those funcs, although I don't know how common they are.
