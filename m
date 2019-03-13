Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01812202BB
	for <e@80x24.org>; Wed, 13 Mar 2019 14:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfCMOre (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 10:47:34 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50860 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfCMOrd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 10:47:33 -0400
Received: by mail-wm1-f68.google.com with SMTP id x7so2366020wmj.0
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 07:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/OU0xksNAP70eRa+2deVIq8PvkuIGhi1qusjNVC6jeY=;
        b=m0dbvMJCwNW7BvJEbaiQjhv3BEsVMH6TA+1SS/KnGdf1J/jKdV5WRZ1PzhWoaK69pq
         vyAHDwZGJ9ET+1LAx602yZc6oJifZvSYlm+DrVJeFBfDKJguQKcwJaLNJqXO7k2f+LBj
         STPCiJ3GPh0h80Lm7/05TDDjQm+lrzpzRDl00q5I5gO4VV3WuTIMpFsFJ3CdDNe23Igj
         ZA0Ldhi8LMGvULAYqVdMwiLp/HjCk7Zt16uzwv68MaBSMSdJVLHFeXB7zVoS6t31wwBY
         teFwrCTor98xaN7Wp+t7V3LmIC3D50mXaCYe3oWKfN1Il4natJ/dKOOgjzTKgvlpdsVw
         ip3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/OU0xksNAP70eRa+2deVIq8PvkuIGhi1qusjNVC6jeY=;
        b=b5ZhTexMB2IIprI/mIi8CE19RL932DLkmfKXa4B3IUUm86dsvs6HcZeGKYsKcTTq4L
         hHqyUSEsRbLSd9DC7Bp7GtybkkoIbxCvb57sgombhI5ev5u1WFQX9KR2NMfx1Znql9Hc
         3hlO8VW/qp25PmNOAdBML/cFhViMUE4V21NxyLwX2f3Jaca9HEghjaOIEHiPIoTg5bm3
         svVebs5eqWVoSAK7M2Ni1I2G9uCEiECB1FUDWju5+SjyYOOBYOGwFV9qOT55/fOtCXa3
         Hc4ql1BtMy0e0sXjp2sW2FxAD/udL6T1OXxCn23OfvtTfueFguFpxd5X/NJkaapAtdkH
         YVUA==
X-Gm-Message-State: APjAAAXpNZgQzKxSZoWKyi7JjgPNf+AeBxqsf437E5nCtjN+S2oQR7WJ
        1bJ1kEN7IKfuYxlVgb1ekuQ=
X-Google-Smtp-Source: APXvYqzISB94pHdSeEKg396Is+gobk31+bmBkcd+qfBb79WDb0ywvA7zFmQ1t0JHFiUuvUJzVZmCMQ==
X-Received: by 2002:a1c:3c02:: with SMTP id j2mr2662574wma.72.1552488451869;
        Wed, 13 Mar 2019 07:47:31 -0700 (PDT)
Received: from [192.168.2.240] (host-89-242-186-210.as13285.net. [89.242.186.210])
        by smtp.gmail.com with ESMTPSA id i10sm24913949wrx.54.2019.03.13.07.47.30
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 07:47:30 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] t4150: remove unused variable
To:     Andrei Rybak <rybak.a.v@gmail.com>, git@vger.kernel.org
Cc:     phillip.wood@dunelm.org.uk, s-beyer@gmx.net,
        Paul Tan <pyokagan@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <36ad743f-8429-a6ff-7fad-15e5dba01483@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <936bfc66-c121-a036-4ccf-c9877560bc33@gmail.com>
Date:   Wed, 13 Mar 2019 14:47:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <36ad743f-8429-a6ff-7fad-15e5dba01483@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/03/2019 14:38, Andrei Rybak wrote:
> In commit 735285b403 ("am: fix signoff when other trailers are present",
> 2017-08-08) tests using variable $signoff were rewritten and it is no
> longer used, so just remove it from the test setup.

Well spotted, thanks

Phillip

> Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
> ---
>   t/t4150-am.sh | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/t/t4150-am.sh b/t/t4150-am.sh
> index 55b577d919..3f7f750cc8 100755
> --- a/t/t4150-am.sh
> +++ b/t/t4150-am.sh
> @@ -77,14 +77,12 @@ test_expect_success 'setup: messages' '
>   
>   	printf "Subject: " >subject-prefix &&
>   
> -	cat - subject-prefix msg-without-scissors-line >msg-with-scissors-line <<-\EOF &&
> +	cat - subject-prefix msg-without-scissors-line >msg-with-scissors-line <<-\EOF
>   	This line should not be included in the commit message with --scissors enabled.
>   
>   	 - - >8 - - remove everything above this line - - >8 - -
>   
>   	EOF
> -
> -	signoff="Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
>   '
>   
>   test_expect_success setup '
> 
