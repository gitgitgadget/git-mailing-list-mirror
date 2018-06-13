Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B08E11F403
	for <e@80x24.org>; Wed, 13 Jun 2018 22:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935462AbeFMWXM (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 18:23:12 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:39018 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935060AbeFMWXL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 18:23:11 -0400
Received: by mail-wr0-f171.google.com with SMTP id w7-v6so4321983wrn.6
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 15:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j4jAItZJlfVAw+qe/fPV3ViQ2sV5JF5G91r5XhibgCA=;
        b=BXv4jyQ4+ys9moltA01rycutH/cLPiFICwDw5yCV40YBL+nmTFOdEf+8SXaHMFy7eT
         gYf9ygssvVU2WkLtk3LqGo/eJGCEIsBtR+diiejGqgBPZtMXiJl75AZ+wuy2CrkzDBYr
         Y8QAe6wM0wEASlxuIhkTaGsMSWDFJxptB/nsKLyq7xcMqQRoIhKtTw7E/hPZjAfaflNI
         iuH3G6nLc6RwFIkhY9as1w+K2WCz1T9wMmJVmHM72HzaoNYB2bESmIP6Lo8tqP1JU5Ck
         NeKnLn9UMtMnFWw7YClbbaBL/sznaLdt3oh2s3zn6R0eA6RfwkEbJhHt4n4Fjbz/2b2L
         +X1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j4jAItZJlfVAw+qe/fPV3ViQ2sV5JF5G91r5XhibgCA=;
        b=rdNFe9kyBkYmCjoRREic3SyDoOUAlE+Td8zMkWdHXE9r49Fw491tBvKOqVB/RYmDN+
         gQ4ya2z2L+UUC5iI7O1HmlLJl6sNRHzQn+h6KS5zdwOJOr0/bxUe9yJqQQ+80rMx5DAB
         /MiofA/Fk55zIHkPBSkGmRsCpP0FL8qmctdLc8cCegbTkWrGtYnQmeBIVFqHNraAZCsn
         LHOdj1cbBsaZyP/E/joPSPy6/s9hW19k2nE7WPpQVM8QEVMF99/I3aYCIni6LeoTaQoo
         S9D3VjjzGV6k6oJZunGSDmBJpClS4RH+1VxVUXxR1E8Ukr7iOtiTot4UjaKO/CXKBU3c
         yFBQ==
X-Gm-Message-State: APt69E1pbquAuGYGY/FQdLjdQ4BOpj3i8y/FpxDAbsA8h86yeTLXj/TL
        YuOXj1MiS/rIR/ADtG8O7Sc=
X-Google-Smtp-Source: ADUXVKLSXSYtXXnli+v4hq06qgDDVGQhvIEUJzC/rhmsshmMfj3I3B9DvFXCt4xBj+zjNAPwwi/EUg==
X-Received: by 2002:adf:e644:: with SMTP id b4-v6mr21365wrn.254.1528928590586;
        Wed, 13 Jun 2018 15:23:10 -0700 (PDT)
Received: from [192.168.0.137] ([86.127.75.25])
        by smtp.gmail.com with ESMTPSA id g88-v6sm4956551wmc.27.2018.06.13.15.23.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 15:23:09 -0700 (PDT)
Subject: Re: [GSoC] GSoC with git, week 6
To:     Pratik Karki <predatoramigo@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <bcb4a1e3-3e72-749e-dfb3-09acbd049b87@gmail.com>
 <CAOZc8M9qEaXuy-cV2E8LU-6GXmMu=kGL8NfGp33-+YPTmv5SsA@mail.gmail.com>
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Message-ID: <454a410e-6334-7c74-776f-e7a3a0cedd02@gmail.com>
Date:   Thu, 14 Jun 2018 01:23:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAOZc8M9qEaXuy-cV2E8LU-6GXmMu=kGL8NfGp33-+YPTmv5SsA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Nice job there! I also published a blog post regarding `git stash`.

https://ungps.github.io/

Best,
Paul
