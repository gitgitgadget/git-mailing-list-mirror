Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AD5F1F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 19:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754787AbcJETXn (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 15:23:43 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36748 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754597AbcJETXl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 15:23:41 -0400
Received: by mail-wm0-f68.google.com with SMTP id 123so124908wmb.3
        for <git@vger.kernel.org>; Wed, 05 Oct 2016 12:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=LFDHriTjhXrbaxECEfxJ1dzi8iv/ej0S2RrChdAhhSc=;
        b=KoaI2rQWYGiQLIKdIYV0+aX7ecimSfrBER4NRZEJn6W1TX+VKqqgKiOczzRzwoEBEe
         Lpmc5QiHPnJ6pzy8utbN+ARhP9F33Xm6aSgSZIDxq2pv/cwCns5EynjI4jrxvvWMmnj1
         Y+8unuF5J4ShFP6qWAfPdBANZCMyVA4PgYXD42Xbw3mmOh7uuIXcCrZORojqIr0XvpJc
         o6zGCBjsV4Tgs9/0xzlBgbqC0z8TDEmwarIra7XkCJFFdUjzanomXu379aDcyJSrscJ1
         ilblpQavkUmqSyW6EXizrqgogHmuu8MydQVjVNFzSYipxo6zJrmReRrCy90Xway06v2H
         oQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=LFDHriTjhXrbaxECEfxJ1dzi8iv/ej0S2RrChdAhhSc=;
        b=IqnIxS6GkrnVIhTu2scoDyuaax7Ke/uJ+XPC+oWbzv7xZQgdbbgKOaAhu/UdeFmdtg
         dN3G2kUm759WxAw+ZuaGarq05ZHGxSuHBdpKJ3dkkQ11CiyGiebCdvyYltmRU+75Clri
         iptyoXf6fMPdcs+pNR16k5n1AOwhjsxMhUBHzu0BCqLYeLNvE72VMoPl5DwKv3Q0AkVc
         bW+hN4mYdS+eYhL3Re0pD93diryN9ZuIML9e4ny/e0ejA9Kjv7WqOps6ihDiMFh/Jtdl
         r7Tole9SI9SSmlq8hNKyOuVmIoxlw3lVzLtbu8dtoPYLkPOT7vKNEakLvFBst2cQDYie
         WLhA==
X-Gm-Message-State: AA6/9Rn7fsDbU5eZOMrCt7JtyKsyAbsBuMFzYROjtQlfsm54TEg268YHujwJFe4dIIpqWQ==
X-Received: by 10.194.236.68 with SMTP id us4mr9029664wjc.12.1475695419513;
        Wed, 05 Oct 2016 12:23:39 -0700 (PDT)
Received: from [192.168.1.26] (acte13.neoplus.adsl.tpnet.pl. [83.11.58.13])
        by smtp.googlemail.com with ESMTPSA id xy4sm10460132wjc.2.2016.10.05.12.23.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Oct 2016 12:23:38 -0700 (PDT)
Subject: Re: [PATCH v3 6/6] wt-status: begin error messages with lower-case
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
References: <cover.1473580914.git.johannes.schindelin@gmx.de>
 <cover.1475586229.git.johannes.schindelin@gmx.de>
 <1d2639277473010731ace0af8358bafd3c622a8d.1475586229.git.johannes.schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <615ff493-5de4-5d73-dd6f-2ff818ac9ac1@gmail.com>
Date:   Wed, 5 Oct 2016 21:23:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1d2639277473010731ace0af8358bafd3c622a8d.1475586229.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 04.10.2016 o 15:06, Johannes Schindelin pisze:

> The previous code still followed the old git-pull.sh code which did not
> adhere to our new convention.

Good to know why it used its own convention.
 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/pull.c | 2 +-
>  wt-status.c    | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/builtin/pull.c b/builtin/pull.c
> index c639167..0bf9802 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -810,7 +810,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>  
>  		if (!autostash)
>  			require_clean_work_tree(N_("pull with rebase"),
> -				"Please commit or stash them.", 1, 0);
> +				"please commit or stash them.", 1, 0);
>  

Shouldn't those also be marked for translation with N_() or _()?

Best,
-- 
Jakub Narębski

