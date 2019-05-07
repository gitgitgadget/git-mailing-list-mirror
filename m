Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 249061F45F
	for <e@80x24.org>; Tue,  7 May 2019 21:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbfEGVvc (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 17:51:32 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33513 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728452AbfEGVvc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 17:51:32 -0400
Received: by mail-ed1-f65.google.com with SMTP id n17so20156654edb.0
        for <git@vger.kernel.org>; Tue, 07 May 2019 14:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YDqMJ8axelYJYKUTAKADqLvbCr1lgX+icsU5nNLqgbo=;
        b=muPVmHMOvKHOr+1wt6WSZRn9L0ueFDvMJhJCK0md2y0xMhPblsOe4lTRAzG8CnXHqV
         nZ5/LtTH69LcrgDBKYNi5duH2OTYixmADl0KDrT5jLZwZupN2NxB8qDah2ZKxezqK5AW
         NgYNSbVQY5U+1NOrzSOGNFWFHTLtMEQpfFrGtsnD6tRlJJJC2oRnkA9WHOeh17ZfzUOS
         e1f+siE5yfrEvQDeESZprfpP3+fN8YB8/H+qlHrXi5gOoV2xXTXybXFYnJGcM/kAMG85
         /7TiXwvIAgbRp6TsXDRqaN1aFRNY0KtrXidAYYwXmONLOMFbqqR/SBUjKyzROBqp2bTy
         84Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YDqMJ8axelYJYKUTAKADqLvbCr1lgX+icsU5nNLqgbo=;
        b=My9yCJNyIGlGTrpC7bEUj+HcQSkDlgpGLjmaXAkNmNgcI2P3N249iv4dFXt4/qKixC
         KvkalTEVsiYyFexXl70SBZ2YKl9wCzz+Yssxa4vdURWlmkIUjHXrHydMigo9q9rj0d0M
         sNpaFrLo+nQCZF4aR+JnWmITYbEI59Lfz0yGRd+QxKzfBm1++v5AUH2XAgNrUGRfzcUb
         5zbzy9soCvqSxU5Gem6qjLjIQdnjsTMdqU3YlV1Lkc33PixRYQig7ghrtAfzZvVngwkF
         iXTv29Y1Xns8HfCYC7W5pLPL0S9syQlZyTKGCCxSfzO2SfaYpXdT+iCr7pmNN7a/iTvv
         5Z6g==
X-Gm-Message-State: APjAAAXg33pgjpzRaOQNtf0DM4h1YevusOTC2HFew7eGbLaOvq5QSYNy
        plY9Lz4qdEMVIWxSvUUI3YXt92rd
X-Google-Smtp-Source: APXvYqwW/I9riYOMz+Tg10AREWT2J1y/uk9DVx6pFNkvhb6eoRk/dPvhQUy6XHOjhyVg3fvwdJBf9A==
X-Received: by 2002:aa7:c387:: with SMTP id k7mr35641570edq.73.1557265890703;
        Tue, 07 May 2019 14:51:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s53sm4553231edb.20.2019.05.07.14.51.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 14:51:30 -0700 (PDT)
Date:   Tue, 07 May 2019 14:51:30 -0700 (PDT)
X-Google-Original-Date: Tue, 07 May 2019 21:51:28 GMT
Message-Id: <ba78a47b873c5f044cbfb147b30a801cc90fb0ac.1557265888.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.185.git.gitgitgadget@gmail.com>
References: <pull.185.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] t6500(mingw): use the Windows PID of the shell
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

In Git for Windows, we use the MSYS2 Bash which inherits a non-standard
PID model from Cygwin's POSIX emulation layer: every MSYS2 process has a
regular Windows PID, and in addition it has an MSYS2 PID (which
corresponds to a shadow process that emulates Unix-style signal
handling).

With the upgrade to the MSYS2 runtime v3.x, this shadow process cannot
be accessed via `OpenProcess()` any longer, and therefore t6500 thought
incorrectly that the process referenced in `gc.pid` (which is not
actually a real `gc` process in this context, but the current shell) no
longer exists.

Let's fix this by making sure that the Windows PID is written into
`gc.pid` in this test script soo that `git.exe` is able to understand
that that process does indeed still exist.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t6500-gc.sh | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 4684d06552..53258d45a1 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -162,7 +162,15 @@ test_expect_success 'background auto gc respects lock for all operations' '
 	# now fake a concurrent gc that holds the lock; we can use our
 	# shell pid so that it looks valid.
 	hostname=$(hostname || echo unknown) &&
-	printf "$$ %s" "$hostname" >.git/gc.pid &&
+	shell_pid=$$ &&
+	if test_have_prereq MINGW && test -f /proc/$shell_pid/winpid
+	then
+		# In Git for Windows, Bash (actually, the MSYS2 runtime) has a
+		# different idea of PIDs than git.exe (actually Windows). Use
+		# the Windows PID in this case.
+		shell_pid=$(cat /proc/$shell_pid/winpid)
+	fi &&
+	printf "%d %s" "$shell_pid" "$hostname" >.git/gc.pid &&
 
 	# our gc should exit zero without doing anything
 	run_and_wait_for_auto_gc &&
-- 
gitgitgadget
