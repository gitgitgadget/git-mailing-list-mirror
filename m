Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3D4E1F404
	for <e@80x24.org>; Mon, 12 Feb 2018 16:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964923AbeBLQY3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 11:24:29 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:53307 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964916AbeBLQY2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 11:24:28 -0500
Received: by mail-wm0-f41.google.com with SMTP id t74so10681345wme.3
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 08:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=kYlLAO1oRqWSYblLEa5MANWicKkiSz0orWU5R9tgh9s=;
        b=JJzO4tk4VIVjJMJ7GvsSmNTL6SUCBT07tygmvpQ77Es/CmU+zc8Hi8WXSh0kjE5tgl
         naJXuk2WVAsfrWdZ9nMEmd6LKXVQR6J+L018v9Za1q2/xO9Npqx4Acd+rXQYhOOaKY7p
         Nq6v6/FzuET0Ab/WfHF7r6UBBZ3gcEvYKXN0Ptas7w6gYVUgklAgGqBQp3l5+xGh4dqh
         roI3hk+b6cSEZPxcTQUNPfOlR7LithxW78TwEkl/JMZePvtLGLRi1R649X8+HuSh0Iw0
         TExrasdjHKNBmFkAZMEf/I7l4bnS0KGDDJRnSPzet4+baW2t1tZa9xxGk8WCEuwHDk6D
         Adlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=kYlLAO1oRqWSYblLEa5MANWicKkiSz0orWU5R9tgh9s=;
        b=k/uX7SBw89/uGQs9EnI/z92n0YYFZ48JqOMxOJj5G9+e+iFezzaw+HgVZOlmGMsPNS
         z/auWRM0ROdXv5EPFuxlEotJttu3gTrgpn6qOfJ3qzoPd2CuXCH692d6fYPZSqxiFuAJ
         3ynkWKF5kt6MiAf7Toe9afaRsL+uRXRmBFVX+MMtfB0pDIlRSw0u8yOqe5nCmEql2Vu1
         Hl/yWyBmJbBqVk89qQHNIwkr+EKYypzMec8lpUSJ3EMtOdFaNlKvopBIbyKuryaubFkg
         uEPplmY1P+FyY6Yci7vWn5zIZRXdqEKNombe/xo0Cim6zxspXFQnlvQmeh5RZMa7WvYX
         f/vA==
X-Gm-Message-State: APf1xPBkCgakQ+41oKwayUvjwWj1fk2vXf4vkioruBXsJYVGwSjAStmC
        /AqJC0hmd724bx7XeBIIwEtnBQ==
X-Google-Smtp-Source: AH8x225emebfbTDcv6JklxGWD+P6yrLkB3LLs+KAG3mTXy8Yu3g8UVQRT50CQaWfxD+LkU94p6YgQw==
X-Received: by 10.28.245.25 with SMTP id t25mr3751769wmh.77.1518452666702;
        Mon, 12 Feb 2018 08:24:26 -0800 (PST)
Received: from [173.194.76.16] (gate.reksoft.ru. [188.64.144.36])
        by smtp.googlemail.com with ESMTPSA id d73sm7531219wma.25.2018.02.12.08.24.25
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Feb 2018 08:24:26 -0800 (PST)
To:     git@vger.kernel.org
From:   Basin Ilya <basinilya@gmail.com>
Subject: partial fetch
Message-ID: <3086333a-031d-0c98-a610-d5e36992d298@gmail.com>
Date:   Mon, 12 Feb 2018 19:24:26 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi.
In 2017 a set of patches titled "add object filtering for partial fetch" was accepted. Is it what I think it is? Will we be able to download only a subdirectory from a
large project?
