Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_WEB shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB9201F453
	for <e@80x24.org>; Wed, 24 Oct 2018 12:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbeJXUkn (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 16:40:43 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:42947 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbeJXUkn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 16:40:43 -0400
Received: by mail-pf1-f169.google.com with SMTP id f26-v6so2307400pfn.9
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 05:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=k21Ww4Qs8lFqm6lgZQnIA3nAySWpEqKUB4DHumbOdAM=;
        b=sfyda/WdC3aYTlvQfwFtJBeQCs18dWvU92Zbkf0OdcmorAwtmQNHZDTOSO+oo4sEuS
         0V2ZsHzrxAk60ZvmvjddVP1cFopCpIsvg1SwQsYF0wMFsPVv19tEIVuv9w7FUOPCvzKZ
         j5rJY9CmhCMr0EL+wswtNiu2SZWJlLizCM1pa0PuM4vC9eavl1PeckucH1qiMlSatb6w
         XoBf8AqxyXaGJIpApHjLP3/K7pm6wsqkIintQM2rm4CACq3eqw492owGWRtnFx6yT+Vb
         m5u1FwITx4NkZp2E2yQdtRHUjatDuEgIIP1/rYicjWYz0fpZRpa+lpG5fNtZggc1Ebtx
         rO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=k21Ww4Qs8lFqm6lgZQnIA3nAySWpEqKUB4DHumbOdAM=;
        b=nkMNUtk3RbFG6BJiGaA8T6UArJzuCLxywOxAGI8fnghVRkvLVBl1cXHDlqP6jw0FEK
         DUq/dxPPJd+W5ZQB4RDWnEoCA8FhSO7d9kYAbNe0fbgdsNuKzPRC8pT3okJBc2w2a25W
         dFf7S7nrA1YteVw6U9JLa23TQmcAlW/AFVGmZ7PdhaQKO4wR78GiOj1mGr885j3RhgU2
         rUbHx9kPSgf7gTpF4aWXyvepWiZ0j68b5vxqFyeVVE8Mopy6VC/T5oYj2uopX0Yc8UVF
         /0cBGjAmLp6Kk9aWRQUIVUh+22CzWT2u/0YV9xc7X4xpXbMo542nz3yXYMvh2n/Zy/3r
         rZ7A==
X-Gm-Message-State: AGRZ1gKVaJVH9YVl67DdvBB8FhRoDVsYSTkIVkYtzv78nUvD7Wss9WSm
        6LIU+YUTvnBeeLxWAK2B6bOZAj1w
X-Google-Smtp-Source: AJdET5e7fr24T/9FbVK7MAOoOwmCVJ4LSJSdUJNllIaieZZu5u5ziCzbSt3y0MuAaFzS24gJJZPgUQ==
X-Received: by 2002:a62:a0e:: with SMTP id s14-v6mr2392170pfi.153.1540383170220;
        Wed, 24 Oct 2018 05:12:50 -0700 (PDT)
Received: from [192.168.1.116] ([113.22.74.217])
        by smtp.gmail.com with ESMTPSA id u79-v6sm7414090pfd.117.2018.10.24.05.12.49
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 05:12:49 -0700 (PDT)
To:     git@vger.kernel.org
From:   rk42_gg <hung.rocket42@gmail.com>
Subject: Translate ProGit v2 into vietnamese
Message-ID: <f0770ca7-9a1c-18ad-8d9e-7fb3faa20cad@gmail.com>
Date:   Wed, 24 Oct 2018 19:12:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git Developer,

I have started translating Pro Git v2 book into Vietnamese at 
https://github.com/rocket42/progit2-vi

Pls show me how to add it to "*Translations started for*" section in 
https://git-scm.com/book/en/v2

Thank you very much!

-- 


Full Name: Nguyễn Văn Hùng
Gmail/Skype/yahoo:hung.rocket42
Address: 259/35/2 Phú diễn street - Bắc Từ Liêm district- Hà Nội city
Mobile:+84986451381

