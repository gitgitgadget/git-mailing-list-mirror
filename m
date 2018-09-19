Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_12_24,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAD9D1F453
	for <e@80x24.org>; Thu, 20 Sep 2018 12:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387758AbeITSeU (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Sep 2018 14:34:20 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:38080 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387701AbeITSeT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Sep 2018 14:34:19 -0400
Received: by mail-qt0-f194.google.com with SMTP id z13-v6so2240823qts.5
        for <git@vger.kernel.org>; Thu, 20 Sep 2018 05:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=dO+ftdC1OhFc/v3SrHK81GaEG+RjpMYa3l9uY3uXU3U=;
        b=aNilFzAmihbF1cScu8uVZ3lgHeQ8Qiire41H73XBLBzT1ILKL6M6F3O90XkC2UETeO
         m4xtRlzBqM4sFKfNbkBJDyQRFqcBBMk+9CzkO3ycdUgn5PyFf0kPRxs6mmPOENDuCOl8
         K82pZtVS8fZL/AGZdc2OvZ1n6c2XAYHoDgRCJ9WPfdbPRvqjdGY+pebkKvzLTW9vrKXR
         Qo1dAg+ws3jqLzDftJSJKe15r/XuigxXXCvkUCEj7jyQAuGJyDVpRb5Az2WvNNm16jpx
         4V9IvKAleQk2afyY/1nTSmKVoDccMYEnfMCSfS0F9ywwJSvgAZsyokTTJB34P2wFnIsy
         ck2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=dO+ftdC1OhFc/v3SrHK81GaEG+RjpMYa3l9uY3uXU3U=;
        b=spm5HU5tdjlJcRWmXf8jHOmoMKXOrvxtJ/F+T+6gsB3f2QauhRWL78XEUyJQKR436O
         KqQd4RjZiTKRfMnploqpMe7xyuVUezKHN0oF4X7tb1ww7KKjj+lLd+w1sGrS4ox+sh18
         Bc0zCQQcqXwp12HGoXir0ZfzScOtgwOqbD3VZmhg/WpZ9WI2WDygjKnWnlN4qHscO7u3
         Wk6KJC0Z8IS8shXHTL9FIw29ZdfcG026Xf8tn9zcOP3RlBECwkY8tfYbp/bGBM82t6aV
         XT7rMFfdp1Llt/w1yIx4C1q4jGyCQ1Gobsgkez/RT8WXi6C/b2B4d1725Gx7FOBtozG+
         7qGg==
X-Gm-Message-State: APzg51DRq3mhSSLqnuAgRvjuLhWNwEEhszzKWT4dJjRszNtf7Hjcbeej
        +vi8vAZ4U4CtXnx8Yys94j6dynKg
X-Google-Smtp-Source: ANB0Vdb155WXbU+ziaXtC1DfdWWBw83UX1sdLrlXgdkuNAclDYmoI7wJCx9eFkHC+to0AYgt4EUhdA==
X-Received: by 2002:a0c:bd0e:: with SMTP id m14-v6mr27901384qvg.168.1537447857174;
        Thu, 20 Sep 2018 05:50:57 -0700 (PDT)
Received: from [10.0.1.17] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id s73-v6sm16724547qkl.65.2018.09.20.05.50.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 05:50:55 -0700 (PDT)
Subject: Re: [PATCH 7/9] midx.h: add missing forward declarations (hdr-check)
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
References: <7b45f9df-5d46-7d75-02d0-457a8ccabf37@ramsayjones.plus.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <23cbbba5-029e-8031-ec02-a6aa5ec310b2@gmail.com>
Date:   Wed, 19 Sep 2018 19:35:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <7b45f9df-5d46-7d75-02d0-457a8ccabf37@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/18/2018 8:13 PM, Ramsay Jones wrote:
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>   midx.h | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/midx.h b/midx.h
> index a210f1af2a..622ddac472 100644
> --- a/midx.h
> +++ b/midx.h
> @@ -3,6 +3,9 @@
>   
>   #include "repository.h"
>   
> +struct object_id;
> +struct pack_entry;
> +
>   struct multi_pack_index {
>   	struct multi_pack_index *next;
>   

Thanks for catching this!

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
