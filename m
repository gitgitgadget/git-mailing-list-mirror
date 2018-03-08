Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B524C1F404
	for <e@80x24.org>; Thu,  8 Mar 2018 16:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935892AbeCHQ0W (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 11:26:22 -0500
Received: from mail-ua0-f172.google.com ([209.85.217.172]:39826 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933560AbeCHQ0T (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 11:26:19 -0500
Received: by mail-ua0-f172.google.com with SMTP id e25so181535uam.6
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 08:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=/qS+eu+q/FHQBb3Nz6UXTMLKo+FA2yBb3qUAV1WRtjE=;
        b=qk/U4Gizd8uDwuf/cNWsHZybSL21Qg3DrjLHF/fSHwx+Es3g08Qkp8x2Q3L4xU4xYj
         MnZGy+33A47fUBa7ZoS930/gtoREE9PGPpMSKxJ24wj5mZPJVQzXI6uEQBcboqiag0kl
         C5CcxT+00jPRX7v208Ejp0EJkVz82ukMgpDYDpDjKZtRQbJDYqactNQIC506j967RJjl
         0/GKeEY12ZEWsov4zThr41J8+jbv2OgU7AxDFlsyDPqHlxYCGsBDvNHqpWNUraJmRTyR
         mujtjGxsB8QLESzsFOrX2pRm4fbYCMvP2Yo/RWkE4jQUlGjP/ttBri2Xp5Ydmn4hKA58
         6SMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/qS+eu+q/FHQBb3Nz6UXTMLKo+FA2yBb3qUAV1WRtjE=;
        b=hdmI5MJTuawnuvWyDn3lT5l8jAsHxZ5UETmxCmHLhJWy9FO8tZxMBJ1wszkbgUPi1J
         W/ivzXPSHqcbDUNdZeZA7o5FUD4g/VtpdvcEVL9W5va43ptyeGZ0bxqgPdavSNf7EmEh
         +GHdLst7VJj1GbyogBFcjnLJH9d7W5orfjcUyeHj21m4bmJZmT/Vr2OYi5zE3c3b5tTz
         exEvpMAfkH0DSENlNYQguHDt3Lyvt9Dv5GwFThX8eLy7qMi6orLEe3t//yGEJEsfbDwQ
         FULbwmeOzQ0GJZi6Vq1ta72HzSEWEI7wxTXNawjcAFwaOtF/3RNZtd7LgNYHKrXZzom7
         +5tg==
X-Gm-Message-State: APf1xPCWYSNyNQfro3b+TPayhdKWfh4tLJwKKv7bSfeKX7w7uv4Ek3Zn
        Mbc/9sxhrN4cp8+ThbANi5M=
X-Google-Smtp-Source: AG47ELuuPprYkoBjkuhLJiTMdeQKf/96TpwZvxlK6LAM3PqQlbbnv4omDcTOEC6M1x2yARNDYsoTzg==
X-Received: by 10.176.22.50 with SMTP id k47mr19848636uae.176.1520526378801;
        Thu, 08 Mar 2018 08:26:18 -0800 (PST)
Received: from [192.168.88.42] ([190.191.20.243])
        by smtp.gmail.com with ESMTPSA id y12sm11071783uad.8.2018.03.08.08.26.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Mar 2018 08:26:18 -0800 (PST)
Subject: Re: Error compiling Git in current master branch
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
References: <20180308161742.26596-1-szeder.dev@gmail.com>
From:   Gaston Gonzalez <gascoar@gmail.com>
Message-ID: <0b394844-f33f-9069-6feb-08d552866f47@gmail.com>
Date:   Thu, 8 Mar 2018 13:26:15 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180308161742.26596-1-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: es-AR
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/03/18 13:17, SZEDER Gábor wrote:
>> Just to let you know, I get the following error compiling Git in master
>> branch:
>>
>> $ make prefix=/usr NO_GETTEXT=YesPlease all doc info
>> ...
>>       GEN git-remote-testgit
>>       GEN perl/build/man/man3/Git.3pm
>> Can't write-open perl/build/man/man3/Git.3pm: Permission denied at
>> /usr/bin/pod2man line 70.
>> Makefile:2317: fallo en las instrucciones para el objetivo
>> 'perl/build/man/man3/Git.3pm'
>> make: *** [perl/build/man/man3/Git.3pm] Error 13
>>
>> This didn't happen in v2.16.2. Doing a git-bisect I've got the following
>> culprit:
>>
>> $ git bisect start HEAD v2.16.2 --
>> 2530afd3519a34b66e72cc29e7751d650cedc6dd is the first bad commit
> That's not the culprit, that's the fix :)
>
>> make clean fails too:
>>
>> rm -f -r perl/build/
>> rm: no se puede borrar 'perl/build/man/man3/Git.3pm': Permiso denegado
>> Makefile:2734: fallo en las instrucciones para el objetivo 'clean'
>> make: *** [clean] Error 1
> Have a look at the permissions of 'perl/build' and its contents, they
> are likely owned by root for reasons described in 2530afd's log
> message.
>

Right you are:

$ ll perl/build/
total 8
drwxr-xr-x 3 ggonzalez ggonzalez 4096 mar  8 12:52 lib
drwxr-xr-x 3 root      root      4096 feb 14 13:56 man

The procedure would be just removing perl/build/ manually?

Thanks,

gaston
