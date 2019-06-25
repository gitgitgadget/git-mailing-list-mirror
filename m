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
	by dcvr.yhbt.net (Postfix) with ESMTP id 453AD1F461
	for <e@80x24.org>; Tue, 25 Jun 2019 14:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731879AbfFYOtk (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 10:49:40 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43961 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731280AbfFYOti (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 10:49:38 -0400
Received: by mail-ed1-f65.google.com with SMTP id e3so27492548edr.10
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 07:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wuS2WA7Jif5QUvj7Fml1sgZWSEjo5/eKfDep4R9AnUE=;
        b=AmCLBQ5VUzc9lHhTRjEo7dCh5ZlwgfCNZe+fCQLBtsY+2m4ltSN2Eb4+OjGYridZJR
         W/AaLLQALY4DXoAE6lSlaokbE5RZas5j5fs9xOjFCqRFDlEIwRqdvQyHXOAp1msSTr6W
         +FJtLYyzfM76KJ5TsyPJphL21wvKn54I2W3g032+eerRz5qrfHsti0ce0/DUdzaPxGni
         aL4yoD4n1KpBiA9xeOdTpmFSJE5DA5NDGyP2zA9CDP+T3+NfSZiMJBf+FL9LWpCsGMTU
         Mwb0TbbKzXSXOhQzpI0F7LQRF3PW5WZr8yDDGmj6GlFfgI4cSo8r3Hd4OObN9NYvGWrQ
         6NXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wuS2WA7Jif5QUvj7Fml1sgZWSEjo5/eKfDep4R9AnUE=;
        b=FoS+R34EndO6P4BKBDuav6BOi8UJGIqefH87gn+4ketkb5Yr+gUCsmE1RPgM0WifhJ
         4Wss1PWlereH1w34RCA7Mt/Zn92of8qCKvDfF+5qHqntkcLZ9apJWwt1l4eTRU8XIDRX
         28lm5yPXVNcGywq8mk9/RDCmELj6oU10PwOOYooIr5/3CzqJtwLO5Oa+FF7zi3cwdege
         oDUHfYatJT0Xf2eykt9SzbEzOX3MEnypwbfoIhVPsSZ/vTVN9wpv7mGPe4ILYxBbQ6aR
         6XMdnFf7Vaev0ASqlFMMfBqQaCma79VyJGublNTggAeztb9LRYg0mHTlGenZvFBM2YbP
         1Urw==
X-Gm-Message-State: APjAAAVEwlh2zlFo7XL6VtE/RGvXL9MbXdd43Zdv38cvmm/brAbsXppE
        yaS1X2cSffHqPQo+much4SiWi6Jq
X-Google-Smtp-Source: APXvYqxfjGTAjzPvNHMm83pu3iJLqnuZh/Ro98nC7oWk1PByMA/UibvhZmi4IR2vsIKP0Y/rx9L8BA==
X-Received: by 2002:a50:f486:: with SMTP id s6mr138012767edm.186.1561474176412;
        Tue, 25 Jun 2019 07:49:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t2sm4973846eda.95.2019.06.25.07.49.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 07:49:35 -0700 (PDT)
Date:   Tue, 25 Jun 2019 07:49:35 -0700 (PDT)
X-Google-Original-Date: Tue, 25 Jun 2019 14:49:16 GMT
Message-Id: <1542e8abe5c40b6ebae5924e5912523a0f4aa4a1.1561474167.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.149.v3.git.gitgitgadget@gmail.com>
References: <pull.149.v2.git.gitgitgadget@gmail.com>
        <pull.149.v3.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 10/20] msvc: mark a variable as non-const
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

VS2015 complains when using a const pointer in memcpy()/free().

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 0d8713e515..d14d33308d 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1553,7 +1553,10 @@ static int try_shell_exec(const char *cmd, char *const *argv)
 	if (prog) {
 		int exec_id;
 		int argc = 0;
-		const char **argv2;
+#ifndef _MSC_VER
+		const
+#endif
+		char **argv2;
 		while (argv[argc]) argc++;
 		ALLOC_ARRAY(argv2, argc + 1);
 		argv2[0] = (char *)cmd;	/* full path to the script file */
-- 
gitgitgadget

