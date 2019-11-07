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
	by dcvr.yhbt.net (Postfix) with ESMTP id 39FD81F454
	for <e@80x24.org>; Thu,  7 Nov 2019 08:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfKGIKG (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 03:10:06 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45388 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfKGIKG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 03:10:06 -0500
Received: by mail-wr1-f68.google.com with SMTP id h3so1838027wrx.12
        for <git@vger.kernel.org>; Thu, 07 Nov 2019 00:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PfCdk5wYQTQpMIFirJG8Uju/RA7osRUcMqmECKzKWEE=;
        b=OBTlqszfsiySdQfTQ2zPm2xOeZ72A/ddKeddp/1EqZc0WejggYDMcZtOdsSXqd4XJo
         Dp7+/uLsjei7NqJQTRRAvE/krb42BHDl5fhaMXNo10oYv+SalIznumtyUfOiLPuCjf6I
         1zxrNRE8KKrJZKo4Ilh5e+es0qYuZHX3rzcTn19/Gvbfhx2avXYSpEWdKRrulF2+1oXo
         3jDTQeFLDeLA+KtcT5ZPRtd3W3UWE+8DYHipsbRY2y8G1/cqu95egQDeJqeZG4+Sjo8g
         D8NiXN/ZlFgEeDDQsQqFoLbLrLwAIFCpX65Mf9AhH0IHRGWsWXQ2IebLWX7L+2LzMrfg
         eoGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PfCdk5wYQTQpMIFirJG8Uju/RA7osRUcMqmECKzKWEE=;
        b=ri9X3nzqEBbif6HRdtm1PsY722UkdKXp/Yi2CaUhqIg+Zjp6zXhbEVWbQxDCt+xGGp
         pfQRGHEF6syOz5mraOGzUoUTC2NFE0tpM+YYADeTMO5ZvsHG2TBlF5GOQA55i0zr3ALe
         RnfS6JEuUaI5UVKzZThtkVJTRe0hc6cBVExzGY/0kvoEZ6ly10iJ7Eq53DL8vJDHyy+3
         esOd49G1NhiGvwnPdL7OWg5G0axrIjTdYkDY1IhZCTGQmYzm658pjTWTwr5swdj5opY4
         LIcqtNa8zeP0+pTaCyzZ1/zEZOGW3Fs4dDc4vVcU1dsBb09e8POC6pMqw3GNPGe9QfT+
         oFVg==
X-Gm-Message-State: APjAAAVJUtRbS6Up6Wck8l/iiQeMOW702ZqJ4IeG/xv8Xozy8PKZ3CwL
        k3dDDJhQ0sUkVHjy/ul252o6JMR+
X-Google-Smtp-Source: APXvYqxw9q7KoemC7E0HFzxCgVIU25EhteeS+MDO0WXN3Id2+pXmMNeRHKvhfjuzlZQzoiT/1VcaGA==
X-Received: by 2002:adf:f651:: with SMTP id x17mr1668955wrp.114.1573114202871;
        Thu, 07 Nov 2019 00:10:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j67sm852429wmb.43.2019.11.07.00.10.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 00:10:02 -0800 (PST)
Message-Id: <5e3b370b3bf8f34cd975da41fb2a7cc0f633954a.1573114201.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.449.git.1573114201.gitgitgadget@gmail.com>
References: <pull.449.git.1573114201.gitgitgadget@gmail.com>
From:   "george espinoza via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Nov 2019 08:09:55 +0000
Subject: [PATCH 1/6] [Outreachy] merge-ours: include parse-option.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     George Espinoza <gespinoz2019@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        george espinoza <gespinoz2019@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: george espinoza <gespinoz2019@gmail.com>

Prepare this command which currently handles its own argv to use
parse-options instead. A lot of the commands already have
parse-options and in git.c cmd_struct with the "NO_PARSEOPT" are
the one's that still need it.

Signed-off-by: george espinoza <gespinoz2019@gmail.com>
---
 builtin/merge-ours.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/builtin/merge-ours.c b/builtin/merge-ours.c
index 4594507420..3980f4899a 100644
--- a/builtin/merge-ours.c
+++ b/builtin/merge-ours.c
@@ -11,6 +11,11 @@
 #include "git-compat-util.h"
 #include "builtin.h"
 #include "diff.h"
+#include "parse-options.h"
+
+/* parse-options.h added to initiate replacement of manual option parsing
+ * with parse-options. 
+ */
 
 static const char builtin_merge_ours_usage[] =
 	"git merge-ours <base>... -- HEAD <remote>...";
-- 
gitgitgadget

