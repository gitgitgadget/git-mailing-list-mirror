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
	by dcvr.yhbt.net (Postfix) with ESMTP id 24C1E1F462
	for <e@80x24.org>; Wed, 19 Jun 2019 21:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730574AbfFSVGI (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 17:06:08 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41659 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730461AbfFSVGF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 17:06:05 -0400
Received: by mail-ed1-f65.google.com with SMTP id p15so1263422eds.8
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 14:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wuS2WA7Jif5QUvj7Fml1sgZWSEjo5/eKfDep4R9AnUE=;
        b=uZb1xiPLJ6pOcDFKyOiE97NR1HVevPs+adAM+by0GWp8d0RLEz+EmR+7BXJ1wEa4gF
         UxAQvu/igDG3D0U1RRhIqGHlhMq91pgWr0Od+NIyEyLb49/gLfRuw+whnqXu985cbFJN
         VI+9y1bg8x7I0+BehxVi+nxOBIoz8a8LDrw82kgLMf/mWCFC38FcZ4T9qnF+8HBCPX9J
         Jy13FIgL4DZRzRIFhRJZ01VtgI7LcAFpCIasoS8piBADKOZMnQIrHjcvHge3TMXPjGdN
         QVl9KxSs8JY/i9oSIN2qPWfXXEtTUQt1EEy4F4x0uCvl7rW8T1YgZLCh/dMxXi9p/GQi
         b7kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wuS2WA7Jif5QUvj7Fml1sgZWSEjo5/eKfDep4R9AnUE=;
        b=K3OarYWiN5NuOcHSNmAmA1Gdii+ybomsB89OKjUtcTMZE3p4UpMlPBCd4FvmrK9i8O
         eIZrpTSlITm9jdcA2h2QuJBLIYhSqAKl5mc7LNoviQFl39Ngx7qhd/TGuHBdocN9VBEZ
         i+2mpgf1/sSuK0/uZxhOB8UV0sHs2lE2qgpRnW7TJWlAvM99D9rRKfaL3HakRwAgNBjo
         ihUGkKePuGddVHlAHq6U9uxi+mOTpXptdezrxaGdqTQNus+4xw/ZEBG15iuyHAZgIjKS
         Ej4bwEuR/EcW2/da5DTH9vcwtQPJ8auRjtn6MH/H9ze/09xtnvZxIcnxD7MQPrXNKomn
         mlvQ==
X-Gm-Message-State: APjAAAXmlL/wTjs7KXIulAtZJ1CTFLirIpBTMrn3qPN25xlcoICE6Ui9
        F29PM7rsVClc4DFvLJoFTHbv/JyS
X-Google-Smtp-Source: APXvYqxAYEYIEZUog+uxVAFln/ZHetiakTqp8RUfexc4dtUhuaruw/CYChPTxt7bmkGvdKgGQ6rTtg==
X-Received: by 2002:a17:906:a2d2:: with SMTP id by18mr46703318ejb.245.1560978363163;
        Wed, 19 Jun 2019 14:06:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x4sm6197876eda.22.2019.06.19.14.06.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 14:06:02 -0700 (PDT)
Date:   Wed, 19 Jun 2019 14:06:02 -0700 (PDT)
X-Google-Original-Date: Wed, 19 Jun 2019 21:05:44 GMT
Message-Id: <1542e8abe5c40b6ebae5924e5912523a0f4aa4a1.1560978354.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.149.v2.git.gitgitgadget@gmail.com>
References: <pull.149.git.gitgitgadget@gmail.com>
        <pull.149.v2.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 10/20] msvc: mark a variable as non-const
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

