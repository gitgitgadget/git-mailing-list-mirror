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
	by dcvr.yhbt.net (Postfix) with ESMTP id A59541F453
	for <e@80x24.org>; Thu, 20 Sep 2018 12:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387719AbeITSeK (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Sep 2018 14:34:10 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:45360 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387701AbeITSeK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Sep 2018 14:34:10 -0400
Received: by mail-qt0-f194.google.com with SMTP id l2-v6so3150323qtr.12
        for <git@vger.kernel.org>; Thu, 20 Sep 2018 05:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=DMJa1qejDyhhSnUxEDQ/A9BNRKbysRZemy9nNpSifck=;
        b=p2nEe9KIlH7ntxquAsHAr2gbvKjlk7LgTVKD3cd2I6Qv4xCmqKCHkz0dRI5mCEeIfk
         q8lBXdO64RmxYx3nRiGZ1aUGm2hf+snKlGURYpaPM7VMN+U4ovMltJyeStwKo99XnmpM
         jw6LbxuY2lXaTsD1FCuirTigjJcVDRJmSVjvjyOoyOlxWQr7R84+YjBeTtjL/ELumfRW
         Y2MKR7MqJMz/kVfTVdBM7BIOZfxa28K+vjFeIMZgNI0ynmszYV//8mq53aclMS/EwP8p
         5BfpvZiLlDa0mD8glOT2BP4YYeGf8vTwcrM18Uq+VpKfcPlKRx58dvynvNQt6/ujnDW+
         Gk5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=DMJa1qejDyhhSnUxEDQ/A9BNRKbysRZemy9nNpSifck=;
        b=q3iP+KG8H32R6v+g6rR8TVrQRP9b1aD7K9iaT7MNKyLAjw2QUIu6RckaTRf4wTQwE4
         IYLTy/5pGDKxXKGX891wqXB37+mNRoGwlDVRI5B6IuhOfeqMMGG4tXAnC58JgVbUIDvp
         0/6iN9lltQiN3InaahYTKZWxPOES+91kDKTDs6RZjyShHD7W8UAfQfk55gJBQ8JHWlbX
         bC1eo9r9/vt4E6Kzz4Hd/4zhq5WoLFN07us5x8i5Nr01+uwkCv4RqUXATKb500d3K17n
         PrxgVe60UxGfeXK69s3buGNbj2x+mzK3Q2XSQtvAgOpao35mt8rJA1JY3MipxZocLHB+
         lMsg==
X-Gm-Message-State: ABuFfojBCTfBX0b45MloRqh2FXcalc4m8pKrRb6GBGRl/teqedI4frun
        pr3K5XshnBmj8k0U11E/HqytZ33K
X-Google-Smtp-Source: ACcGV60lf06ppkCBHGXswWdeokEDMwkxwjAB7WasGb9q80blYhK/EiT4USrlOGX2QbXrjasw68Eu5A==
X-Received: by 2002:ac8:440e:: with SMTP id j14-v6mr2571660qtn.257.1537447848034;
        Thu, 20 Sep 2018 05:50:48 -0700 (PDT)
Received: from [10.0.1.17] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id v13-v6sm14386161qtg.82.2018.09.20.05.50.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 05:50:45 -0700 (PDT)
Subject: Re: [PATCH 1/4] git-commit-graph.txt: fix bullet lists
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org
References: <cover.1537374062.git.martin.agren@gmail.com>
 <222721870b74742fd2fd20816a8e351b28e788cc.1537374062.git.martin.agren@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <84a8fa75-0f3f-878a-ca5f-132e7ca4f196@gmail.com>
Date:   Wed, 19 Sep 2018 19:28:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <222721870b74742fd2fd20816a8e351b28e788cc.1537374062.git.martin.agren@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/19/2018 12:30 PM, Martin Ågren wrote:
> We have a couple of bullet items which span multiple lines, and where we
> have prefixed each line with a `*`. (This might be the result of a text
> editor trying to help.) This results in each line being typeset as a
> separate bullet item. Drop the extra `*`.

Thank you for noticing this. It clearly looks wrong at 
https://git-scm.com/docs/git-commit-graph

-Stolee
