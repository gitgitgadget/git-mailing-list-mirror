Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C23A1F404
	for <e@80x24.org>; Tue, 30 Jan 2018 00:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751778AbeA3AQW (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 19:16:22 -0500
Received: from mail-lf0-f54.google.com ([209.85.215.54]:46735 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751417AbeA3AQS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 19:16:18 -0500
Received: by mail-lf0-f54.google.com with SMTP id q194so12651631lfe.13
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 16:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=zIOrD757p+2urq7PAw10wJPx1iIfEf/yKeuhu5EilBw=;
        b=aN64e4IihmjEGk/wk0SNsvOklZ5G/r6Zojlyw64meMahQKYZOjmG0AJ+3Xg2220Ono
         gMSEu2CsVwR4pSLqt01O6B7Kcbv+/Ua3sIfwtGwAS9fdAx8jEL9J69VwsNhRZ+r8B/AS
         wa5KxgRhmkwbhDqicnvVLOR30LQKN22FhyU67Ns2K7awWaQHzPRaqX/8pq1aQ1E+Cenh
         wdhnGaSEpAMY6PqO9Qv09z57B584wq5CogL52HVliZknbT3DutG2yWcxGe1J1m2Nqktp
         sFQhLJfgQr4R7Sj22OQg686evEmLA3vBSyPUDTi7FS3Y1pl6tQUrhV1WgZ/l5tPnKfhy
         nilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zIOrD757p+2urq7PAw10wJPx1iIfEf/yKeuhu5EilBw=;
        b=fuFtedeyPfnoD4ExBv2kPrC/kp02HV3shL1CkiLzIEm0pth9WIZfwAEh62TdwBbfxo
         eQMRfGXTNbhY5du1W3Ljh0NZOQZT8cHSV/sdj/dizlb2NIP1cHnk1+5b8LtohIY2GMBb
         ANozhO6m1M7XcFMIOXGm1mV4vSX31DTmLqlreBdHgTY72l96TO/GZKs8y5LvSjUJEIoc
         i0l/YMKYxLJ/eoIBd6LU2dkloBDF+NtqfqAHvhY6nGiQe7aybMOr26Z54DAngFIlHb7m
         LZU/m9xFEdeKJk4Kvkig7/nub0S0RiIWoksa5VxlkAs9+zLedWcA2UBUnSUD7lVpQ/2H
         +zvQ==
X-Gm-Message-State: AKwxyteEOP/bnOjB3xFW76y8F+J1k9bki2VsCxQ2o+mXFcORLuONw7kF
        XJb2138LDDQttzp1eeFkMFneFyq3
X-Google-Smtp-Source: AH8x227BVXIocRfSnKXPiim0/JMIMH084sLzVVFM8R6x6S57ghuErv3ES0T8TW0A7kSKr2QAoATu6w==
X-Received: by 10.46.36.26 with SMTP id k26mr14672821ljk.14.1517271376960;
        Mon, 29 Jan 2018 16:16:16 -0800 (PST)
Received: from [192.168.1.138] ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id d77sm1412246ljd.31.2018.01.29.16.16.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jan 2018 16:16:16 -0800 (PST)
Subject: Re: How juggle branches?
To:     Andrzej <borucki_andrzej@wp.pl>, git@vger.kernel.org
References: <29b0272d-7854-592d-5e1c-3a4f0d347bd1@wp.pl>
From:   Patryk Obara <patryk.obara@gmail.com>
Message-ID: <1fd71dd9-f54a-16dc-5521-f6f4e7d6fc33@gmail.com>
Date:   Tue, 30 Jan 2018 01:16:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:58.0) Gecko/20100101
 Thunderbird/58.0
MIME-Version: 1.0
In-Reply-To: <29b0272d-7854-592d-5e1c-3a4f0d347bd1@wp.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29/01/2018 22:24, Andrzej wrote:

> I am in master branch and am changing to hbase:
> git checkout -b hbase
> git push origin hbase

These two commands create new branch called "hbase" in your local repo,
and then in remote repo - so probably not what you wanted to do.

> now worse:
> I am in branch before_hbase and need change to master
> git checkout -b master  - not works because master exists

"git checkout -b name" creates new branch called "name", starting in 
your latest commit and switches you to this new branch.

"git checkout name" switches your working tree to branch "name".

So just drop "-b". You can read more in manual for git-checkout:
https://git-scm.com/docs/git-checkout

(in polish) Jeśli masz jakieś konkretne pytania, to możesz napisać do
mnie po polsku :).

-- 
| ← Ceci n'est pas une pipe
Patryk Obara
