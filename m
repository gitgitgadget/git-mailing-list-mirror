Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7F411FC96
	for <e@80x24.org>; Tue, 29 Nov 2016 19:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754206AbcK2T37 (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Nov 2016 14:29:59 -0500
Received: from mail-qt0-f181.google.com ([209.85.216.181]:34469 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752169AbcK2T36 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2016 14:29:58 -0500
Received: by mail-qt0-f181.google.com with SMTP id n6so166122090qtd.1
        for <git@vger.kernel.org>; Tue, 29 Nov 2016 11:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5WmiQSB2cBwAt6/05vXdBiiXcvowBcHoxkAqbAxu1DQ=;
        b=GuaotDm6N6tukiLl0VJiHim0q28k/AxwBCfZQghfwtGsySWhy38sfKMUUIek03Hvhj
         mTaa4bIwe8ZdmJ8FyhMxLyzOTsymo8iCPOKt5fHQlhd3abSZk+iYV34w9kXGHZpTeZw3
         vvyRPWA2zsbWKgKPsCOTsVJXeKRy4YPIMR/W5lJBzUAl4dwDZcxOnsOo5jAFdTkdVq57
         Eq3+mW3BqZoAJC3I3Jb29SlhvMx48zbJpKU66o6vuyAGF8cnbbPoxYn0WuFOthlWakBP
         4CMtwIF2qL9ZRjmCiew2PV+VSp3ouQoS4SL8u5aDxpxnus48qMRfxFk7pujDtevuKmRc
         zrhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5WmiQSB2cBwAt6/05vXdBiiXcvowBcHoxkAqbAxu1DQ=;
        b=Kp+cShS75f7yuc+yYDG3VNVfl5r1M/RfDLu1bSQaZYTe/A8vrJVibgouqGAuvE//m1
         qq8Wj21tWrVIe0a9q8Sqy1jVuU6jIgWWm/tedUPZ8bNa0V/Mk4anxtjWXxSmQfs5F2Zd
         P/wFZeTOhvkk3lVrRLEQDXaHXzJND+Lwoil6K28V3cia/pBEXRoGlFvvvFe9UTSfEXzF
         6z2kqDOCtuGIBUETE9tX61i4FMAEygBz9kMZ+x+ve886zu91drwVgLZJ7WLXU0JMTnnZ
         HrjODVXZPBdrIBzzq05+HYvWfUx9SY9lmIwF3wGcf6vpIi1nwsfdL+q8f37IYt0GIgmw
         Yr2w==
X-Gm-Message-State: AKaTC00yO4lSAtL1nubxH7L1A2zkYzAZSa8c/o9kLZNnLfNPFH94LUH/Wu0jjA08NDVp9Ka8OqqTdAa8DMu51JWZ
X-Received: by 10.200.53.9 with SMTP id y9mr24981736qtb.176.1480447797028;
 Tue, 29 Nov 2016 11:29:57 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Tue, 29 Nov 2016 11:29:56 -0800 (PST)
In-Reply-To: <xmqqk2bmf5pv.fsf@gitster.mtv.corp.google.com>
References: <xmqqk2bngn03.fsf@gitster.mtv.corp.google.com> <CAGZ79kZbBufaKoJyTQa_DseE5GofMAwb=ujtEYn35r9VEwdJ2g@mail.gmail.com>
 <xmqqk2bmf5pv.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 29 Nov 2016 11:29:56 -0800
Message-ID: <CAGZ79kbzLhJDqgv5WxRU-gLEwSSsspEythszAu8pZeEjoWUozg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Nov 2016, #06; Mon, 28)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 29, 2016 at 11:26 AM, Junio C Hamano <gitster@pobox.com> wrote:

>>>  Need to read it over again, deal with SQUASH, and may ask for a
>>>  reroll.
>>
>> Ok, I looked over it again and I may see some issues:
>
> OK then I'll procrastinate on this.

This is not what I had in mind when typing out the issues.
I'd rather wanted to hear "these issues are all non-issues,
your design is actually correct as a first solution". ;)
