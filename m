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
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EDB61F462
	for <e@80x24.org>; Tue, 18 Jun 2019 12:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbfFRMYM (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 08:24:12 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43656 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729187AbfFRMYI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 08:24:08 -0400
Received: by mail-ed1-f67.google.com with SMTP id e3so21384633edr.10
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 05:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Khfew/OXzD7xuIjjdfL9xgXFy84P1RygjEAg14OfJfk=;
        b=XVEvEUKSnJI2GtnamyT4DRhFbvXupphVFpS3AfHeXDL4hPOV0CrnfeLbrEHAWpn6Tk
         yMVkGrCspDI4SIX7/R+f1WErdqmkB88eeEMPgwKiMHj3aVP+P3zbgF3EHMz8XwpqyrKU
         t4nnXTpXGxHUkNK8Hpr+Ui93H9OtLQaeQ1aEFXNpHWrMBp3rVzScEPVrLP1vG9T2WAnz
         B7WQKskrfGsLPUjt9zf9ujXXfz4fTYGPoqh9c+tNbYrRB5lcKUElLq67dj+lhU20ArKk
         Dyl9nWDK6Xh0B2/wjEvUGvV5pyI5EJjlYdHtn4rnmoG53CqJjVyPw8/qV7FZxcI4vbjV
         0jgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Khfew/OXzD7xuIjjdfL9xgXFy84P1RygjEAg14OfJfk=;
        b=M2zvw6s3ztU2UQ+3nEbr2aE4TEL+P1E0ZJ1QX54G2oUQHr+cd+eY9+NuXerAGM7qxm
         Wht/EcxpwYcrhHFiHhemiZt9oR0MX8vgtjoWpU5fKrORp6WEbpzC8nlLhmUe/Mim5NgL
         E4SgN8gvy8wIp+PrsMIv+kxRAraWqB4816EH3dmHfoRLgDkQlsYjCMMZWvxdWVAIGmso
         icCZ6PX6SjnY02/Sd5ZZJYaxODXRsaVhWWzhtKqdSVGhRPKeky5BDqlcSOfZXAa8YqFi
         n+iMlS7wZ/2X6dbYL7+5meTWn+6h5rV2kFLhddKx2nfAsIVBcLWy2friqfhyDjUifcnc
         pgxQ==
X-Gm-Message-State: APjAAAU+zKev9AJA+ckLOQmKbMI19C7K6tBkQqCeptll356Y9AzOM2vh
        VeYTFkRptkOeUPXco4W6UkzqSIrT
X-Google-Smtp-Source: APXvYqzRWoy8QvbCBsnh/jOw+okhc4uPArDg59JDxpyCiddg70UPzlsbAqr38OnHdmOemQ4KvzzCPg==
X-Received: by 2002:aa7:d30d:: with SMTP id p13mr42774320edq.292.1560860646448;
        Tue, 18 Jun 2019 05:24:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r12sm4696231eda.39.2019.06.18.05.24.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 05:24:05 -0700 (PDT)
Date:   Tue, 18 Jun 2019 05:24:05 -0700 (PDT)
X-Google-Original-Date: Tue, 18 Jun 2019 12:23:52 GMT
Message-Id: <1491ea4140518d76d4619fa2da7ec20250da1404.1560860634.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.149.git.gitgitgadget@gmail.com>
References: <pull.149.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 15/17] msvc: do not pretend to support all signals
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

This special-cases various signals that are not supported on Windows,
such as SIGPIPE. These cause the UCRT to throw asserts (at least in
debug mode).

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index 667285887a..8b56aa5773 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2119,8 +2119,34 @@ int mingw_raise(int sig)
 			sigint_fn(SIGINT);
 		return 0;
 
+#if defined(_MSC_VER)
+		/*
+		 * <signal.h> in the CRT defines 8 signals as being
+		 * supported on the platform.  Anything else causes
+		 * an "Invalid signal or error" (which in DEBUG builds
+		 * causes the Abort/Retry/Ignore dialog).  We by-pass
+		 * the CRT for things we already know will fail.
+		 */
+		/*case SIGINT:*/
+	case SIGILL:
+	case SIGFPE:
+	case SIGSEGV:
+	case SIGTERM:
+	case SIGBREAK:
+	case SIGABRT:
+	case SIGABRT_COMPAT:
+		return raise(sig);
+	default:
+		errno = EINVAL;
+		return -1;
+
+#else
+
 	default:
 		return raise(sig);
+
+#endif
+
 	}
 }
 
-- 
gitgitgadget

