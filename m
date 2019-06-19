Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 670751F462
	for <e@80x24.org>; Wed, 19 Jun 2019 21:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730634AbfFSVGQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 17:06:16 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40030 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730596AbfFSVGM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 17:06:12 -0400
Received: by mail-ed1-f66.google.com with SMTP id k8so1276160eds.7
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 14:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Lh8M4uuq6uxeqs7vyPbvNZQipnmzq/wt454JVAsQ5bo=;
        b=KhsN5H1jjghd3Oz312lUJibHPhullTYbw4tXPECElXhjHv/F1ws5jossLGyKcXqxAz
         2OB4xed1ccExDWragPkunA62yu6FF1eZVB1vfraTgRjMxb4dm0aMjZzclUJER1SfH7+U
         oaG8KS3sPn2wVCMHEZufcsA5NeTn76Lo8dG6BB3X39SCevivQRP6qXcOKdWVPHTrD9Yd
         K4AiT/jqtnIRX/QuItZHB07Z8Mjj8tnOiTQ+8VKjSo+ItdWJiPDvtWyO/Xb4VMYIM7nd
         KCkDkZ0TIj0eIBxdFQU9GYLpwWmtMw/8T2Xbz5QS7GIj+7KFDo4NY0ksD9Os3ZplfVZ8
         7VAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Lh8M4uuq6uxeqs7vyPbvNZQipnmzq/wt454JVAsQ5bo=;
        b=mFM2MhAUWEjVya2qSFxQKbm2tytJ8dehRNcy3grzE+NTC9h1/n5TjJdt3tCVywQrgZ
         F+4mGsa8b5Rkj/YhLLb/5AkFo0cNLgQ4urZlN46WFozTjEJrsTRmgsppxsiFf67IHbkO
         iDZ2+g66PE8rFjRl7YUnZSnM3JgjcoxEv9npn871MxbJKutFZRvjKkx1FnUVPD3npkI4
         b30GMZevlXjEsms/Im+Eb6Jjjn6wlRD+wwsYokbWIIb5MulvvlgmBayoL7XZ1N/tn3Iq
         9BVSTyIfjNhUEZgg0PeuwzuRWWradj2CXCIS/wODqiMrAzPyHo4J5XAYIGNixSNnixxK
         2YKw==
X-Gm-Message-State: APjAAAU+lNTWJ5PnALx/vt3FPhuEjzbtbPqqvjRAG6L/Z/s2ReSsKijy
        a1nC2ETNE9MTAW0gbei1WkCLcIih
X-Google-Smtp-Source: APXvYqzfIKAAANx+PwDNcI9wQr/Z9g+IxEvHzEHm159kOnJ1UgaHLsfvjfPFHarIyfcPFndcfwyLTg==
X-Received: by 2002:a17:906:b35a:: with SMTP id cd26mr11880377ejb.86.1560978370632;
        Wed, 19 Jun 2019 14:06:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v47sm1095502edc.80.2019.06.19.14.06.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 14:06:10 -0700 (PDT)
Date:   Wed, 19 Jun 2019 14:06:10 -0700 (PDT)
X-Google-Original-Date: Wed, 19 Jun 2019 21:05:54 GMT
Message-Id: <4d44d1fab18a3ed59d9fbea4f39ab9b6c1f03d3d.1560978354.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.149.v2.git.gitgitgadget@gmail.com>
References: <pull.149.git.gitgitgadget@gmail.com>
        <pull.149.v2.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 20/20] msvc: ignore .dll and incremental compile output
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Ignore .dll files copied into the top-level directory.
Ignore MSVC incremental compiler output files.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .gitignore | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/.gitignore b/.gitignore
index 2374f77a1a..ba0e52c4d1 100644
--- a/.gitignore
+++ b/.gitignore
@@ -226,6 +226,11 @@
 *.user
 *.idb
 *.pdb
+*.ilk
+*.iobj
+*.ipdb
+*.dll
+.vs/
 /Debug/
 /Release/
 *.dSYM
-- 
gitgitgadget
