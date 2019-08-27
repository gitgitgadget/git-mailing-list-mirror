Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_HI,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
	SPF_NONE shortcircuit=no autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F1F11F461
	for <e@80x24.org>; Tue, 27 Aug 2019 20:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731447AbfH0UbB (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 16:31:01 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40451 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfH0UbB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 16:31:01 -0400
Received: by mail-pf1-f193.google.com with SMTP id w16so140415pfn.7
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 13:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LCQRIf3EepkhttlenTCgvUoDaOyQ13qRNUxCNycs7YI=;
        b=TetX2ALkSuWnVxCLCjEgzkmB+QNH2zJBzQ66ZWE63P1ixO8Uuh/2W+mjxnsNVFCfNN
         2JTa86yo2RjNhUsxxpTv/84Kyqyf6jMICq9B9fJxLK66XMlnTPHOp3rA7t8kBqxwdoex
         0JLtpGikeQO/ghr3xAPkuqs5ia3HIhAjIOEWWWg05KMlPC9zu3tU3K1ysmEgDXV8gVvB
         y9/NB83ItmwqkF2Kl+Knh3rmC/Gi55T5m8+f5uLvkhaMhvCfmzQdupvy+Bkh95+c8Oyp
         tFkCH2XAAq+2JMq25lwlmmWmNRToNj8imzroOZZDkQS1CT6S1teZ3IB9wyfEX9DAGyRI
         xHCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LCQRIf3EepkhttlenTCgvUoDaOyQ13qRNUxCNycs7YI=;
        b=ZeFkM8v/MoDkqoPWOmptFY+zPOqvaohmuDbXwA9TXKcHZgVA0wsWa/baFzGfsMaM6V
         H1GKXUQwaYviCd7hDBEGiPydio0/0kJDNUg3cLnGxRzgncoomeL9dtvdQ0E3lPdsv/yQ
         xAdpiX3NUWjG0Pap9yxaUshVKB/ME8/rYf7Ep72YpmMPERrZ0AT92gLLfKLEMheK6XZz
         3f7jzWInEkiSM7N11XhgLQUx3rQ7GWi1cod3fjSWLcxvycZXtuxx5Q/VV8ASC/1ofAVz
         cKDXvzsDlXhY700y7GyTA8eBgI5kiMWk+pX0g6US/kVly1HSX5W44q2/T1FxqLvMk+WI
         nr3w==
X-Gm-Message-State: APjAAAVmWpNqi77lnFj3CJ1vlsQv5GjkUzUCO69kX3M4kfQYJH2MjJzo
        zYIFho14Y/NdndT3zISkB8/OtQ0I9u0=
X-Google-Smtp-Source: APXvYqwju3sulU19ScYee9ae1qw/4f/H50zLU8yKDxltscKWSuKnFIZx1l19DwFbX+srZ9ht7E56kA==
X-Received: by 2002:a62:63c1:: with SMTP id x184mr366923pfb.11.1566937860388;
        Tue, 27 Aug 2019 13:31:00 -0700 (PDT)
Received: from ar135.iitr.local ([103.37.200.223])
        by smtp.gmail.com with ESMTPSA id u1sm221369pgi.28.2019.08.27.13.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 13:30:59 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org,
        matheus.bernardino@usp.br, newren@gmail.com,
        olyatelezhnaya@gmail.com, t.gummerer@gmail.com
Subject: Re: [GSoC] Blogging with Rohit
Date:   Wed, 28 Aug 2019 02:00:46 +0530
Message-Id: <20190827203046.10714-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190511001421.25283-1-rohit.ashiwal265@gmail.com>
References: <20190511001421.25283-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Everyone!

GSoC is finally over and I present to you my final report[1].
Thanks for all your support and reviews without which this
would not be possible.

Thanks
Rohit

[1]: https://rashiwal.me/2019/final-report/

