Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E1F320286
	for <e@80x24.org>; Wed, 13 Sep 2017 13:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751971AbdIMNFA (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 09:05:00 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37333 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751111AbdIMNE7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 09:04:59 -0400
Received: by mail-pg0-f65.google.com with SMTP id v5so67543pgn.4
        for <git@vger.kernel.org>; Wed, 13 Sep 2017 06:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=kYG5VF0TGUDwZkEK1ovbNr4UzyzbtKwZQSOxqKyrBno=;
        b=mxNY54g6Q6XGDgWyyDJJLKx3y5szjz0W9BnQqLAK+2gTkJOyNRMq7Rbsmt9K5QKaXP
         uFjryUwyDSLnsrdMBIi1YKtRmv5KASUGUR94cxolEezBJz0AAYqfWf4m1pI736876g1T
         v1lZrkbHSdonLTQprayo6Ho6zAMNv8GO1EfSEQBbCZOJ0Gxa4N1eyav6PUTgFcatrlq+
         ahpoeIeoYrehwH6vTlMDdo+XBIqYQqq2sG2edQ738DfaNEbTDbh1rqD6uQE0pLlz9Kcu
         hUdyy9ZjtUcU6JxOWyMHhIRtxYhErXBgRmUfaFRM05sqBa0h1BX65xSHOToOCthD0ZHI
         GzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=kYG5VF0TGUDwZkEK1ovbNr4UzyzbtKwZQSOxqKyrBno=;
        b=SS+dCP+uDbHqETTf815/yPys++rVBaLuRz/vF7P355zzT57qwg/EkzC4NHDPeglhbS
         T1OVIoKzXqua3yJWWN98Anc6/pScgkkJKVyhF5jWVbG3G2le0zMP/vcliNApKHkMpLR7
         GHcjpTSeJDFoPVq/mZcA8k1xWxd7LzG4IJ5n9iLx0dgcNzMNrmu4YCLJfo7SnNvU5Dfq
         BAdM5Y8N+Ql667uKtJhZDW6b5W9d6uIwA0HC59jn7YTy8A0wedgRKDUsIzSI0AkHxrGd
         eW4iLnce8YQYUN9qJoEp1Z8BAzBoUBRCdWIPYvXkic6BRwpONtqwNaOM0Yp3Xu0M2fVi
         vIPg==
X-Gm-Message-State: AHPjjUhGEIZA7niJ5ox5cmeLM6HtTPHVI/qE/XKGbo3xxkTsASrFlfGT
        gnYFGgMrc5mb4g==
X-Google-Smtp-Source: ADKCNb54y1Dnd5JS8rvClifyKeFhk7LGvh1R3zQhTwq0N74gFsuZEb85hK8h6GvcaqjC1Mgvb/LMMg==
X-Received: by 10.101.67.2 with SMTP id j2mr17459366pgq.182.1505307898875;
        Wed, 13 Sep 2017 06:04:58 -0700 (PDT)
Received: from [10.4.2.238] ([218.248.21.162])
        by smtp.gmail.com with ESMTPSA id b68sm27687919pfk.23.2017.09.13.06.04.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Sep 2017 06:04:58 -0700 (PDT)
Subject: [PATCH v2] commit-template: change a message to be more intuitive
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Kevin Daudt <me@ikke.info>,
        gitster@pobox.com
References: <20170912105536.6094-1-kaarticsivaraam91196@gmail.com>
 <20170913102915.GA21499@alpha.vpn.ikke.info>
 <20170913112013.sk7bqarq2ktrva67@sigill.intra.peff.net>
 <624d873b-74af-b3e8-714c-8a439f4ee81f@gmail.com>
Message-ID: <e656d1b4-c95e-e51d-5f48-bb3450580fa4@gmail.com>
Date:   Wed, 13 Sep 2017 18:35:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <624d873b-74af-b3e8-714c-8a439f4ee81f@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes in v2:

    - Changed the message as suggested by Jeff

    - Made the commit message to be even more clear


---

Kaartic

