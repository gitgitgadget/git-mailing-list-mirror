Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 536CF1F404
	for <e@80x24.org>; Fri,  7 Sep 2018 18:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbeIGXCB (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 19:02:01 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:42038 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbeIGXCA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 19:02:00 -0400
Received: by mail-pf1-f169.google.com with SMTP id l9-v6so7392364pff.9
        for <git@vger.kernel.org>; Fri, 07 Sep 2018 11:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pnwk0EoNTP+LwkEUQKM8wXdk0g0wfrt/l8GjPW1SAfw=;
        b=SKNhZO3TrE76v5b+RhkTujuXcfq/KjiFzOGO3gHtqrf8kCapbo3VL90pld2FrSqFLL
         HAgN/bGPKy3g4MqS0/GFFB7Vptca+sW6inPBFhTBwpGVA4PWKCrD+hgzyNJYLzMyzY4c
         VGBZNrwLNfr+93JjW9acTlhmwnzxnNejZyUcGrzGp1ht5/W8kdwsHf7LzNUi7mW8k5d+
         XA0ail3taJauYqucVntkTvVUIIEftWMBJt4Z18g8Wg5DCa9QGnVZtXk3qr9q2g5RjJkO
         vQ5CYr9Els1ERCszNglGNYO6zzO7MIGC8zSS+MJNkVATiw4W2QHWikMOQIQjZdwkzV9O
         x/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pnwk0EoNTP+LwkEUQKM8wXdk0g0wfrt/l8GjPW1SAfw=;
        b=tLgnhLLWUFeV+5U398gtSjApCVW6UqTw3nx0mWwPPkHU2rZSCnErkssJsOKMdmxtKd
         c9JTXER2/jE7appWtDhvYJkbqBNRGGuOCQh8NfMeg1lECzaYHF++t5ieI9Avw1XNiRqV
         BLqWiLr2Pm+qle5Y6gVm1hYYA3JYWJi37g62hivpVcwVjxLCiM4l0OYFhABKdUU9V/u2
         ncZc/hkJQ0xfjGzZnvujRwyu9VAi47I0PioWnkHj18+VNOqs+Dh603sYov5MGBxg/PAs
         PyJeaNTJ2N0R+3ugQdLC9cheFNlbjHKEPJG2wj3ts9abm7tqrfmWfcss3jBCBg+4V6cd
         TLjw==
X-Gm-Message-State: APzg51D+G3Padc7zHwxhSeQBWRuz2TcbRmeL9eUUOjllZ3WqwjlNT7hO
        DqIatM4EFCwxCnwXR82k2Ps5jvwZ
X-Google-Smtp-Source: ANB0VdZUyAeUEjBUeShdlqefpRPYiStvPcrEiaHXSTQO6eLZbYRNetnIzrAfJb3aft7lok93Vb19Eg==
X-Received: by 2002:a62:6eca:: with SMTP id j193-v6mr10000984pfc.256.1536344391771;
        Fri, 07 Sep 2018 11:19:51 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id f87-v6sm24734666pfh.168.2018.09.07.11.19.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 11:19:51 -0700 (PDT)
Date:   Fri, 07 Sep 2018 11:19:51 -0700 (PDT)
X-Google-Original-Date: Fri, 07 Sep 2018 18:19:45 GMT
Message-Id: <03453cb521ae57475d046024f5840991553410d6.1536344387.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.35.git.gitgitgadget@gmail.com>
References: <pull.35.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/2] t0051: test GIT_TRACE to a windows named pipe
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create a test-tool helper to create the server side of
a windows named pipe, wait for a client connection, and
copy data written to the pipe to stdout.

Create t0051 test to route GIT_TRACE output of a command
to a named pipe using the above test-tool helper.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Makefile                           |  1 +
 t/helper/test-tool.c               |  3 ++
 t/helper/test-tool.h               |  3 ++
 t/helper/test-windows-named-pipe.c | 72 ++++++++++++++++++++++++++++++
 t/t0051-windows-named-pipe.sh      | 17 +++++++
 5 files changed, 96 insertions(+)
 create mode 100644 t/helper/test-windows-named-pipe.c
 create mode 100755 t/t0051-windows-named-pipe.sh

diff --git a/Makefile b/Makefile
index e4b503d259..b1b934d295 100644
--- a/Makefile
+++ b/Makefile
@@ -731,6 +731,7 @@ TEST_BUILTINS_OBJS += test-submodule-config.o
 TEST_BUILTINS_OBJS += test-subprocess.o
 TEST_BUILTINS_OBJS += test-urlmatch-normalization.o
 TEST_BUILTINS_OBJS += test-wildmatch.o
