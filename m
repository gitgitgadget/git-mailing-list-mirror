Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5C261F404
	for <e@80x24.org>; Wed, 14 Feb 2018 14:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030490AbeBNOKw (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 09:10:52 -0500
Received: from mail-qk0-f177.google.com ([209.85.220.177]:43143 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030397AbeBNOKu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 09:10:50 -0500
Received: by mail-qk0-f177.google.com with SMTP id i184so15671380qkf.10
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 06:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=Bq22qrRGuQpzZT4Gz/3xCZCp4qVQJsWwvFmfcQ69b5w=;
        b=jSmc4gdCTEKlFWOAFHhVGqPY679a68S3v006sM441faiu69ikWr9UXqJfX0sdQRzHb
         SOcJyrpI7dRS0CbCNLyN3Z7Lo6Rn4qLblGptWQKjyWnm6NOaIH965oE4MCeB5RjofL6c
         UahdrTvzYapBBazxBiOJZvYUmppZEmdNZ+QbcvRkMDdsXqvjGMnss5P63rhxIqLt2Oqz
         aSrDrR4k0apWyvxSmePYewjP75NJCKzkgePgDh3XpCxdYsfO+6e/Vil4h8YqX5GxHry9
         vjz7nnNuNzW+YBelFKucIjVFc0hCxiGS/EYSMz55M8deD1oby5aPU3Zn02BWAIdSC88M
         mGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Bq22qrRGuQpzZT4Gz/3xCZCp4qVQJsWwvFmfcQ69b5w=;
        b=BZZDshPG46fGslFZEpWbLUkFVVNwGQPStu4hcrwbsCOLnFPRLPQyV8p08+q5PhvBFF
         FlMGRL5oRwGyh53+Ip4Ns2SvnaaOQ8NBNz8gPKq8LlnUurDuAAAtYqc4iwrVX253oFT1
         MrnnAi0ubrsuzEsMoDsE18A4bk6L/ZQ4ezOb8ZCrTh+646R5pxbrCWynyRXoi1LwK8IS
         aXs9NGrmRc7K8Dr92P8Tpg49OwpvD4VOmmz4hRLppJCWA7Mne7bEklkoSrnmnYyakunp
         ZPWu8RRAwQBztaKXbuTqQEP7f+ILfbE7fR70McE2tNjkpXFA11rrHEUTYWbCVRSxaVsx
         gUQg==
X-Gm-Message-State: APf1xPDu2Hbfg6TzZ7r9IMxqbKBQoXM+v6KQ0A7Mv/TWO12OTo/0oFno
        qabLJvisM2nWBFXblnymoDsgcmHd
X-Google-Smtp-Source: AH8x227BK2qYWsop2w/fDRmapK26n7QoXz3sXW/6JVnqK0kul7NnN+j70gMgO1xtEdNsBCJZoS7tzw==
X-Received: by 10.55.220.197 with SMTP id v188mr7850114qki.147.1518617448860;
        Wed, 14 Feb 2018 06:10:48 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id g11sm8790216qkb.73.2018.02.14.06.10.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Feb 2018 06:10:48 -0800 (PST)
Subject: Re: What's cooking in git.git (Feb 2018, #02; Tue, 13)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq8tbwpcdv.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8f014e98-8360-785c-fc5d-0664466057fb@gmail.com>
Date:   Wed, 14 Feb 2018 09:10:46 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqq8tbwpcdv.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/13/2018 8:51 PM, Junio C Hamano wrote:
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.
>
> You can find the changes described here in the integration branches
> of the repositories listed at
>
>      http://git-blame.blogspot.com/p/git-public-repositories.html
>
> --------------------------------------------------

Hi Junio,

There have been a few "What's cooking" emails since I submitted v1 of 
"Serialized Git Commit Graph" and it has not appeared with a tracking 
branch. Is this a mistake, or is it something about the state of the review?

Thanks,
-Stolee

[1] 
https://public-inbox.org/git/20180125140231.65604-1-dstolee@microsoft.com/
     Patch v1, Jan 25

[2] 
https://public-inbox.org/git/1517348383-112294-1-git-send-email-dstolee@microsoft.com/
     Patch v2, Jan 30

[3] 
https://public-inbox.org/git/1518122258-157281-1-git-send-email-dstolee@microsoft.com/
     Patch v3, Feb 8
