Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C487C1F597
	for <e@80x24.org>; Tue, 24 Jul 2018 22:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388614AbeGXX5C (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 19:57:02 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40050 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388491AbeGXX5C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 19:57:02 -0400
Received: by mail-wm0-f65.google.com with SMTP id y9-v6so3251044wma.5
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 15:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fdmV3OmZ4M7bugaCYxi7BkxrYZbaTPWxMKZ4uQw5WOc=;
        b=hR4jgmO3k6V9QVLs2E9/66u5Rrnp4yfbE1FNGc89OAYifFFfVBYPla26TxOXanYfWf
         6qaBic234dXufKyYroC3OJra3Ejh3NqKeD9MFmmuS4yCP3lzEa7w1weoGHs03D7kxHEA
         Md+LrxWWbYtp7tG/1bcPa9h6osl4GksfTs+pdt9bxiHQLBjz/uQ7cZrq8Vrq3Nd70z5/
         DphmLhQMZttdiwBRX7JV4fvvAMocVQeIENtI2aDqaBaYaKfviTYIuttfXn1an62TTYDu
         0nsH0d0MJUPFB9l7JXqD8b6RXNVNsPWmDNv7+E0PissqLhiiDbENkndBws08zz57TAxy
         nLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fdmV3OmZ4M7bugaCYxi7BkxrYZbaTPWxMKZ4uQw5WOc=;
        b=VSLPjwmTRCvQZYaWB2Kmn8WrS1EXaZWDFwSTX37pJjub1hQVSOga00TB91h3BSoWwL
         VnPAh5dtHbYjzi1PyZQ/7DezHiugUCJ974ZQCwPJDFo9/LVlUrdIKTHu9A5j3G2MBCf3
         +R5UfiyFCFeynINygcVKk0iOAESp5dy4A7xO7hLieHRCmKixPxWWDhNzeE46bvex3UP4
         LfzAdDWRYkBy9PXsAA6/jpQFYP7olh9WEltRE/hqPOIJDEuRwZZz1AZ5Z+6Wk434demp
         N4+4YUZVs62RKnAhIR1JNqdnw46DERdZc+BhAQB0kJTawZx7AHamojTYYTRP0hqNgema
         1MEA==
X-Gm-Message-State: AOUpUlENI8zceNGqNYbUk/TccsxnHqDzhXbL0aUVEyDA4+bOiZJVY5zh
        cfOInW0G8nzh8ik0HT9PtDEUleRR
X-Google-Smtp-Source: AAOMgpdugGkaUBAep+QXMrBouUEVdtBg0+TFjlVrtkngomx8rXz04PyBplOya8RXE5jbl7a5LQc0Wg==
X-Received: by 2002:a1c:90cf:: with SMTP id s198-v6mr3118157wmd.5.1532472499774;
        Tue, 24 Jul 2018 15:48:19 -0700 (PDT)
Received: from [192.168.0.137] ([82.78.255.161])
        by smtp.gmail.com with ESMTPSA id n17-v6sm2664359wmc.13.2018.07.24.15.48.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 15:48:19 -0700 (PDT)
Subject: Re: [GSoC] GSoC with git, week 12
To:     Alban Gruin <alban.gruin@gmail.com>, Git List <git@vger.kernel.org>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Pratik Karki <predatoramigo@gmail.com>
References: <7c05cfb5-d29d-79ab-f400-b2614855d7ac@gmail.com>
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Message-ID: <3041609d-449f-2d42-aba3-461837d26e6a@gmail.com>
Date:   Wed, 25 Jul 2018 01:48:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <7c05cfb5-d29d-79ab-f400-b2614855d7ac@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On 24.07.2018 21:55, Alban Gruin wrote:
> Hi,
> 
> I published a new blog post here:
> 
>      https://blog.pa1ch.fr/posts/2018/07/24/en/gsoc2018-week12.html
> 
> Cheers,
> Alban
> 

Great!

Mine is also up:

https://ungps.github.io/2018/07/22/week-12/

Best,
Paul
