Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84EE2202F2
	for <e@80x24.org>; Thu, 23 Nov 2017 21:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753333AbdKWVac (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Nov 2017 16:30:32 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:36174 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753046AbdKWVab (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Nov 2017 16:30:31 -0500
Received: by mail-wm0-f44.google.com with SMTP id r68so19142520wmr.1
        for <git@vger.kernel.org>; Thu, 23 Nov 2017 13:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7NgUR68W/LRkwZv8gC9hbLvjA3UjVZ6ECcwSCdukYro=;
        b=M+3K76uYB0C4TXBSbwTUT6f4WzfzVczBBATBDmcju6uWIF5WDXU53mUEFrBnEaLkLz
         AL6iO0mRx3qp3tlZIILM0RY5KIxL5Ou3P8oyicFzOwZpg1a0a294R1EwZBBEEO5YK8Xe
         iCN6DOHdTXYiOnYC1o1TlW+AlaVRxvsbAQDFVHwNixaa5Zn+TJC9DH639/s4zi2pb96P
         yulJ11GMdazKqzZ8FksTqkFLpnR/9s0yHQjWqbUas1rZFb2McrvCUIO6dS3vYmT+BdWM
         Mi1/b4UbrOZXXjJrU6ri3ASpxVh3fyKHj7gTk8bxY3w/+z4gqISLq3tHrgYKsPgN5MLX
         82uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7NgUR68W/LRkwZv8gC9hbLvjA3UjVZ6ECcwSCdukYro=;
        b=CfsBs+0MckRPhqQagOxC62kjeiyYXPHdOgGS6Uldq5zFIBsaOQII9vqROUHk9Vdf2m
         gzHtlkJkqFterKIpVn3b1zR66Frzzg5MHlyFrWgxhao7GLCZmBN55uXXKSB3OuATs23b
         /At9ZKEDazzyEyyzGKzKGnk8rArrCgaxDJ8OaJ3qfl022aPE69qVXrMvWGUFv8c+nAk4
         a3fQozPKxNH//vz3RcJMqltnEHtB48WLp5NLHL7u5S9Fw+0UWa/vZbIGSf9Hpjpe79NC
         34Blmzra3TETASlIJ8fgzBP/E+2JJQvZQzX6IWHoLibKakH3MSjzpM45TBV/sb0RY+Aw
         RjBA==
X-Gm-Message-State: AJaThX61z4XN1cTh7k8V+OmudFOTz2yvB41gc+3z6g/8PpMedowqNThH
        zbUkIvUFEUGs8leXqXFYGjZBVEB8
X-Google-Smtp-Source: AGs4zMbRYf3v4KLNziGsTJr9nOh5vM1Iis/EFhuH+aFguCl3s4w/Mo2XdMCBxv9ENHL6SNkqeiaEcw==
X-Received: by 10.28.52.207 with SMTP id b198mr2067616wma.154.1511472630008;
        Thu, 23 Nov 2017 13:30:30 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id 16sm20436062wrt.81.2017.11.23.13.30.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Nov 2017 13:30:29 -0800 (PST)
Subject: Re: Problem installing Git
To:     Phil Martel <pomartel@comcast.net>, git@vger.kernel.org
References: <077942bb-5952-6f4a-8054-b17d3883b901@comcast.net>
Cc:     git-for-windows@googlegroups.com
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <f30c4350-500a-44e8-27ee-7d5ae49903c4@gmail.com>
Date:   Thu, 23 Nov 2017 22:30:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <077942bb-5952-6f4a-8054-b17d3883b901@comcast.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[ +Cc:  Git for Windows mailing list ]

Hi Phil,

On 23/11/2017 19:51, Phil Martel wrote:
> I'm trying to install Git-2.15.0-64-bit.exe onto my Windows 10 
> machine.  When I run this installer program no matter what options I 
> try or whether I run as administrator it ends up with an error box 
> saying "The drive or UNC share you selected does not exist or is not 
> accessible. Please select another".  I do not see any way of 
> selecting a drive.  Any suggestions?

From what I could Google around, this seems to be (Inno Setup?) 
installation related issue...?

Do you already have "Git for Windows" installed? If so, does it work 
if you try uninstalling it first?

Regards, Buga

p.s. Note the existence of "Git for Windows"[1] specific mailing list 
as well, where this issue might belong better.

[1] git-for-windows@googlegroups.com
