Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD3F51F453
	for <e@80x24.org>; Sun, 21 Oct 2018 19:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbeJVD4D (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Oct 2018 23:56:03 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34031 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbeJVD4D (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Oct 2018 23:56:03 -0400
Received: by mail-wm1-f66.google.com with SMTP id z25-v6so7696329wmf.1
        for <git@vger.kernel.org>; Sun, 21 Oct 2018 12:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=45UWn966oBQCiKImQiKKcv8Dx1a1ifCu5v0J++7F0Jw=;
        b=StXWNVWMnh4/p3duE7zgVBBTLYKUa4LfWiFr+MuWfZI3jizUJ2+zdgardUAABrOlo8
         vBljVDdBtT/unYRcxfaebseKcUQY+o+lnYEClKvapIB9ZBLc8H96PakpHDg1Yo7lK0Er
         W2UCJA/O2BzpjMgilo3qMTxD1NtYF/jxgWd2SYBNUNLRAGU/5f38GclZX3hfnAeSVpfB
         vZCq4xEx9JI4CZR+7lggKaAN76hUTfshEdLXTrCpTYFn5V8qxKjpYnycxnC05NhfwrAD
         kIBT0ZBqWeRlxKCKpyKaJar33eRTL5D4sRcjFxTF+uDiTsAY7dWBvtywRjByEPbQtO1E
         loPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=45UWn966oBQCiKImQiKKcv8Dx1a1ifCu5v0J++7F0Jw=;
        b=ONPm/UlOYZkeK6YhauCH4NBZLJNLHBsOmfcFLz8MpYBk6r8CEPr81Wmt/fctgKz/eX
         xCY2dydj6xjsvxwdl4hOCKI7cByEa1vGny+m3oEsSEcO0x0C6945UaTDcF2C2VKilD2U
         /k/IUCXJWnaLGXcxN4SwWiL9JvbbyK0GfOVIFT3pHBDm09YNAfYHMDbdiTxLka0ELpya
         MVMGxkM3erfQu/wrCW7HbtL0Tr1Wqdt1Ub93I4IKZxXJNYEtJsyVgfRDOIkPhgzY8v5S
         LCYfOGf06MoroJQHkXvViRFoOO6Q5+l5OCPKuC39fIzLd5gGQ852WeMkv7HLDhtDPWv4
         WbWA==
X-Gm-Message-State: ABuFfoiWse2vnpOQl4JqHYA//wGEzE2N05f0UPUDoZIaYL2YkMyVGLnV
        wt0UEBYvVOF4vkTw8+jRtlA=
X-Google-Smtp-Source: ACcGV62RpuWEiMzQQeeNxVWTXk0XakiArhraItzP3apCcFC/W39vw4j6wY4GKJR0Dzca4ymYntdQ/Q==
X-Received: by 2002:a1c:b0b:: with SMTP id 11-v6mr12243816wml.25.1540150838956;
        Sun, 21 Oct 2018 12:40:38 -0700 (PDT)
Received: from [10.41.1.6] ([185.220.70.155])
        by smtp.gmail.com with ESMTPSA id c14-v6sm3925081wrp.8.2018.10.21.12.40.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 12:40:38 -0700 (PDT)
Subject: Re: [PATCH 29/59] config.txt: move i18n.* to a separate file
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <20181020123848.2785-1-pclouds@gmail.com>
 <20181020123848.2785-30-pclouds@gmail.com>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Message-ID: <04b95a91-43b3-c12a-4425-84a2f9e3e707@gmail.com>
Date:   Sun, 21 Oct 2018 21:40:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181020123848.2785-30-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Subject line: s/i18n/index/ 

On 20/10/2018 14:38, Nguyễn Thái Ngọc Duy wrote:
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  Documentation/config.txt       | 11 +----------
>  Documentation/index-config.txt | 10 ++++++++++
>  2 files changed, 11 insertions(+), 10 deletions(-)
>  create mode 100644 Documentation/index-config.txt
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index ec0f4e2161..5ba7975837 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -606,16 +606,7 @@ imap::
>  	The configuration variables in the 'imap' section are described
>  	in linkgit:git-imap-send[1].
>  
> -index.threads::
> -	Specifies the number of threads to spawn when loading the index.
> -	This is meant to reduce index load time on multiprocessor machines.
> -	Specifying 0 or 'true' will cause Git to auto-detect the number of
> -	CPU's and set the number of threads accordingly. Specifying 1 or
> -	'false' will disable multithreading. Defaults to 'true'.

[...]
