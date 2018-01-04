Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: **
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=2.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,EMPTY_MESSAGE,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MISSING_SUBJECT,PI_EMPTY_SUBJ,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61F891F406
	for <e@80x24.org>; Thu,  4 Jan 2018 00:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751647AbeADACP (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 19:02:15 -0500
Received: from mail-ot0-f177.google.com ([74.125.82.177]:42331 "EHLO
        mail-ot0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751237AbeADACO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 19:02:14 -0500
Received: by mail-ot0-f177.google.com with SMTP id 14so40023oth.9
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 16:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:message-id:date:user-agent:mime-version:content-language
         :content-transfer-encoding;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=H3WUaUPnsbRsLozFdt2YXWhsvpTCVf3I+wb5jcUdKPn+dpNRfTOGqwAwkIAexJhOO4
         l3tbdJXlXJmzJu/p5QjXFbq73l5nEQY14ZDVHGC6NKsWsYWJzxClboYz6Bq40/ODA+cc
         h/jkVPJiruz/k4adsoEP0mVaiKZT/C+9M0UD2lTUSpIscNI8fVnSctSIyCLjffZdBBTh
         iWs5Rtiwe14K6tuxX2mihedpfEVdTLxs5p2KCZtJGb4zbRgxYRWidpMGaMxpba9Jn/N6
         Zwkh4ChQ94/Y6R0EhcVC3sP4EUM9Pj2IeWjyWkC97wkvno4MPnVAi3yZCGmBWwQfwgrK
         lBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=UW21t3eI/PS9WGUQCjZ+4cfhWdKQ1msrIjdgjab0FTFriGUYKP7pyj5AmZstFkb8fG
         q+0rFK76m/8QM/fqO4BbZRjMmLz+y53joiO7aHVPsgS5o2OKjJ67yjW+FpCph9VORRZy
         1Ei+BZh0leEmcwMe/noLEqZx6oGh+XI7FFBmZDGl1hnIx1tRMYNjcYDWT/SfV4vPrQnk
         /mfLyuCphTLQsjBDUy7kUhFuJrhzH4Ku/s+q9CiAt87JI/1/QzMsidumOFSUIRewq15J
         WG2GFplqeuy05V72lTn/Mmi6mjlrYYnVw2a8ntDEr/DTLQ2HhucYFZEl/zw+Pq0GkdNe
         Kamg==
X-Gm-Message-State: AKGB3mKfSkt2DO0It4l9J/BxUQ+8FCipM56VYbVVmi+TdcaYWw+kqKHF
        BcY52XewhG5rCFb5wqZwhagf83gd
X-Google-Smtp-Source: ACJfBotkCqZyxGGAUYYGtto/F21AAlDXOzxC7C1QvXYIlZ36NQe+vGB+BUVjso11E3vrqydL+pFeqA==
X-Received: by 10.157.36.41 with SMTP id p38mr1928646ota.191.1515024133680;
        Wed, 03 Jan 2018 16:02:13 -0800 (PST)
Received: from [192.168.1.14] (cpe-70-114-157-146.austin.res.rr.com. [70.114.157.146])
        by smtp.gmail.com with ESMTPSA id m40sm950496otb.79.2018.01.03.16.02.13
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jan 2018 16:02:13 -0800 (PST)
To:     git@vger.kernel.org
From:   Jalus Bilieyich <countolaf17@gmail.com>
Message-ID: <caa3450a-2926-3339-f26e-d54714b005b6@gmail.com>
Date:   Wed, 3 Jan 2018 18:02:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