+TEST_BUILTINS_OBJS += test-windows-named-pipe.o
 TEST_BUILTINS_OBJS += test-write-cache.o
 
 TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 805a45de9c..7a9764cd5c 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -41,6 +41,9 @@ static struct test_cmd cmds[] = {
 	{ "subprocess", cmd__subprocess },
 	{ "urlmatch-normalization", cmd__urlmatch_normalization },
 	{ "wildmatch", cmd__wildmatch },
+#ifdef GIT_WINDOWS_NATIVE
+	{ "windows-named-pipe", cmd__windows_named_pipe },
+#endif
 	{ "write-cache", cmd__write_cache },
 };
 
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 7116ddfb94..01c34fe5e7 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -35,6 +35,9 @@ int cmd__submodule_config(int argc, const char **argv);
 int cmd__subprocess(int argc, const char **argv);
 int cmd__urlmatch_normalization(int argc, const char **argv);
 int cmd__wildmatch(int argc, const char **argv);
+#ifdef GIT_WINDOWS_NATIVE
+int cmd__windows_named_pipe(int argc, const char **argv);
+#endif
 int cmd__write_cache(int argc, const char **argv);
 
 #endif
diff --git a/t/helper/test-windows-named-pipe.c b/t/helper/test-windows-named-pipe.c
new file mode 100644
index 0000000000..b4b752b01a
--- /dev/null
+++ b/t/helper/test-windows-named-pipe.c
@@ -0,0 +1,72 @@
+#include "test-tool.h"
+#include "git-compat-util.h"
+#include "strbuf.h"
+
+#ifdef GIT_WINDOWS_NATIVE
+static const char *usage_string = "<pipe-filename>";
+
+#define TEST_BUFSIZE (4096)
+
+int cmd__windows_named_pipe(int argc, const char **argv)
+{
+	const char *filename;
+	struct strbuf pathname = STRBUF_INIT;
+	int err;
+	HANDLE h;
+	BOOL connected;
+	char buf[TEST_BUFSIZE + 1];
+
+	if (argc < 2)
+		goto print_usage;
+	filename = argv[1];
+	if (strchr(filename, '/') || strchr(filename, '\\'))
+		goto print_usage;
+	strbuf_addf(&pathname, "//./pipe/%s", filename);
+
+	/*
+	 * Create a single instance of the server side of the named pipe.
+	 * This will allow exactly one client instance to connect to it.
+	 */
+	h = CreateNamedPipeA(
+		pathname.buf,
+		PIPE_ACCESS_INBOUND | FILE_FLAG_FIRST_PIPE_INSTANCE,
+		PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE | PIPE_WAIT,
+		PIPE_UNLIMITED_INSTANCES,
+		TEST_BUFSIZE, TEST_BUFSIZE, 0, NULL);
+	if (h == INVALID_HANDLE_VALUE) {
+		err = err_win_to_posix(GetLastError());
+		fprintf(stderr, "CreateNamedPipe failed: %s\n",
+			strerror(err));
+		return err;
+	}
+
+	connected = ConnectNamedPipe(h, NULL)
+		? TRUE
+		: (GetLastError() == ERROR_PIPE_CONNECTED);
+	if (!connected) {
+		err = err_win_to_posix(GetLastError());
+		fprintf(stderr, "ConnectNamedPipe failed: %s\n",
+			strerror(err));
+		CloseHandle(h);
+		return err;
+	}
+
+	while (1) {
+		DWORD nbr;
+		BOOL success = ReadFile(h, buf, TEST_BUFSIZE, &nbr, NULL);
+		if (!success || nbr == 0)
+			break;
+		buf[nbr] = 0;
+
+		write(1, buf, nbr);
+	}
+
+	DisconnectNamedPipe(h);
+	CloseHandle(h);
+	return 0;
+
+print_usage:
+	fprintf(stderr, "usage: %s %s\n", argv[0], usage_string);
+	return 1;
+}
+#endif
diff --git a/t/t0051-windows-named-pipe.sh b/t/t0051-windows-named-pipe.sh
new file mode 100755
index 0000000000..10ac92d225
--- /dev/null
+++ b/t/t0051-windows-named-pipe.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+
+test_description='Windows named pipes'
+
+. ./test-lib.sh
+
+test_expect_success MINGW 'o_append write to named pipe' '
+	GIT_TRACE="$(pwd)/expect" git status >/dev/null 2>&1 &&
+	{ test-tool windows-named-pipe t0051 >actual 2>&1 & } &&
+	pid=$! &&
+	sleep 1 &&
+	GIT_TRACE=//./pipe/t0051 git status >/dev/null 2>warning &&
+	wait $pid &&
+	test_cmp expect actual
+'
+
+test_done
-- 
gitgitgadget

