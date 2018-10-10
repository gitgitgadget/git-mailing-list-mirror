Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F57A1F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 13:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbeJJUfp (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 16:35:45 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:45485 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbeJJUfp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 16:35:45 -0400
Received: by mail-wr1-f51.google.com with SMTP id q5-v6so5672804wrw.12
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 06:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=gPXchfQ9emxUD65KyAJCpnJla5N6v67mAa6VFCLT5Jk=;
        b=CZZ2xzIJ9bIVfW5YxzBtOkZ+mmUhA/cRXRS1meMlD1f585FlB8Bb8e1Ml7juENaNz3
         DjfIntJ4ismcinSbGk60JRMDKHllWyhWirQ+UTE++Rn4ZppVIglSQbGsfiKWZtdkel8y
         p2twzb+Iv1TwUpmTQCpz7l3AaJucciQeTriV2dTbf3x3f+wJwARmQhQVvu4Wh0OcbPYB
         7hXomhCo8nmldbccVmOVQ+OxxygnMscOO6k3suXmX6EU0VyePIZGjnIOCQ33t6Esq0a5
         omdv5vXH+kBaa/uriC3ldbc52iZZCB+zD5dpSlfu5rWDgtETbwCMoe+I4IDm/uI9VieJ
         aHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=gPXchfQ9emxUD65KyAJCpnJla5N6v67mAa6VFCLT5Jk=;
        b=Tll7QGsOWXr9DdEDu2aarbD/2hUujN7GdKFP9+9GoB7KN/ucoEOXDbtN92EHoXcul0
         lj/B8NN+laPiwcVTGtpcdju2JTheWoJRfbWmnJHXXWheOlAqzghcW4xIj9fWSYjh+Nk2
         KFpIOmUTtxwdH0kbkg0P9Lmf/UMa1f+/tI7j1j4Db+vQBSoovZYn+nTbnfM52I3pQdKn
         swSHtx9ic4XxDiM88B8ojA+eyzSASFBtVSE9DPVKzD0+94YX8MykLygiEsK2rkwUzSFL
         GMWh1A0yLd2CmsN5W1vHRrq6fXinLxOh4cMM8BO4WNhmATrRHWvlrGLUKHvJFrPoEp5i
         aB8w==
X-Gm-Message-State: ABuFfoh4mibSHw8L1u4kIqJumQJqmrcEnO8sw3s1r4YsJUGFzQIibBR0
        NY1yJW/ARvfLynIoze+rolXt8cT+D3E=
X-Google-Smtp-Source: ACcGV63qC6lQA22Grz/yDvaL9x+GGTSzo8hD7rF78W7o8I+HGsPGmUbwTMBt3f0n4hw3BHg073Bl4Q==
X-Received: by 2002:adf:9367:: with SMTP id 94-v6mr24771126wro.211.1539177215694;
        Wed, 10 Oct 2018 06:13:35 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o126-v6sm16223901wmo.3.2018.10.10.06.13.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 06:13:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: js/mingw-wants-vista-or-above, was Re: What's cooking in git.git (Oct 2018, #01; Wed, 10)
References: <xmqq8t36mk4t.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1810101502220.2034@tvgsbejvaqbjf.bet>
Date:   Wed, 10 Oct 2018 22:13:33 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1810101502220.2034@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Wed, 10 Oct 2018 15:04:28 +0200
        (DST)")
Message-ID: <xmqqr2gykkqq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Wed, 10 Oct 2018, Junio C Hamano wrote:
>
>> * js/mingw-wants-vista-or-above (2018-10-04) 3 commits
>>  - mingw: bump the minimum Windows version to Vista
>>  - mingw: set _WIN32_WINNT explicitly for Git for Windows
>>  - compat/poll: prepare for targeting Windows Vista
>> 
>>  The minimum version of Windows supported by Windows port fo Git is
>>  now set to Vista.
>> 
>>  Will merge to 'next'.
>
> Could I ask you to fast-track this to `master`? The code in `master`
> unfortunately no longer compiles in a current Git for Windows SDK, meaning
> that all of our Continuous Testing fails as long as these patches are not
> merged.

Absolutely.  There is no point keeping it in 'pu', as nobody would
touch it in my tree until it hits 'next' and probably 'master' and
the change would get wider exposure to folks to whom it matters in
your tree anyway.

Thanks for pinging.
