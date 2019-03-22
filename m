Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8680820248
	for <e@80x24.org>; Fri, 22 Mar 2019 08:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbfCVIAQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 04:00:16 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34209 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfCVIAQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 04:00:16 -0400
Received: by mail-ed1-f66.google.com with SMTP id a16so901380edn.1
        for <git@vger.kernel.org>; Fri, 22 Mar 2019 01:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=77+UmkHCpcJkt4+zV2IjvNg01v3pcyh8pMVBzVHYVck=;
        b=OfCwt5agxRFnlSRkLe9CWtVdoF8wxbWlfjy6Ys/OB1SYcrCZ+VgMKMTAxMQHsvTQ7i
         cd3nUqfqL3XtM7EapfcUGsONKfLR8Hm/ptUL3MQrF/xloIeJib31/YylWDsLFhvUoCdr
         O5aCZckZf6Ez2wpU2NuBuZadUuLWMk4+LktoH81rZvURkkNKHgzLUpsaIJVHgJwdTCh4
         psn0b71d8LGMv2kefO2E++a/4K7SK8Hc1fN+rnLZektTbXu1/mJhxPZs7blM5astuLJ4
         BSF4BG/pPAvHuak+nd/2FTYghLr082nWLgWMiOvgLbOc9H6LAgzn5T4Ix7fYltEIVCZH
         5Thg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=77+UmkHCpcJkt4+zV2IjvNg01v3pcyh8pMVBzVHYVck=;
        b=tKDrWvPPIPlgn8hBHK3B7FIeloFnh1tPpMDuQqDvqq1+obk3pIMBUFWGBJPK/lAM5m
         1SCGnDzoVzgjp8Wom5mg908RmEXub1buj3aLiliSqomtXJIsa4gJA4FvdEc6zOk9YJy5
         bhpRA3mVUUeBpUTKRealSz7dDgUADZX6CSw6rMVQOtl9aC6wdUQAfmiQkFFH4PSNClXj
         sf09BzDKamwtHbEmuwfogj+ZVWUduEfRSP5w3nF7ALVpnk1WLy620jYUXpel09nTJ70q
         8/xSCV+UcuEJRevaLxIkpvORPSWBMmn8RTmGJ/+q6y9tgX6iMO83gMMnPYVZE0aTphHh
         h0QQ==
X-Gm-Message-State: APjAAAVMhHGY1ORRUGBuCpJmHtEvx3nJ4XqzwqmGBuamIkPLeHIqT4Fk
        FlKCIIshO1ccvQUpO3VsfC4=
X-Google-Smtp-Source: APXvYqzNaza1anpmLDGu+0+VFNuKrsM58VuuchMxthlGhyZW8fGuNtiWRgBR6v22tHaHA8zg250tXA==
X-Received: by 2002:aa7:c818:: with SMTP id a24mr5372878edt.6.1553241614430;
        Fri, 22 Mar 2019 01:00:14 -0700 (PDT)
Received: from [10.41.1.6] ([212.92.112.81])
        by smtp.gmail.com with ESMTPSA id bs21sm1521847ejb.11.2019.03.22.01.00.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 01:00:13 -0700 (PDT)
Subject: Re: [PATCH v5 26/26] doc: promote "git switch"
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     eckhard.s.maass@googlemail.com, git@vger.kernel.org,
        gitster@pobox.com, jacob.keller@gmail.com, martin.agren@gmail.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
References: <20190317124926.17137-1-pclouds@gmail.com>
 <20190321131655.15249-1-pclouds@gmail.com>
 <20190321131655.15249-27-pclouds@gmail.com>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Message-ID: <46b16732-c736-fae0-2c25-fb6528f72797@gmail.com>
Date:   Fri, 22 Mar 2019 09:00:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190321131655.15249-27-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/21/19 2:16 PM, Nguyễn Thái Ngọc Duy wrote:
> ...
>
> diff --git a/advice.c b/advice.c
> index b224825637..27e39e6514 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -191,20 +191,20 @@ void NORETURN die_conclude_merge(void)
>  void detach_advice(const char *new_name)
>  {
>  	const char *fmt =
> -	_("Note: checking out '%s'.\n"
> +	_("Note: switching to '%s'.\n"
>  	"\n"
>  	"You are in 'detached HEAD' state. You can look around, make experimental\n"
>  	"changes and commit them, and you can discard any commits you make in this\n"
> -	"state without impacting any branches by performing another checkout.\n"
> +	"state without impacting any branches by switching back to a branch.\n"
>  	"\n"
>  	"If you want to create a new branch to retain commits you create, you may\n"
> -	"do so (now or later) by using -b with the checkout command again. Example:\n"
> +	"do so (now or later) by using -c with the switch command. Example:\n"
>  	"\n"
> -	"  git checkout -b <new-branch-name>\n"
> +	"  git switch -c <new-branch-name>\n"
>  	"\n"
>  	"Or undo this checkout with:\n"

With the start of the message being "switching to ..." this part could probably
be also updated to something like "Or undo this switch with" or "Or undo this
switch or checkout with".

>  	"\n"
> -	"  git checkout -\n"
> +	"  git switch -\n"
>  	"\n"
>  	"Turn off this advice by setting config variable advice.detachedHead to false\n\n");
>  

