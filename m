Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55CF71F453
	for <e@80x24.org>; Fri, 15 Feb 2019 15:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388328AbfBOPRs (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Feb 2019 10:17:48 -0500
Received: from mail-ed1-f48.google.com ([209.85.208.48]:40601 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727663AbfBOPRr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Feb 2019 10:17:47 -0500
Received: by mail-ed1-f48.google.com with SMTP id 10so8232782eds.7
        for <git@vger.kernel.org>; Fri, 15 Feb 2019 07:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XzeZq3gq8WGl2hRdYJqhyhitVVjz5yLNr6r9iTU5o6Y=;
        b=Zd+R2ayuzRSOnFUDcSv7tFfPOH40NnFbeFvMxW0+TBm4BCUfheNsrFYvz6hG7LQY3y
         eWgQ0IOrZNEux0V8vJZ8CZ7LAjg+pNPJcVWkpzuZgKlFIGRSahHrI1TSj5tfdrYPsmBO
         yLRFGYjlZhbefc/b0eI35aIv+YT87fuCpj7ePKZXWq2Sdo7EXS/ZkRIwpjKT7cVinGPz
         tRK1NV06NvooD2GPZG0huN7nS8oFp7bpFBtKQMTmgEaA+kxyWA7Ix2OaoL+Y+pGY3t8F
         aa4pXsCpDoPUic5jQhq5kxNDm2B97iANbXXq6Bf3Nq24/olKmXlT1BXP3UBlDKVns2ky
         ZZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XzeZq3gq8WGl2hRdYJqhyhitVVjz5yLNr6r9iTU5o6Y=;
        b=FdGyCobgkbG/kmFbajTPPqxlHTkcQZ1b6Y85HlRcVKOJiNCdE3qO1SiV5c8lEAnP16
         dAD8EVs0M99mTRECGxO6NrUsjNLLbUXvZCtEwEHHSxqawI7hb15M19ennqsX6lC9m4NN
         kmsav4dbGRQoNV8TNvOud6O8/ANmzU38PiHx+UiwSGxt0oAVpJlpugljSgCm6IA+a+9L
         kIfNUmr1R52/0Al8phb1T8aP/WtkF3KZkn5aiiOH3m+rSZ4hHd3qbCk64H+2IZ2DQMDc
         M0jmAZAyldQCi65bU1YNuNLIdSiXIzHG1GUgwuyNpKUpC9NgnBaHabo2IkBk+XjF9tCA
         qbmg==
X-Gm-Message-State: AHQUAube/b89JjNJyWXF58d6QVq9i0FP7WPIan6pafJ+kiccdwxrKsVv
        3l1D4VBXlt+cpgWxipoEr+evwejO
X-Google-Smtp-Source: AHgI3IY1s4ChxAokdgWrBssAOZ05khZGKGsrRHcc9fb45rYqfxEv/7Y2WwyrA+zrDFyOVlLWBRQEhw==
X-Received: by 2002:a17:906:2a98:: with SMTP id l24mr610645eje.175.1550243865806;
        Fri, 15 Feb 2019 07:17:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m14sm1665764edc.27.2019.02.15.07.17.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 07:17:45 -0800 (PST)
Date:   Fri, 15 Feb 2019 07:17:45 -0800 (PST)
X-Google-Original-Date: Fri, 15 Feb 2019 15:17:43 GMT
Message-Id: <53e3d159c8c80924188f57c44efd2170612f2ee5.1550243863.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.127.git.gitgitgadget@gmail.com>
References: <pull.127.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] mingw: safe-guard a bit more against getenv() problems
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Running up to v2.21.0, we fixed two bugs that were made prominent by the
Windows-specific change to retain copies of only the 30 latest getenv()
calls' returned strings, invalidating any copies of previous getenv()
calls' return values.

While this really shines a light onto bugs of the form where we hold
onto getenv()'s return values without copying them, it is also a real
problem for users.

And even if Jeff King's patches merged via 773e408881 (Merge branch
'jk/save-getenv-result', 2019-01-29) provide further work on that front,
we are far from done. Just one example: on Windows, we unset environment
variables when spawning new processes, which potentially invalidates
strings that were previously obtained via getenv(), and therefore we
have to duplicate environment values that are somehow involved in
spawning new processes (e.g. GIT_MAN_VIEWER in show_man_page()).

We do not have a chance to investigate, let address, all of those issues
in time for v2.21.0, so let's at least help Windows users by increasing
the number of getenv() calls' return values that are kept valid. The
number 64 was determined by looking at the average number of getenv()
calls per process in the entire test suite run on Windows (which is
around 40) and then adding a bit for good measure. And it is a power of
two (which would have hit yesterday's theme perfectly).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 4276297595..8141f77189 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1632,7 +1632,7 @@ int mingw_kill(pid_t pid, int sig)
  */
 char *mingw_getenv(const char *name)
 {
-#define GETENV_MAX_RETAIN 30
+#define GETENV_MAX_RETAIN 64
 	static char *values[GETENV_MAX_RETAIN];
 	static int value_counter;
 	int len_key, len_value;
-- 
gitgitgadget
