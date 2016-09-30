Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12B7D207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 17:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933300AbcI3R0s (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 13:26:48 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35702 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933039AbcI3R0q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 13:26:46 -0400
Received: by mail-wm0-f67.google.com with SMTP id b4so4396691wmb.2
        for <git@vger.kernel.org>; Fri, 30 Sep 2016 10:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=hhcl7TjMQu6XXpngGoOkZDNhCsxjo0v1+/qzNxR6u2Q=;
        b=vRTSy1lQGPHiHIc/kydh6aW/2+p2ZD6cG9fCB59CIxflEq5EiBf1Qlcj7vziA0yHbB
         MloXhPd9btZxZEsadtmj0gblwebFpFBQ2ijigAtVCHhLKtK4KBltqxky0JH/76kEeIBT
         LehsgxCj9Eay4c7hMQ2yNTjboCOQ0X9AAa9riWImpVT/jzUTNXtfh5brJGB2Xz2UG2KT
         XVAkwQMX4/YskFFGLuKRw9vAa7Mr9HyARqD8JWdYeTHVnmRqWcTKurlxKqBLhZBrJMYv
         kvbWCVoaLiul3/MiiAf3S7gU5Q+AO5/peB9maNlSB5PS9DfgJJizCti/IxDkJQBmw2Iu
         v+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=hhcl7TjMQu6XXpngGoOkZDNhCsxjo0v1+/qzNxR6u2Q=;
        b=EHEQeUVrBEcMhLx5yEgyRCp3P9g3+qN4SdzlSKov0lRgL79iJb6k9pcc/B1vSm0p54
         GJ2sLxuwfz/3f7Gz+58H5lkzf3Sh6m5wRICtpDNCbiA3ivhRp41LzCB/M1wLjTYX4HjJ
         WQDqTLO7eu7+WDemM7JPS7+hgMNZYEa3J9haKChE+GFwB9hx7Af57W6K63o++ek8dpio
         0/knN4GRv9Lvr9vG0+dMQIYNKBybvTv/0x4y0zKTXVO+9jO1473HYzKNlbIqYgV/QrVZ
         5RGSt9E2tL7yaETlBA+omy9+gny+BQloI/7vox2smRO36CBgaxiRD22LIE9IPYljpU7v
         8Qyg==
X-Gm-Message-State: AA6/9RnIM5rIQbxtvaRjwaX4X7IhJQ5R/p2Qsi987PbdP2VW8X5MU3Jg7QxmyzUf8UtDPQ==
X-Received: by 10.28.141.6 with SMTP id p6mr5123391wmd.110.1475256404942;
        Fri, 30 Sep 2016 10:26:44 -0700 (PDT)
Received: from [192.168.1.26] (afo182.neoplus.adsl.tpnet.pl. [83.25.144.182])
        by smtp.googlemail.com with ESMTPSA id md9sm20683772wjb.20.2016.09.30.10.26.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Sep 2016 10:26:43 -0700 (PDT)
Subject: Re: [PATCH v2 02/11] i18n: add--interactive: mark simple here
 documents for translation
To:     Vasco Almeida <vascomalmeida@sapo.pt>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <1472646690-9699-1-git-send-email-vascomalmeida@sapo.pt>
 <1472646690-9699-3-git-send-email-vascomalmeida@sapo.pt>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Aguilar <davvid@gmail.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <e71c5040-8fed-887b-bf35-af4ae28d469f@gmail.com>
Date:   Fri, 30 Sep 2016 19:26:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1472646690-9699-3-git-send-email-vascomalmeida@sapo.pt>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 31.08.2016 o 14:31, Vasco Almeida pisze:
> Mark messages in here document without interpolation for translation.
> 
> Marking for translation by removing here documents this way, rather than
> take advantage of "print __ << EOF" way, makes other instances of help
> messages in clean.c match the first two in this file.  Otherwise,
> reusing here document would add a trailer newline to the message, making
> them not match 100%, hence creating two entries in pot template for
> translation rather than a single entry.

This is good catch, but I think it goes backwards with the solution.

If the text to be translated is multi-line, and it must end with newline,
why is this final newline not included in the msgid?  This would involve
turning printf_ln into printf, and adding trailing newline in final
entry for builtin/clean.c:295, etc. - I think it is better solution than
uglyifing git-add--interactive.perl

Though it is not much of uglifying thanks to Perl support for embedded
newlines in double-quoted strings.

> 
> Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
> ---
>  git-add--interactive.perl | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index fb8e5de..e11a33d 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -636,25 +636,25 @@ sub list_and_choose {
>  }
>  
>  sub singleton_prompt_help_cmd {
> -	print colored $help_color, <<\EOF ;
> -Prompt help:
> +	print colored $help_color, __(
> +"Prompt help:
>  1          - select a numbered item
>  foo        - select item based on unique prefix
> -           - (empty) select nothing
> -EOF
> +           - (empty) select nothing"),
> +"\n";
>  }
[... enough for information ...]

Regards,
-- 
Jakub Narębski


