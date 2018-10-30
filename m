Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06CB11F453
	for <e@80x24.org>; Tue, 30 Oct 2018 18:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbeJaDjV (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 23:39:21 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43843 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbeJaDjV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 23:39:21 -0400
Received: by mail-pf1-f194.google.com with SMTP id h4-v6so6282656pfi.10
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 11:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=B1muZJLXhvelHiPpPdv76zdH+wOKsWat6752OKy4rI8=;
        b=qk0/PJBcpvNoGUnzBNDM153esFkSnWUbNmSCnfr8shQHsCHm7Xta19UoHdnIU30POj
         v1lQ4D1g6q0/DQclBrWkmfezTt5kZTuHcUqmHK78pzHpG16w2IxMJUdo71yqXUrotGZN
         eR7RdULswKvbCbvPzge9GHvlkpnGsccji7SkbZ5n2Fi+PJJ8HWDWgwh6RrmmMTjFgvmq
         iE0yMXFmbqfbcaAHeaUI4of+qvK8wjSalqh/pYWZMFNLZqRmIvr4ZuNdlMrRJq/NQ1Gh
         civoO+ISz9JLVHpM0pPkd5yg6x2eBZDvjOuktBpJJSkZ2acpyWh+3RHRN+NdvVlphjA3
         qq1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=B1muZJLXhvelHiPpPdv76zdH+wOKsWat6752OKy4rI8=;
        b=nC9586EVQhtVfLRXlSJx6BqDZ/tVeWtMTpvAZEL3nL6NmBrHpYo/kms3V5A+245g6s
         mrE+0IrL6PM2ddTPXzCenVEmKW1M0gHwH7Zhn8FwxBjFz4f58tKKxWnN3yR9DTbYupx9
         etyKJevBkAmZtgCoRQ4F6ZzmhTcnh+/9+pmEKa/jG2EVs+ZkZ5fe3qrPeCBEq9A9NCqG
         ypNh5DMfrNuPYVwuFB7q077qGEHxtD22xFse1oJ+Y3HzDyIaM1IRXGApggTmGO8Xp/Le
         gVHL5kuPRJ02VzQiuZvrrS4miBZvZLHnEPXqneR13BTIGEupt8r974r0NVRwKMlrsAh/
         dkkQ==
X-Gm-Message-State: AGRZ1gLFnc5T4SS8BjxytqQwnUoIaTd+ZTrxSJyCtmcR8BR8iEWMPOGE
        MTedF3kSNT46vLbOPlX9If27F5D3
X-Google-Smtp-Source: AJdET5efspKcr4+9q4cGSui3F5lidrE+YreNNJ0UQvKg4yy+w5MGzIDdRm39p6XU3gcVhc/D1A0yww==
X-Received: by 2002:a62:c60a:: with SMTP id m10-v6mr4201468pfg.15.1540925081488;
        Tue, 30 Oct 2018 11:44:41 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id h17-v6sm3202370pfj.125.2018.10.30.11.44.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 11:44:40 -0700 (PDT)
Date:   Tue, 30 Oct 2018 11:44:40 -0700 (PDT)
X-Google-Original-Date: Tue, 30 Oct 2018 18:44:37 GMT
Message-Id: <dbea6293c72d7f94fd6114a8de3b0b9a7fa09bba.1540925078.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.61.git.gitgitgadget@gmail.com>
References: <pull.61.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] mingw: fix isatty() after dup2()
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

Since a9b8a09c3c30 (mingw: replace isatty() hack, 2016-12-22), we handle
isatty() by special-casing the stdin/stdout/stderr file descriptors,
caching the return value. However, we missed the case where dup2()
overrides the respective file descriptor.

That poses a problem e.g. where the `show` builtin asks for a pager very
early, the `setup_pager()` function sets the pager depending on the
return value of `isatty()` and then redirects stdout. Subsequently,
`cmd_log_init_finish()` calls `setup_pager()` *again*. What should
happen now is that `isatty()` reports that stdout is *not* a TTY and
consequently stdout should be left alone.

Let's override dup2() to handle this appropriately.

This fixes https://github.com/git-for-windows/git/issues/1077

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.h   |  3 +++
 compat/winansi.c | 12 ++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/compat/mingw.h b/compat/mingw.h
index f31dcff2b..b04556ce0 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -390,6 +390,9 @@ int mingw_raise(int sig);
 int winansi_isatty(int fd);
 #define isatty winansi_isatty
 
+int winansi_dup2(int oldfd, int newfd);
+#define dup2 winansi_dup2
+
 void winansi_init(void);
 HANDLE winansi_get_osfhandle(int fd);
 
diff --git a/compat/winansi.c b/compat/winansi.c
index a11a0f16d..f4f08237f 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -474,6 +474,18 @@ static void die_lasterr(const char *fmt, ...)
 	va_end(params);
 }
 
+#undef dup2
+int winansi_dup2(int oldfd, int newfd)
+{
+	int ret = dup2(oldfd, newfd);
+
+	if (!ret && newfd >= 0 && newfd <= 2)
+		fd_is_interactive[newfd] = oldfd < 0 || oldfd > 2 ?
+			0 : fd_is_interactive[oldfd];
+
+	return ret;
+}
+
 static HANDLE duplicate_handle(HANDLE hnd)
 {
 	HANDLE hresult, hproc = GetCurrentProcess();
-- 
gitgitgadget
