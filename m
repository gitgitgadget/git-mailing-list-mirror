Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_STARTS_WITH_NUMS,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74C931FAE2
	for <e@80x24.org>; Fri, 23 Mar 2018 01:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751661AbeCWBon (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 21:44:43 -0400
Received: from mail-pl0-f42.google.com ([209.85.160.42]:33111 "EHLO
        mail-pl0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751551AbeCWBom (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 21:44:42 -0400
Received: by mail-pl0-f42.google.com with SMTP id c11-v6so6523924plo.0
        for <git@vger.kernel.org>; Thu, 22 Mar 2018 18:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=bsLZ7jgyo8bdhjV9BtVa2eqTMP1SSfnU7HqrIRCDmsw=;
        b=eRzdEqISxJJJ8BMPEN2vPo+YKT88Igv+7npeVC9oQ+/1Qi74b7iUj3IVwEUZb+Xyp9
         d2Bn8e0j+sUSt7YF/CojGByLGUukZkdM8h8MQd13tcCgGD/M7C75/PMzHI976SkhzW0n
         kkydatzZR7NnFByY03EydReQQK0lzIQcUKcXWTZnXSIss67+q7ICewk/ld1yycYheH25
         +t/lbip+jEdp3JXgrpvteWLv1ZCRr+cD61nUMhQPtOLGLaTHNnkK2iOymZN7jGSMS2FZ
         rrsRKOgz0+gGGe9zF3SiwC+PgBdojLhc6PDfcae2cRDpZgu7yftCHfS23vJeuzKBOpNV
         kTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=bsLZ7jgyo8bdhjV9BtVa2eqTMP1SSfnU7HqrIRCDmsw=;
        b=WC3rRA3m52bMu3WCOk1eHOCkZITjhFmKNDEviSGCsu95A6B+WpIG8VzRI8Y+yoQL7H
         pKEO7mkHFxKKOfKT1sVLfJrx6wWsv/d+dkmxJufdMeUeJ8XWJw0naz8KMevFzFyIZn7u
         bwJch43cGELh40F1ZhF1ZBZY9inKfn9+HtSYNf/pfaeJE8BCXCxSBfcNv/boiwyKQo9V
         8a7ZdjIjZ6BgO47UMjd1W9N+2gqY+cYf0ySXUaU/oRRov8QUSEbEMxxqJiQUhOs/NJ6m
         LzsRaL/VCOgDqbtidx7XO6Pgj7mTpP17aNEv95CYNI0mlVcCzg6wP8OzVrkSuhi5atU8
         cqJw==
X-Gm-Message-State: AElRT7E/wTim1SXedSM5RfZlVd33PSNBqlHzF6heEovriuCscVn3VkdW
        fVXz+AeXSg5cR1oc7j564N0S/I27y30=
X-Google-Smtp-Source: AG47ELvBhXqhU84mlQKn7gtp+OwLbh7koJ59EfDQBsVvRJS0SkDUWTdNvxm3S/j+Tmetzst7uKadWA==
X-Received: by 2002:a17:902:a5c5:: with SMTP id t5-v6mr27696205plq.244.1521769481296;
        Thu, 22 Mar 2018 18:44:41 -0700 (PDT)
Received: from [10.66.13.0] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id l66sm2002593pfc.184.2018.03.22.18.44.39
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Mar 2018 18:44:40 -0700 (PDT)
To:     git@vger.kernel.org
From:   Zhibin Li <08826794brmt@gmail.com>
Subject: [GSOC]About the microproject related to CI
Message-ID: <d64eca23-8a59-1aa2-597a-128e341f4af3@gmail.com>
Date:   Fri, 23 Mar 2018 09:44:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I'm Zhibin Li, an undergraduate from China and I'm interested in 
automated testing. Since the application deadline is coming, hope it's 
not too late for me to start with the microproject. If it's ok, I would 
like to take Git CI Improvements 4 as my starting point. But the 
description on the website shows less details so I wonder what am I 
supposed to do more specifically? Reporting the results or trying to 
figure out the how and why those results come out independently? It 
would be nice if you guys can tell me about any details.

Thanks,
Zhibin
