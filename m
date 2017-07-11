Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A9A520357
	for <e@80x24.org>; Tue, 11 Jul 2017 06:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755324AbdGKGct (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 02:32:49 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35322 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754900AbdGKGcs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 02:32:48 -0400
Received: by mail-pg0-f67.google.com with SMTP id d193so15514990pgc.2
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 23:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OrMG9eqcmv+71BpdANkPXrIw885IKWD2eCgVpEDDAOY=;
        b=TFYfPeEtrEWM3QEsljpOLc7ig57DmDuIiNBFJyOtfs5WmkarDVTYmD31frMM0QLxtK
         EQYkeYTjxrIStpeS/IFXvpsy7lSAnp4cgvuGUJMOVZc1hd/NliLsTTuKgln8wKbM0Njt
         JgS4sq+dy0er5wRuXD3m5ZANEYmhz7rYUq7yH3rXe2CcVMn3c18GiZWNwVkZdsTQ4Rty
         E7vsV2WP0vWlEl24I7uTMZ3ZkpseYLcfQzgK+DJjTLQB2cLVsqp1y7KXHvxJElc2a0kd
         YYuq1mABKJdzzhEYG0JdeiEWspWrXpdqfj4SGxuEZpigmUeDdHhfsSwuj0IQMVJ+JBqe
         8ODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OrMG9eqcmv+71BpdANkPXrIw885IKWD2eCgVpEDDAOY=;
        b=lBfflL0JTI/1Wod/RLIMC89xejQc68K/rDpF2x4aFkcAC0osMYcq1uzl9gSJ0ZqdPm
         zxtoBEQrbZpLRC7vSuc4ecqU9KONeBP75+xyE8k1OZnliCK6oAILINJqeSEvUC940EZY
         /+q583a4FlsKLjTSj2wFO2NS0etyvQZL2ZajjffcrGOSBKXkHIwrjcGv8xjNeMY6vIeM
         NXHNWbNQdAX069M77JFCY7bN7cB4vZLTbCfSEDmRMeLKRKzet91cq345exPCRU7+FSUS
         MfRxrR7soUdg3EL0J1bWz+7P2Y43qDCY6DvlTKHbk5Cdwc4Wa7JYGvP9iBT+BgV4C2Cl
         j/hA==
X-Gm-Message-State: AIVw112OA9jTwtfLBr0hZe1YWBwi/W+MqSnqVfUwSRDZ2cmwHHfKZVx7
        cIokSrBMonmgIPwPxVbyMwIwqv8ILw==
X-Received: by 10.98.214.195 with SMTP id a64mr48713617pfl.40.1499754767920;
 Mon, 10 Jul 2017 23:32:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.163.102 with HTTP; Mon, 10 Jul 2017 23:32:47 -0700 (PDT)
In-Reply-To: <20170710225022.GB161700@google.com>
References: <cover.1499723297.git.martin.agren@gmail.com> <1b08c5f568028645325367d6d6b97b9da17894ff.1499723297.git.martin.agren@gmail.com>
 <20170710225022.GB161700@google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 11 Jul 2017 08:32:47 +0200
Message-ID: <CAN0heSq3mxRXdv0WmqqmY1tqPAJH06Eu9xyPWBxY=O1kii1ufw@mail.gmail.com>
Subject: Re: [PATCH 1/7] api-builtin.txt: document SUPPORT_SUPER_PREFIX
To:     Brandon Williams <bmwill@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11 July 2017 at 00:50, Brandon Williams <bmwill@google.com> wrote:
> On 07/10, Martin =C3=85gren wrote:
>> Commit 74866d75 ("git: make super-prefix option", 2016-10-07) introduced
>> SUPPORT_SUPER_PREFIX as a builtin flag without documenting it in
>> api-builtin.txt. The next patch will add another flag, so document
>> SUPPORT_SUPER_PREFIX, thereby bringing the documentation up to date with
>> the available flags.
>>
>> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
>> ---
>>  Documentation/technical/api-builtin.txt | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/technical/api-builtin.txt b/Documentation/tec=
hnical/api-builtin.txt
>> index 22a39b929..60f442822 100644
>> --- a/Documentation/technical/api-builtin.txt
>> +++ b/Documentation/technical/api-builtin.txt
>> @@ -42,6 +42,10 @@ where options is the bitwise-or of:
>>       on bare repositories.
>>       This only makes sense when `RUN_SETUP` is also set.
>>
>> +`SUPPORT_SUPER_PREFIX`::
>> +
>> +     The builtin supports --super-prefix.
>> +
>>  . Add `builtin/foo.o` to `BUILTIN_OBJS` in `Makefile`.
>>
>>  Additionally, if `foo` is a new command, there are 3 more things to do:
>
> I added SUPER_PREFIX as an implementation detail when trying to recurse
> submodules using multiple processes.  Now that we have a 'struct
> repository' my plan is to remove SUPER_PREFIX in its entirety.  Since
> this won't happen overnight it may still take a bit till its removed so
> maybe it makes sense to better document it until that happens?

I could add something about how this is "temporary" although I have no
idea about the timeframe. ;-)

> Either way I think that this sort of Documention better lives in the
> code as it is easier to keep up to date.

Agreed and I believe that's the long-term goal. I could replace this
preparatory patch with another one where I move api-builtin.txt into
builtin.h or git.c (and document SUPPORT_SUPER_PREFIX if that's
wanted). That's probably better, since right now, patch 2/7 adds
basically the same documentation for the new flag in two places.

Martin
