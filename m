Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E30B2047F
	for <e@80x24.org>; Wed, 27 Sep 2017 15:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752632AbdI0P7q (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 11:59:46 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37155 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752455AbdI0P7p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 11:59:45 -0400
Received: by mail-wr0-f195.google.com with SMTP id u48so5414245wrf.4
        for <git@vger.kernel.org>; Wed, 27 Sep 2017 08:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7eMRhNn/LuqzPpiyAF+Sp4nqOItITqGHq1xeB5RHTQA=;
        b=LRcnp3ak8UFwHbjWAyQQdJJarUsk4XyNmZu+KedAvq55rMFQzPnRZL5hVGCbrgn/vZ
         8KNIaO7rdOezFCoRLd9ycnjz2kZrtebPxqx/T4Stzu7O8enBqafBKck0Z2OtPK1Eh8KN
         eNo1vBmr3tFWvaAogDDcSKQUGzXdhMO1Oc15BzKELqaurYFm+tAG1K2jV/hnuGrE49Hl
         NWhxKIUisbT0v8ZUVRUpYgjilW8U3moQuuiXhCuhPTzuyD+CixwCT7UgNQ6VWzy0S9se
         p8WFhrQYXDRIuQC2VWKsv/O2KIsVaRr1Z5m+SMpJoTMeAtjcEx2z/UOEgIAGRjK1JX+q
         DO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7eMRhNn/LuqzPpiyAF+Sp4nqOItITqGHq1xeB5RHTQA=;
        b=YO4zpDI4c8nh5noxHcCWHnGk5ujTlJc+gpLQ6LnHOP9+HX4PpG5iZ+KPn8x5aRydnN
         EFU3zL6w9ajE15m9X4akxPx4JH1eUJ6E4MRKy6IHQhqk5qjQYGIcXSIewnIWnLNURZa2
         DJ9SJFlXPZvRzCNv8QqTIynNyIrkImJRFJ3FEmFsrHrJCRJ9kG3BNJ04ro5Xl8/x3Fmm
         rY21JOZ+HwrSJjVErGssGwwmsnSu1nfHeHzDYDIoB+x6HOXo8A0zfoRfP41LCVuxaFqb
         hkB+DGG2+QlbL6bzVPPMWO2TfDC+PufaCGKjjQgOQmDwuTm5FuNprdMTmoiVhb+Em2AB
         y/Rg==
X-Gm-Message-State: AHPjjUjSvU/0KK7toM919kZyfh/Ga96S4xLvMLveJrDhOW0q9/P/Aiob
        5Fz0YY37Yu6oRFY8k2XOuX4=
X-Google-Smtp-Source: AOwi7QClqBGF5aeMpEAqQ/5Aa7A+IeuPZ6KxF8aZE/2+G9Qfx6euszEjsh5oNGD02ZflDKI391ojAQ==
X-Received: by 10.46.9.150 with SMTP id 144mr863367ljj.30.1506527984561;
        Wed, 27 Sep 2017 08:59:44 -0700 (PDT)
Received: from [192.168.20.21] ([89.113.128.32])
        by smtp.gmail.com with ESMTPSA id f87sm1772619lfi.89.2017.09.27.08.59.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Sep 2017 08:59:42 -0700 (PDT)
Subject: Re: [PATCH 4/4] Move documentation of string_list into string-list.h
To:     Brandon Williams <bmwill@google.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
References: <20170925155927.32328-1-hanwen@google.com>
 <20170925155927.32328-5-hanwen@google.com>
 <20170925174033.GD35385@google.com>
From:   Andrey Rybak <rybak.a.v@gmail.com>
Message-ID: <94b87cf7-9636-32d7-95a8-977acf299b7d@gmail.com>
Date:   Wed, 27 Sep 2017 18:59:41 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170925174033.GD35385@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25.09.2017 20:40, Brandon Williams wrote:
> On 09/25, Han-Wen Nienhuys wrote:
>> This mirrors commit bdfdaa4978dd92992737e662f25adc01d32d0774 which did
> 
> Not really important but most times we reference another commit from a
> commit msg we include the one line summary like:
>     'bdfdaa497 (strbuf.h: integrate api-strbuf.txt documentation,
>     2015-01-16)'
> 

Also available from the context menu in gitk as "Copy commit summary".

--
Best regards, Andrey Rybak
