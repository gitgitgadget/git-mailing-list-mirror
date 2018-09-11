Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E6061F404
	for <e@80x24.org>; Tue, 11 Sep 2018 20:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbeILBG4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 21:06:56 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:43408 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbeILBGz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 21:06:55 -0400
Received: by mail-pf1-f178.google.com with SMTP id j26-v6so12753063pfi.10
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 13:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8DeR8mfKxdGNHuVI4yZjPCpc4dM/U91ZPGF8eizlR4A=;
        b=XGDhy+am6sRG5tAYNDybFZ/4Zop5qj9YB9tt4Xn77JPHi1qRGmpIxf5RFAsbEp0+Ce
         ysAuH5dZdCf6rTv86xGUq+jgcj6xpgDPJMccqskV0fOxNX4KicJkSmXEJLTvsmMFYgzV
         WaWIB/DpeFDwSrdAoC1nQgKdD+ed+WJV+d/1r0tDJuuFUgL4BeM5YF7g2s+oCpLH4XSM
         K4DeCC/r31RBThQLt1Ba0bIAMtDH6ydOXdu9agX7Bl05tFE6ULFFrVLx9dBeysysfiyU
         xvKz3bIlHMeEvD6Da6MFW5ZkzSWjBkxXl9rWyRNtmZXER7HbJPxZzXTPCs9p9ApPotr4
         jBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8DeR8mfKxdGNHuVI4yZjPCpc4dM/U91ZPGF8eizlR4A=;
        b=S4zfyobpWNDiX0n3spV9nifIwyMy5zaNHIiPYW7ddDIRB6h/g2KbXlW6Skk32rE4/4
         DhRENW8Tazl/V63p0W0abKP2ykidrjQp4wMIxvepEYA7hxbjCWRY4B02uiJ/DqnbNJi2
         ZdFcTEjdnwuKIbT3Sexy/5w0asnte9PgQ9Q5vIOqgGGnFKlFnI0ye3IUcyPGW+dAAvWX
         Ze9sjOFfxnlgUHzsFC7U3QCLzVAFvpWlc+m9RFzTa4xOL6JAX7aXzS2TxhgOexRTCYxa
         v14/dqYcD9xp2ZG8UA+E+PJEVDkASy6+5XjxFvCVljpxenCefpML4Rw8WesBZzHABqLt
         AUiw==
X-Gm-Message-State: APzg51CIFDvM0JKIwKmN4Trx1E6Z7ZRT3m9dGTAQKq37FgJpLMUMh4z5
        uZgWZUnvmVUit7mZSQN4Cbu0vqES
X-Google-Smtp-Source: ANB0VdY+TpayvEaTD/8esogpuKnd7NkuZ4vFcV2g7TLzmmldCfMk58dvnw0FAoRdqsj6jIEyIfwQ2g==
X-Received: by 2002:a62:8186:: with SMTP id t128-v6mr30754259pfd.192.1536696362297;
        Tue, 11 Sep 2018 13:06:02 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id a72-v6sm37971126pge.85.2018.09.11.13.06.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 13:06:01 -0700 (PDT)
Date:   Tue, 11 Sep 2018 13:06:01 -0700 (PDT)
X-Google-Original-Date: Tue, 11 Sep 2018 20:05:56 GMT
Message-Id: <ecb30eb47c3746444bf30b88329589143db1704c.1536696358.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.35.v3.git.gitgitgadget@gmail.com>
References: <pull.35.v2.git.gitgitgadget@gmail.com>
        <pull.35.v3.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 1/2] t0051: test GIT_TRACE to a windows named pipe
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
index 0000000000..e3c36341a0
--- /dev/null
+++ b/t/t0051-windows-named-pipe.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+
+test_description='Windows named pipes'
+
+. ./test-lib.sh
+
+test_expect_failure MINGW 'o_append write to named pipe' '
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

