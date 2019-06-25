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
	by dcvr.yhbt.net (Postfix) with ESMTP id 6264C1F461
	for <e@80x24.org>; Tue, 25 Jun 2019 14:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731981AbfFYOtr (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 10:49:47 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:46252 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731914AbfFYOtm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 10:49:42 -0400
Received: by mail-ed1-f43.google.com with SMTP id d4so27489927edr.13
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 07:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7kDTvmNJzxuKVCuUEw2sUjOAOs9WzIM36vSbnY3v/YM=;
        b=s7dVonolahk4wExvloPlYVEhkXa+WJwhlguVU3jlAvj4FEZdmBs64k6fyfI0nJS+GN
         aYAafkAioiBCKFFvTIMgWnPb0jIf9LzXhPlOjRlqTtnAzLfKS2Lx5+YnvsgQFKSHvG3j
         hICZZDukMqtUBABMrby9AhwqRnxi1N3+4B4isDLrZBlulHjVBKkZbB+W7gIQ9xCviSR9
         WNuZteX196OtSNJSJaRlFTnSDJvbXn7E6+yBk14W5hzCfgdVnFjH04UvSl3MaIYyekxl
         MtAA/KincZfZKezA/bZqyYgn3QZUVTEykRDQ5B+uNNpVcRDH74BqNh+sSmUKZPw2a1un
         GbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7kDTvmNJzxuKVCuUEw2sUjOAOs9WzIM36vSbnY3v/YM=;
        b=Zwlb0DXCWbUMYDE/DSk8AZhskOj0vl21YvSkNEDetsY8qPqt6CRNPP17ULAXms/DON
         IS2EJD1ZagRVccvrLx0es2BixhCSx+l3fcsHAq11zngTV/9QMLFn06Tiks3hSPN70VaQ
         0GSKiMc6EO6iQ+Q3bB1CswACVRacvHYia+6JBhDUwdVd0DJOqPwZ143Gi+x7/4LKysfF
         cEBJww1tQq7RU1pBxO3TcC7hUnWIk7AV4xM6v+U7o1zYFR8+iH7XSznglUC6WukcCqb2
         Sh4tQhhY6fKORH/AN9zgNlCYVK/v8D5uDgEdC3a0yngiCB9f+U96/VEpvv8X1EvBpwiW
         qH7Q==
X-Gm-Message-State: APjAAAUbM2GVG5y3niRzKYGnax3PphQzmrB98hsxQSX+17mcJGbKRxt0
        MAC3boeZvOtMEt4IqOkMQE2QAQ4o
X-Google-Smtp-Source: APXvYqyQCYSmAX19g3gsXgoeBpNjhQI8OI0JxFC8pru9y8lkjn0Ubx7Sa/kTAMFSPZffN20tpV1CGQ==
X-Received: by 2002:a50:878c:: with SMTP id a12mr51689321eda.142.1561474181230;
        Tue, 25 Jun 2019 07:49:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e10sm2455776ejx.89.2019.06.25.07.49.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 07:49:40 -0700 (PDT)
Date:   Tue, 25 Jun 2019 07:49:40 -0700 (PDT)
X-Google-Original-Date: Tue, 25 Jun 2019 14:49:23 GMT
Message-Id: <42f5b8cee8a850a68966de52bf0e588018bbf058.1561474167.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.149.v3.git.gitgitgadget@gmail.com>
References: <pull.149.v2.git.gitgitgadget@gmail.com>
        <pull.149.v3.git.gitgitgadget@gmail.com>
From:   "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 17/20] msvc: add pragmas for common warnings
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philip Oakley <philipoakley@iee.org>

MSVC can be overzealous about some warnings. Disable them.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/msvc.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/compat/msvc.h b/compat/msvc.h
index d7525cf61d..1d7a8c6145 100644
--- a/compat/msvc.h
+++ b/compat/msvc.h
@@ -6,6 +6,10 @@
 #include <malloc.h>
 #include <io.h>
 
+#pragma warning(disable: 4018) /* signed/unsigned comparison */
+#pragma warning(disable: 4244) /* type conversion, possible loss of data */
+#pragma warning(disable: 4090) /* 'function' : different 'const' qualifiers (ALLOC_GROW etc.)*/
+
 /* porting function */
 #define inline __inline
 #define __inline__ __inline
-- 
gitgitgadget

