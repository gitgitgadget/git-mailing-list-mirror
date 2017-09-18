Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED70A2047F
	for <e@80x24.org>; Mon, 18 Sep 2017 12:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932184AbdIRMcs (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 08:32:48 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:36777 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932114AbdIRMcr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 08:32:47 -0400
Received: by mail-qt0-f195.google.com with SMTP id t46so214719qtj.3
        for <git@vger.kernel.org>; Mon, 18 Sep 2017 05:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=In6OymLpeyFwToUSu5bYdxZrRLf7Rzs43o/Ck74mXjw=;
        b=T2VvGos331wKH/X6JW8rtwDo3fbocFMNuNR9R7BBx20mTPOKMOrVHGbskw1KSIAWFZ
         gGe2QN18TbgbGKAqNa9f92FDiz45q48ezVtA7q1kk2iGj7iFUwAH7/vJd4aOKjko1E7f
         fJxoZCVPcw9EK6hRcCU3Z7ENHWeNF7NUorJlvIHEbqpVOfQdrZrIyZ7SdlBeYG/f6Cb5
         sLnVHg4aP5i3Z86R30M8rN7yT0by2+yRfvNzNCCFPy/SYX01FCj2aoe941WhLIFo3k7P
         8UfWHgTbuvzq0HHK15UdV/GVu/qbCFSa4MV/okGSGicw1mHImTGcPR0ykGJpA5OUXH4k
         v76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=In6OymLpeyFwToUSu5bYdxZrRLf7Rzs43o/Ck74mXjw=;
        b=gLnEWTto2ZChs/XFloriLhz58eXOBHkQVdzNEC7dAQ/tzGzK9GRH6cEYVkVhsARxE1
         fY1x4J5CsKCj7NR8Z8YImkaM19FutD5jA14XkygG9ZXE0M+IgQLvCrdf0RUevy2mKd3Y
         JDnvadrKuSj3wmZlZfl4K1rXQkat90PKlF5OEzxvQoPxK0B98lzUc9EMlmtH8RfNmkEY
         c0TtP06BicswuUkwFHHAvrbgBNfTdxxYVakBc2qIu1Lb3PiaNblCM7RM6E7Re0LRGCqd
         JVVtXF0K++M4YtBeaAZIgIeGr6eQUxnPTJt9aV6B7wDJ5M1ofbH7gkMvrKI6/G6DG41I
         OUTQ==
X-Gm-Message-State: AHPjjUiCGqaOtQKhZkZoGpjau4MkNru6Gjbkdi036ck2yydUzpW/xgka
        s5cYPLE9i6N8QVQ6Rbc=
X-Google-Smtp-Source: AOwi7QDRtIdQ2oqeYAadfK7Sev414r+PJbPJgIKuVPyA0o7dajOQ34AP0Yf6OfcGzBUN6Fnvup0yuw==
X-Received: by 10.200.28.47 with SMTP id a44mr52652209qtk.256.1505737966795;
        Mon, 18 Sep 2017 05:32:46 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id t90sm5056734qkl.77.2017.09.18.05.32.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Sep 2017 05:32:45 -0700 (PDT)
Subject: Re: [PATCH] test-drop-caches: mark file local symbols with static
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>, benpeart@microsoft.com
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <762d317b-8174-1809-a077-38b036850d3f@ramsayjones.plus.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <756cf0ba-aad8-3fdb-298a-f174394e5895@gmail.com>
Date:   Mon, 18 Sep 2017 08:32:43 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <762d317b-8174-1809-a077-38b036850d3f@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/17/2017 12:14 PM, Ramsay Jones wrote:
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
> 
> Hi Ben,
> 
> If you need to re-roll your 'bp/fsmonitor' branch, could you please
> squash this into the relevant patch (commit c6b5a28941, "fsmonitor:
> add a performance test", 15-09-2017).

Absolutely.  Thanks!

I'd really appreciate some feedback on whether this works properly on 
platform other than Windows.

> 
> Thanks!
> 
> ATB,
> Ramsay Jones
> 
>   t/helper/test-drop-caches.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/t/helper/test-drop-caches.c b/t/helper/test-drop-caches.c
> index 717079865..17590170f 100644
> --- a/t/helper/test-drop-caches.c
> +++ b/t/helper/test-drop-caches.c
> @@ -2,7 +2,7 @@
>   
>   #if defined(GIT_WINDOWS_NATIVE)
>   
> -int cmd_sync(void)
> +static int cmd_sync(void)
>   {
>   	char Buffer[MAX_PATH];
>   	DWORD dwRet;
> @@ -49,7 +49,7 @@ typedef enum _SYSTEM_MEMORY_LIST_COMMAND {
>   	MemoryCommandMax
>   } SYSTEM_MEMORY_LIST_COMMAND;
>   
> -BOOL GetPrivilege(HANDLE TokenHandle, LPCSTR lpName, int flags)
> +static BOOL GetPrivilege(HANDLE TokenHandle, LPCSTR lpName, int flags)
>   {
>   	BOOL bResult;
>   	DWORD dwBufferLength;
> @@ -77,7 +77,7 @@ BOOL GetPrivilege(HANDLE TokenHandle, LPCSTR lpName, int flags)
>   	return bResult;
>   }
>   
> -int cmd_dropcaches(void)
> +static int cmd_dropcaches(void)
>   {
>   	HANDLE hProcess = GetCurrentProcess();
>   	HANDLE hToken;
> @@ -118,36 +118,36 @@ int cmd_dropcaches(void)
>   
>   #elif defined(__linux__)
>   
> -int cmd_sync(void)
> +static int cmd_sync(void)
>   {
>   	return system("sync");
>   }
>   
> -int cmd_dropcaches(void)
> +static int cmd_dropcaches(void)
>   {
>   	return system("echo 3 | sudo tee /proc/sys/vm/drop_caches");
>   }
>   
>   #elif defined(__APPLE__)
>   
> -int cmd_sync(void)
> +static int cmd_sync(void)
>   {
>   	return system("sync");
>   }
>   
> -int cmd_dropcaches(void)
> +static int cmd_dropcaches(void)
>   {
>   	return system("sudo purge");
>   }
>   
>   #else
>   
> -int cmd_sync(void)
> +static int cmd_sync(void)
>   {
>   	return 0;
>   }
>   
> -int cmd_dropcaches(void)
> +static int cmd_dropcaches(void)
>   {
>   	return error("drop caches not implemented on this platform");
>   }
> 
