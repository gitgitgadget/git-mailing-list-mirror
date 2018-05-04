Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10C10200B9
	for <e@80x24.org>; Fri,  4 May 2018 21:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751736AbeEDVsy (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 17:48:54 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:43392 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751612AbeEDVsx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 17:48:53 -0400
Received: by mail-wr0-f175.google.com with SMTP id v15-v6so22405913wrm.10
        for <git@vger.kernel.org>; Fri, 04 May 2018 14:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yV8YDRZVvNtixam1ceq3ojO02cTrPX6h+mOb9vsO/Z0=;
        b=CDf8mV+W5gQposvW+WVAxdgasuuqwQP0QC4HVJnXJK8WGA/tE8xz4zFLK/Pv4QG5s6
         +WDf/LM5xIszK7w7Vie+5Qc62iSTjsGJ8ntPeGJC52uHSXz06k8DfF2s2pU3kRfT5Mk6
         qHBajUsX7Ot32MtUIhK7BgQI2SwzP8EoKhVIAzkggQbB4TqQ/m18SfQKwOJ6Vg1UF3Ly
         4B7ZdS6GqYWt+Y7JG4gtIcEMR2SyQapeoHJerTxf5O+tKXlvyljqr4c6RsVR9JpmVNM7
         xVu7ubPcFJ94pjWk9S+LyS2wnon6Rj6EaVyh3rXFru7D6Qy1F8yMx/Vq6P8ugINfr2bC
         zRyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yV8YDRZVvNtixam1ceq3ojO02cTrPX6h+mOb9vsO/Z0=;
        b=V93tTbn39k1kanmSXFM96Z92CAoYyM2iJ2VLpLB3s/g/azGQw0ExZizH9FxMa62ip1
         cQlZaqGkaJWdjvscIRAIuZ8LNCAcdv4AdWQt58nSgXVwHDS6Q4QHFc2QCGPHnwwPWkya
         Mm5SER7inJCQ4M8VtkLSE/N88K48ARrF1HGeJ/3DR2akSeSW9+eA0525NzatkkgSswYe
         YGVfC28blUXZ8Z4uv9ygh4WIkHNlK+gCQHp18qien2W3oE2BjUOnRrT2wiIj2nifBaUQ
         sZizPhguTzTnWceOv4l3q3ZPH1tq5YoN8ph7jrnalx6L9jvbZCREDgpB8wSPN24JfMZC
         KXOQ==
X-Gm-Message-State: ALQs6tDplEqJd7hIdgOozip2FlEfO5tgj0rua/hXEhwP7DCYPDk3vP7Y
        oVlqpFaYYeoxXIGu0Ba3dsrxZd0R
X-Google-Smtp-Source: AB8JxZr3vydUq7RtVJW/BH18Bg++bentYCRLnVEtN243UKecP5dqz8KhyU/xofr8WLdSZ3EkVVf/gg==
X-Received: by 2002:adf:b3d7:: with SMTP id x23-v6mr15428406wrd.142.1525470531954;
        Fri, 04 May 2018 14:48:51 -0700 (PDT)
Received: from [192.168.0.103] ([92.55.154.57])
        by smtp.gmail.com with ESMTPSA id 141sm3571927wmf.35.2018.05.04.14.48.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 May 2018 14:48:51 -0700 (PDT)
Subject: Re: [GSoC] A blog about 'git stash' project
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <67e6d306-0885-9340-13c8-3e3d4333dc20@gmail.com>
 <nycvar.QRO.7.76.6.1805040009520.77@tvgsbejvaqbjf.bet>
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Message-ID: <7557a20a-a55e-e085-1aaa-3935000f643f@gmail.com>
Date:   Sat, 5 May 2018 00:48:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1805040009520.77@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Dscho,

On 04.05.2018 01:10, Johannes Schindelin wrote:
> Hi Paul,
> 
> On Fri, 4 May 2018, Paul-Sebastian Ungureanu wrote:
> 
>> The community bonding period started. It is well known that for a
>> greater rate of success, it is recommended to send weekly reports
>> regarding project status.  But, what would be a good form for such a
>> report? I, for one, think that starting a blog is one of the best
>> options because all the content will be stored in one place. Without
>> further ado, I would like you to present my blog [1].
>>
>> Any feedback is greatly appreciated! Thank you!
>>
>> [1]
>> https://ungps.github.io/
> 
> Looks great!
> 
> Maybe also mention that you hang out on IRC occasionally, in case anybody
> wants to tell you just how awesome a contributor you are?
> 
> Ciao,
> Dscho
> 

Thanks for the kind words and for mentoring me. It really means a lot to 
me seeing that my work is appreciated by professionals like you. It is a 
great confidence boost. I will definitely add a paragraph about IRC.

Best,
Paul Ungureanu
