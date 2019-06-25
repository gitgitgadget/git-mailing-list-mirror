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
	by dcvr.yhbt.net (Postfix) with ESMTP id 09CE31F461
	for <e@80x24.org>; Tue, 25 Jun 2019 14:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731978AbfFYOtq (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 10:49:46 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33243 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731429AbfFYOto (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 10:49:44 -0400
Received: by mail-ed1-f65.google.com with SMTP id i11so27598066edq.0
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 07:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qcyS8YGsoGXGwJUmX0IUCggwXAEadBUw1CFX8LLJFY4=;
        b=l8fz4/dArNDmnmzzG5VhqbWbRgI3gAQY1y1FCKNr5RTQ4hygPLBBkMecvdUD5+okhq
         cDOGBvemrLKpPKLR2depV5X71B9/NkS4lrY/2arkKKAVG2U+DvthTwNwRcdjpNSXPRQ0
         nTB3IV/wu+ky7WSmZsy9GQLhT57rqwhylm0INs++zy4h9OD/SEGHd3UKehLZBRPDPOh3
         kjwaVPOdBUMw8tBHdScQ6RQkoLFp9wTYkybuS3Gktz/QjHI/xW4Lp4llzEpZLH/BSXVg
         8wlil4iTHg2JPxEXtlo/zeFtJpfgBVmU/SK66fmpj2Zv4gWiiaMeqf1AhsmdzfUbXyq2
         gywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qcyS8YGsoGXGwJUmX0IUCggwXAEadBUw1CFX8LLJFY4=;
        b=ZrlF2Q4iO9T38Ikqev4SfV73clD37cGAaNLItMryzlfkHBfX3xozQXcXqiYAkIadDs
         MxmJJivpYCQz6wXyiE49twG3qXqMGn3mQe0Qpgq6T83JBXuk6RWQEiFRe+lsUm29tT6f
         EJzXi4P889j4DbcNZ8wGCaT0JSvtYVfgGMt+cCdSyncGdewL39beAwDVp5+W5JRq5JSL
         z32HOlWHZVLx+spmgUlCWU+WhmkIKGK5nGnpPhiVWdfDXdnHSjhF7C6gkkCHByZbwavN
         Z3CQpPrTJXEfF3MKkGUNsISyOu9qpo1D0FhZQubOd+CPDeHChrjXZjz1oo68WfODCxBb
         VI6g==
X-Gm-Message-State: APjAAAVUDeVTALE9B3WNB17kkWIfyZsy5gBimZ4/0xSwihojkaEQSJ7h
        WvyIsmVEBHzOxqZ2VO7zZ0ot/5nA
X-Google-Smtp-Source: APXvYqwivR76FWkaNovuEl0nBZGM8g6aCwDilJ6E/hbRGRuwB1mC1yND4zP/FtPCbjJNQprabS4SmA==
X-Received: by 2002:a50:a5ec:: with SMTP id b41mr141633774edc.52.1561474182485;
        Tue, 25 Jun 2019 07:49:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k20sm2844193ede.66.2019.06.25.07.49.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 07:49:42 -0700 (PDT)
Date:   Tue, 25 Jun 2019 07:49:42 -0700 (PDT)
X-Google-Original-Date: Tue, 25 Jun 2019 14:49:25 GMT
Message-Id: <7cb0434fac0cd73bd624571f90eed77e93181858.1561474167.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.149.v3.git.gitgitgadget@gmail.com>
References: <pull.149.v2.git.gitgitgadget@gmail.com>
        <pull.149.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 19/20] msvc: avoid debug assertion windows in Debug Mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

For regular debugging, it is pretty helpful when a debug assertion in a
running application triggers a window that offers to start the debugger.

However, when running the test suite, it is not so helpful, in
particular when the debug assertions are then suppressed anyway because
we disable the invalid parameter checking (via invalidcontinue.obj, see
the comment in config.mak.uname about that object for more information).

So let's simply disable that window in Debug Mode (it is already
disabled in Release Mode).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index d01e88c2f8..433838391f 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2437,6 +2437,10 @@ int wmain(int argc, const wchar_t **wargv)
 	trace2_initialize_clock();
 
 #ifdef _MSC_VER
+#ifdef _DEBUG
+	_CrtSetReportMode(_CRT_ASSERT, _CRTDBG_MODE_DEBUG);
+#endif
+
 #ifdef USE_MSVC_CRTDBG
 	_CrtSetDbgFlag(_CRTDBG_ALLOC_MEM_DF | _CRTDBG_LEAK_CHECK_DF);
 #endif
-- 
gitgitgadget

