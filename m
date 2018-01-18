Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A5021FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 22:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754346AbeARWKQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 17:10:16 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:45228 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753875AbeARWKO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 17:10:14 -0500
Received: by mail-wm0-f53.google.com with SMTP id i186so132554wmi.4
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 14:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZdB4beEj951ugWGm75tXWsnWA2iC349o/gpfxUIE4zo=;
        b=GbaT8hxdNG9+lnSOnU9t+IFeAL5YxacjSjG5AM+NJ/IOJNGZzN0aNq3H8OKkugDBwU
         AG8awb6IyCoVFZkYqENUg6Ia+jD6pJT5VU2MFShD0st4JX4VIIQdTHIhFTYBJjKOBPlD
         DEVQGMA7kUmmjR/GltoF4aqqJ2Y6IJx7XMoVgf3Pq3NyCCyHFB3DOaR8JlGSCm1ymzaH
         ahX0nouOgwFcC6tM1OFEKSlQnweMIfgcKvVBMAGLZpuRtpC3Eg2hAPogGk9Pz0dCbvys
         p1q++wkH3hI4I1GSRi6Y8aIhYnjiXzX6rBIj20BZ/EZHw6+atLCV7u+5pL+Nx9AWhgGq
         cSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZdB4beEj951ugWGm75tXWsnWA2iC349o/gpfxUIE4zo=;
        b=HatYqgs+dYZD31tBkElSe9zRlcrCIcx115iI/vY8dsmV1rrVtO6VV69B0Wgf6XyWbH
         06UaiWIueBTRcDRqDx2aGR5GQAsXdbwjA7Wj4BIPENhjQWCy0U6Zk8aqlTPOjqsTaLYU
         rdy6qWcpzd8c6IGyCJ8Cr33PZF3eIerOZrRFGT4ivLizo1Q4MmTNJElHXWd1qnrEmXwI
         lE3VVanelnoFYNCzjo1JJ4r9fK9W/aNzEFy5fYp+eIhzCAj9l6sUt823kwPbgXtEAYYH
         yFr4wtilXbi9i8nCpfL1lfKo9QZzeTU9qrteBUetTgyCYqWaeZwKHx0ZP/b8ihC3Zp08
         Fi4Q==
X-Gm-Message-State: AKwxytfNAueeCi/sy5mTCi8Yua07H7aLjik5XTsUlL9v46rAdjyGrM2F
        /haR1NCTnl5xq1JOn2crBB7e4WrvIHFoZGSTCxQ=
X-Google-Smtp-Source: ACJfBotpX8j+4RYsASkL2eQZSeD93iH6XNnkj2e0U7Iy+aCjU+9FU2s0U5O0LFyOVc4d7y/mdV71iD31rhwHyXkQQFk=
X-Received: by 10.80.184.77 with SMTP id k13mr10166829ede.187.1516313413326;
 Thu, 18 Jan 2018 14:10:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.212.44 with HTTP; Thu, 18 Jan 2018 14:09:52 -0800 (PST)
In-Reply-To: <32EA49C74ECD470F8EE898D965833E02@PhilipOakley>
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
 <20180118183618.39853-1-sbeller@google.com> <20180118183618.39853-3-sbeller@google.com>
 <CA+P7+xpwYDeNHfzMtHJkKEB8-A+kZ95wBEn0RC5R8pWbgKOmiQ@mail.gmail.com> <32EA49C74ECD470F8EE898D965833E02@PhilipOakley>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 18 Jan 2018 14:09:52 -0800
Message-ID: <CA+P7+xpMGkBhBQEmB5akqi2hhCr=VzMbJopNPNbkAbF6sdzPUg@mail.gmail.com>
Subject: Re: [PATCH 10/8] [DO NOT APPLY, but improve?] rebase--interactive:
 introduce "stop" command
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 18, 2018 at 2:08 PM, Philip Oakley <philipoakley@iee.org> wrote:
> From: "Jacob Keller" <jacob.keller@gmail.com>
>>
>> On Thu, Jan 18, 2018 at 10:36 AM, Stefan Beller <sbeller@google.com>
>> wrote:
>>>
>>> Jake suggested using "x false" instead of "edit" for some corner cases.
>>>
>>> I do prefer using "x false" for all kinds of things such as stopping
>>> before a commit (edit only let's you stop after a commit), and the
>>> knowledge that "x false" does the least amount of actions behind my back.
>>>
>>> We should have that command as well, maybe?
>>>
>>
>>
>> I agree. I use "x false" very often, and I think stop is probably a
>> better solution since it avoids spawning an extra shell that will just
>> fail. Not sure if stop implies too much about "stop the whole thing"
>> as opposed to "stop here and let me do something manual", but I think
>> it's clear enough.
>>
> 'hold' or 'pause' maybe options (leads to
> http://www.thesaurus.com/browse/put+on+hold offering procastinate etc.)
> 'adjourn'.
>
>

I like break, as suggested by Dscho. That also works well for
abbreviation if we drop the "bud" command.

Thanks,
Jake
