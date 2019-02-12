Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F9831F453
	for <e@80x24.org>; Tue, 12 Feb 2019 12:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbfBLMJ1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 07:09:27 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38285 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729344AbfBLMJ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 07:09:26 -0500
Received: by mail-wm1-f66.google.com with SMTP id v26so2752982wmh.3
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 04:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=filenko-ms.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version;
        bh=L736P+LsD7+VmXYUYTdKS5IGzN+ogxmVqlxcmNB9/Bc=;
        b=uquPvYqq1fq66988IOT76LLLR6LaFeKD/+NQQcqgx1U509fjUeCA2Efyd+HTgsq8oC
         l126OIACy6YdaRtMfMXBHRVpcJ7x/OCJQUH7ojfKTlJ+rEPhFtL5BgFK4Rkqm4mdV/Ve
         j4zlfvezN7qSB4tonCTwD+4aYXvtcFvZBl/9ZNtxQ656nrzTphoNs5ApcUfl3wys9GKg
         1USJSsMQ2bzZyH+4h+P5WKeCb7BCfkM43x3HsD0uZmw5g3c2ajGynLt0iTwjyWMV0y1H
         TEzvgStsH8pZ7MXUPUMT0Cb0PgATr/vMg3m7jVvRz2AaFDLrfbU9fBJIX7E5Qh7NewA9
         P+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version;
        bh=L736P+LsD7+VmXYUYTdKS5IGzN+ogxmVqlxcmNB9/Bc=;
        b=kKmhM1wMOaiWRjrLVSVwa3ie647kNKPTZrjtLkrROWKpyXUgaCjim8kSR+ef/7JyjK
         xAkDWfhL1hcnaJ0OPXxTvrTkJG2UPtlu1ugNKw2RW5xSqbYj4DrlSz+Fl/vY9bNDC2aj
         2X5/PxPbUmWxlz1aNpWZK/c43I8coCo2nQh2kVagB/cWe+KN5cvkWuh+gGbGz2nGKQFb
         jict1ue6309QrDTvq6ZqpmvCO9nFd+41ol0AW8bglorQNCHlU2jxGd567J3tBRYP6vqY
         326zcciZRlxse1U8WJPbBmvSAEBWY3/AfHXLeIWMVs+2ZceCrkP08j/vHrfgwr1gVtbv
         VbBQ==
X-Gm-Message-State: AHQUAuaoyNGKClDnzn009qkzlZsjesfUJIWyhgy+MTsMEBhIr9pTiY82
        3uVHS67AQ0cs5+QIdPhFtmaJZS/ZH7ckbw==
X-Google-Smtp-Source: AHgI3IaWws5NBnEjhdcYiHv0ay9F4jVzwmF1u0U975vgJmR2RrULz2x2+MD6loLoQ6ONopufvgOX/A==
X-Received: by 2002:a1c:4155:: with SMTP id o82mr2598652wma.122.1549973364855;
        Tue, 12 Feb 2019 04:09:24 -0800 (PST)
Received: from bouncer ([213.61.81.99])
        by smtp.gmail.com with ESMTPSA id t17sm1172817wmj.19.2019.02.12.04.09.23
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 04:09:23 -0800 (PST)
From:   Max Filenko <contact@filenko.ms>
To:     git@vger.kernel.org
Subject: Re: git-am drops colons in the beginning of a subject line
Date:   Tue, 12 Feb 2019 13:09:18 +0100
Message-ID: <m236ot5hu9.fsf@filenko.ms>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tested with the following versions of git:

* git version 2.17.2 (Apple Git-113) (macOS 10.14.3)
* git version 2.17.1 (Ubuntu 18.04.2 LTS)

--
Best,
Max
