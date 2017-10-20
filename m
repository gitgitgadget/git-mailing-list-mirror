Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54B771FF32
	for <e@80x24.org>; Fri, 20 Oct 2017 13:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752041AbdJTNTH (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 09:19:07 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:47402 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751154AbdJTNTG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 09:19:06 -0400
Received: by mail-qk0-f195.google.com with SMTP id m189so14221682qke.4
        for <git@vger.kernel.org>; Fri, 20 Oct 2017 06:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=BVGjXD0hQs69UpwbeiMk5knfaw0F2j+Zm3OS2GW4sm8=;
        b=RMe5JtL80uaC+M2QbDF2R+i2nP5pHZeHWt6hx1w9K2U1V/zrLbPqXi4K2C0GaoZ/IU
         gC3H1csyisqDPPLEJt+LqyFGHJ9mR0AzQWMvW6G6DQcW8hSxmfZ1XIswj575nTFENidO
         G4nwMM7EHrgpUShv+NCqq1gjlRzkx5uLUvekGkDEvk0OKYPOtThKwj6CxgCWmltYfqCE
         dE8uOLsHhIjDdhXk1piU/sm4xw6qsPI2HKoXknFgt1k0N0arXbyt7wNfOHeqgwmnShM8
         gClHc9Jb0pO/GcXRSR9bYCusRKjObwQC8m9Z/TBMF0Lsul1EWxkSWm2Nyb9XSMjdViRj
         79cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BVGjXD0hQs69UpwbeiMk5knfaw0F2j+Zm3OS2GW4sm8=;
        b=LbmTCwqsn0vR1uRK47IrYvq/3Tz1e9YcWqgWldxGqvzawoQr7zmH6P4xpr3zzIiFR7
         AV1JBW+rL8TR+2xZsJGXPJZx55U2Zn1TveCSA1Ph0X6y/qf+W/d5ZMp1SG0oomjDakz8
         ZxOSHRjMonSmmqVQ0n77LCK5W25Bke+3OUkrj1RRNK/+88zFRM87lZ2soeCO87h68WFs
         8HSgi8s9fn0o85ntL+srp0qXAEQmix1Dq7TfR7/RMy1VLutWZEiMVXZY/xiGNO8+TJUV
         JAsvhdyUkamO/2pSkI+Ivo+jcBn8HXZ/vBq70G2ReerbwKU46eCibrQ0wc2/vpiYqKFK
         y5OQ==
X-Gm-Message-State: AMCzsaVmAf5O/1neMjoXnpxpqMjgoWbtsOA2TTF1Zt8HKTzzN3BxARCG
        gKE1bRceLQKPefp0/3AxS/Fe2/7H
X-Google-Smtp-Source: ABhQp+QiBhqRqlInBYyoiq+Ub2rbnMNAu7MVqFzklUA2a7tNb2szuhxZWNa7J0PjXrk+NI+vsdHWIQ==
X-Received: by 10.55.16.220 with SMTP id 89mr6982772qkq.286.1508505545076;
        Fri, 20 Oct 2017 06:19:05 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id j129sm564237qkd.32.2017.10.20.06.19.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Oct 2017 06:19:04 -0700 (PDT)
Subject: Re: [PATCH 3/4] fsmonitor: Document GIT_TRACE_FSMONITOR
To:     Alex Vandiver <alexmv@dropbox.com>, git@vger.kernel.org
References: <20171020011136.14170-1-alexmv@dropbox.com>
 <169bbc6117f518ffc9371fea7dfd11439105cc80.1508461850.git.alexmv@dropbox.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <2ef8f550-610e-6a9f-32e8-f2fe99b044ff@gmail.com>
Date:   Fri, 20 Oct 2017 09:19:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <169bbc6117f518ffc9371fea7dfd11439105cc80.1508461850.git.alexmv@dropbox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/19/2017 9:11 PM, Alex Vandiver wrote:
> Signed-off-by: Alex Vandiver <alexmv@dropbox.com>
> ---
>   Documentation/git.txt | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 1fca63634..720db196e 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -594,6 +594,10 @@ into it.
>   Unsetting the variable, or setting it to empty, "0" or
>   "false" (case insensitive) disables trace messages.
>   
> +`GIT_TRACE_FSMONITOR`::
> +	Enables trace messages for the filesystem monitor extension.
> +	See `GIT_TRACE` for available trace output options.
> +
>   `GIT_TRACE_PACK_ACCESS`::
>   	Enables trace messages for all accesses to any packs. For each
>   	access, the pack file name and an offset in the pack is
> 

Looks like a reasonable addition.  Thank you.
