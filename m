Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 484EE1F731
	for <e@80x24.org>; Fri,  9 Aug 2019 01:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405357AbfHIBeU (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 21:34:20 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35139 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732796AbfHIBeT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 21:34:19 -0400
Received: by mail-ot1-f66.google.com with SMTP id j19so49911000otq.2
        for <git@vger.kernel.org>; Thu, 08 Aug 2019 18:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dereferenced-org.20150623.gappssmtp.com; s=20150623;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=5xRFbpVVFoD+LSwE4NKS/iRXth4/Jf2TzxeaKJjHIrA=;
        b=XLFVTE7/hjg6v8ty3d6aoXIae5eY+k7BAn2D0X9SUqpLOpb2ICiPeI/gnB/zUwCqWC
         qdKd4QfhdolPvb5bx+F1OeoDQFU8jKYSJbTIMnxVqy+opDJxW46TVs1XRCiW+SLeux85
         zrpl5yHvZ0krpUsM9srPJ9bzHPseiTNWpHcgl1xOOl12OpCI8kg5KymeWl6u6BU5XZNg
         0wGL8Mb2PG0ygecZTOWeBVgak04S5XrA1cJUfWbzoWIuV07M2CJn5Apm8UgHY6s/6HAr
         A7/Dmefqu+XczeAxcact6bnvY0hRFRchljPU0Dn1SuLv/EL45OrUoWEM5ysjI4KRqovt
         XVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=5xRFbpVVFoD+LSwE4NKS/iRXth4/Jf2TzxeaKJjHIrA=;
        b=JTA2BsK87jDVj0gXWWqoO+QH6d8NZXyhUV/j/sL6XitqaL126r7XIAEuB0UqBf0f1Q
         a0MXzm4xbQ9Z2EU0d8MiV3jPTBu+rIynOpemXeIgmmHqWlzKDmv7Lgxt0WfCDSzaQXmd
         WKVT7OWbz75Ly90gHb0g2Y+yYUcQ0JHRLvTZMED0qmA9yTKH+vfMNcqKe4pFof6hCxi8
         mA8jmX6YQ7RkHgaewhZqh8+zPl2CO3kGQujwry7XSkGwwGk9+OEq4OewAmcW/kZ0O1OG
         cb+XxwRXyQqC58TMuDUSWyicG9l71iTZ2/3qLu/6onbTA/avaKOHymFYSTujKkiSxUr1
         vPcA==
X-Gm-Message-State: APjAAAUlx1K8ns55wTfqH2pJ+4YpF0oPjQ1IJ6jF1fAaGQbjajK6YIB5
        Bg9hjOuztEAuHa29+F2O/GkX3w==
X-Google-Smtp-Source: APXvYqyXonkBz6rGTScFW6Jq3Q4Qa1t9Ovf2fC9Z+LVyYDfZcZaylTRo2D4RQb1fo+dxSmWfW5FjMQ==
X-Received: by 2002:a02:3b62:: with SMTP id i34mr20244003jaf.91.1565314458224;
        Thu, 08 Aug 2019 18:34:18 -0700 (PDT)
Received: from ?IPv6:2607:fb90:a087:4575:94de:9140:2992:bdc? ([2607:fb90:a087:4575:94de:9140:2992:bdc])
        by smtp.gmail.com with ESMTPSA id p13sm6899456ioo.72.2019.08.08.18.34.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 18:34:17 -0700 (PDT)
Date:   Thu, 08 Aug 2019 21:34:15 -0400
User-Agent: K-9 Mail for Android
In-Reply-To: <20190809001315.GA87896@syl.lan>
References: <xmqq36itprzo.fsf@gitster-ct.c.googlers.com> <20190809001315.GA87896@syl.lan>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: What's cooking in git.git (Jul 2019, #06; Thu, 25)
To:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
CC:     git@vger.kernel.org, Phil Hord <phil.hord@gmail.com>
From:   Ariadne Conill <ariadne@dereferenced.org>
Message-ID: <3C7105E5-5DE1-42DC-A9A4-65C061FD6139@dereferenced.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On August 8, 2019 8:13:15 PM EDT, Taylor Blau <me@ttaylorr=2Ecom> wrote:
>Hi Junio,
>
>On Thu, Jul 25, 2019 at 05:19:23PM -0700, Junio C Hamano wrote:
>> Here are the topics that have been cooking=2E  Commits prefixed with
>> '-' are only in 'pu' (proposed updates) while commits prefixed with
>> '+' are in 'next'=2E  The ones marked with '=2E' do not appear in any o=
f
>> the integration branches, but I am still holding onto them=2E
>>
>> The seventh batch is in; I've merged fix-up topics that has been in
>> 'master' for some time (i=2Ee=2E up to the third batch of this cycle)
>> down to 'maint'=2E
>>
>> You can find the changes described here in the integration branches
>> of the repositories listed at
>>
>>     http://git-blame=2Eblogspot=2Ecom/p/git-public-repositories=2Ehtml
>>
>> --------------------------------------------------
>> [Graduated to "master"]
>>
>> *snip*
>>
>> * ac/log-use-mailmap-by-default-transition (2019-07-15) 3 commits
>>   (merged to 'next' on 2019-07-19 at e5669de950)
>>  + tests: defang pager tests by explicitly disabling the log=2Emailmap
>warning
>>  + documentation: mention --no-use-mailmap and log=2Emailmap false
>setting
>>  + log: add warning for unspecified log=2Emailmap setting
>>
>>  The "git log" command learns to issue a warning when log=2Emailmap
>>  configuration is not set and --[no-]mailmap option is not used, to
>>  prepare users for future versions of Git that uses the mailmap by
>>  default=2E
>
>Sorry for jumping into this discussion quite late=2E I was discussing
>this
>change with a colleague of mine who pointed out an issue with the
>eventual new defaults=2E I'd like to re-raise the issues they shared with
>me on the list for discussion, and if agreement is reached, I will send
>a series that reverts these changes=2E
>
>If a transgender person uses '=2Emailmap' to rewrite their deadname to
>their legal name (as was the original motivation in [1]), there are two
>potential issues:

What does myself being transgender have to do with anything?  Please expla=
in=2E

My motivation was to allow anyone to document their name change=2E  People=
 other than transgender individuals do change their names=2E

Perhaps the fact that I am transgender means I am more attuned to the risk=
s involved in using =2Emailmap in this way=2E

>  - The '=2Emailmap' provides a list of transgender individuals, along
>    with their deadname, which can be used to harass them=2E

This is potentially a problem but it's not as bad as you depict=2E  A mail=
map rule can match against e-mail only, which is precisely what I have done=
 in my projects=2E

And to be clear, anybody who is out there doxing transgender people are go=
ing to be using sources that are more reliable than a mailmap file=2E

>  - If they are not in control of the '=2Emailmap', and 'log=2Emailmap' i=
s
>    not specifiable (and instead defaults to 'true'), then a malicious
>    maintainer or contributor can submit a change that rewrites their
>    real name to their deadname, and harasses them further=2E

The log=2Emailmap setting remains specifiable in these changes=2E  Sure, a=
 maintainer can abuse mailmap, but they could already do so=2E  This commit=
 changes absolutely nothing in that regard=2E

The commit does make `git shortlog` and `git log` consistent which is what=
 most people expect=2E

>This issue was not raised in the original discussion, but it's clear
>that this has the potential be used for bad, not good=2E

Every tool has the potential to be abused=2E  I would not have submitted t=
his merge request if I thought that the benefits outweighed the trolling po=
ssibilities=2E

>Given that the release is so close, I propose we revert this change
>before v2=2E23=2E0 is tagged=2E After that, we ought to discuss ways for
>folks
>to change how their name is displayed in porcelain commands, and
>thoroughly consider whether or not a new plan is exploitable=2E
>
>If you think this is a good course of action, I will send a series to
>revert the changes that were queued here=2E

I do not think this is a good course of action and I think your justificat=
ion is extremely flimsy=2E

While I would like to see the ability to commit a special commit that docu=
ments a name change, this does not change the fact that such commits will b=
e mined in the same way=2E

While I am glad that you are concerned about this from a trolling and hara=
ssment issue, I propose that you should allow individuals to make their own=
 assessments on what they should do regarding documenting their changes usi=
ng the mailmap file=2E

>Thanks,
>Taylor
>
>[1]:
>https://public-inbox=2Eorg/git/CABURp0poUjSBTTFUXP8dAmJ=3D37qvpe64=3Do+t_=
+mHOiK9Cv+=3Dkg@mail=2Egmail=2Ecom/

Ariadne
