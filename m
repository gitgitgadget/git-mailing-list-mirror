Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 210CD205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 13:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755870AbdABNuV (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 08:50:21 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35496 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755831AbdABNuU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 08:50:20 -0500
Received: by mail-lf0-f66.google.com with SMTP id x140so25821356lfa.2
        for <git@vger.kernel.org>; Mon, 02 Jan 2017 05:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fGeY3bOSwiqV9iLBPL4gxnRrQ0UGYqbf1jsHYceAIug=;
        b=ZMg72hdtXzZM1/wA6ReopuFfChxbQDwe0uk4m8JBHrbjNJ6AQDUej5eNucDla+TYfn
         6AS6HqXPeDxGcSJXgGZtTy6rTRbEZnrw8rh0dyfsSSsQznJ/v5hU+e2Cy0BscpuwTE0P
         QrQQ4Ton8BlE6S41kVuO+qRMFDxrs2y+FxXhgPOzAkKfmV92jE1XsIqdipvarlNvR/8Y
         1jDBgWmHjPGROHmaGP4K77MgBh6G1eifX/1zw9379oMvf/HynfyVFXQ0XtLS6CB/I9+c
         7wuK1gQBRQw8SQnPytMKypWPZGB7qgUlosy13bBgsOfm0GcWoJEzWGq8TknCfMEyJX3l
         Mu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fGeY3bOSwiqV9iLBPL4gxnRrQ0UGYqbf1jsHYceAIug=;
        b=qgiWcuydlE1OtgYUhDgF7+7I/bSEB07U2U9Gav0wetE1yv3294UiSPwxKyMHwi5Lzh
         1CtHUGGgKGV8lcBDQLQrUOcHE4J9aW+u7GdIXrx+fMz7Eu1E/pkyMaudVvaqosZ3qKIE
         zkoMyYbep1ZdEhxXJ5J++Y9CwVKoIpgDO1Je5z5DybIHfOXFE43tILE+zeL9aVTe7dud
         0BkVC8X0cMzHxnWyMwCVDBjP4DxsMMUSdGzKPhA8EUfULPssD5Ipbkkjr9mEVnMHwojc
         4a4syeoj6cqCVNAl3qKB/FhGd/b7kBXSTmRQj9KArhPwjyHvCZkcVG2guklN0SGua3gL
         4sHQ==
X-Gm-Message-State: AIkVDXLHNr6/7XG9XOuHYswC4YIZS3ObozDcxDc8YBHzKN/eBEjrTmhMKXS+8qVwLmOhzQvWrj2AXTCa1Ok9Dw==
X-Received: by 10.25.209.73 with SMTP id i70mr16223411lfg.24.1483365018575;
 Mon, 02 Jan 2017 05:50:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.135.198 with HTTP; Mon, 2 Jan 2017 05:50:18 -0800 (PST)
In-Reply-To: <xmqqlgv1b34y.fsf@gitster.mtv.corp.google.com>
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
 <20161226102222.17150-13-chriscool@tuxfamily.org> <xmqqlgv1b34y.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 2 Jan 2017 14:50:18 +0100
Message-ID: <CAP8UFD1wmbR_rHyqn0q=0hw6-hHYFTzr=3yxS2XS9qTdY1kWFA@mail.gmail.com>
Subject: Re: [PATCH v3 12/21] Documentation/config: add splitIndex.maxPercentChange
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 27, 2016 at 8:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>>  Documentation/config.txt | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index 221c5982c0..e0f5a77980 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -2773,6 +2773,19 @@ showbranch.default::
>>       The default set of branches for linkgit:git-show-branch[1].
>>       See linkgit:git-show-branch[1].
>>
>> +splitIndex.maxPercentChange::
>> +     When the split index feature is used, this specifies the
>> +     percent of entries the split index can contain compared to the
>> +     whole number of entries in both the split index and the shared
>
> s/whole/total/ to match the last sentence of this section, perhaps?
> "The number of all entries" would also be OK, but "the whole number
> of entries" sounds a bit strange.

Yeah "total" is better than "whole" here. I will use "total".
