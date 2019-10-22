Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EF511F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 14:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbfJVOjM (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 10:39:12 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:38540 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbfJVOjM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 10:39:12 -0400
Received: by mail-wr1-f52.google.com with SMTP id v9so7110768wrq.5
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 07:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TaiKICDMgkTwwb0jCA6Tn9+wxesEhvai57d6KEqFDQc=;
        b=Wv5mtGcNQzlwVm+lOz/Oy6iT9F2qH1S881tzcV9RrFhDLUHGsWaPi8K5fcRBvC1hu7
         c9v5FurhkKDI7Y3Fo8RIiIXZ4dzLxhAr2RomfWEMGTYLaS1bnR2SunCr8qp/3G3bOSGN
         YE6ry88BqTqFI0EoysZYHKJ0clzs9aCTsGBkhz/EraPv9Q7qH4B0Jl6/J4ijXeNVJxq+
         3Df6ND34TIi7QtHlNRpbKkHDdT1/GAcKkWcFnVi/MBTwDJCpQr7t8xUCPqBwbdVr9Vzp
         A/Yt6mTVCqX9+UOdcE8gmnp6FDe5qNr5c+gidm9awzUIjceZMut30gDkCRovh4xvxtK8
         aYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TaiKICDMgkTwwb0jCA6Tn9+wxesEhvai57d6KEqFDQc=;
        b=KB+K8dD2Jd/EY7gurvdQEtn+s4fRzNPrcY8zwk+GYb98D5Wz3C4naGOctlalA4ClEe
         IK+f1Ec+2sB7vtHQmEG8A4d38cDhpPVpQC5t3T8rnyl4eALbyILxc0kz1DB5zrNFdg9T
         0rMNQRy2bedttItOle1gaw67tak2Bren7xBZFVILBiiwrV+ISU6VNk+il556qP5K3Lhm
         7yhydebOei/38unEHIApj9eNt2ATHZuO3w++Hmef+slrjCgGyu811JNrT1Tdi5f0Ezz9
         Glc9oGBBfrJUftA2+mXBhh6DFR+mJCUb4KZcHoUKiOklpCoYkW2SqRu2GBXxKyCs1zmv
         CTpQ==
X-Gm-Message-State: APjAAAVD7Ff8nkG0qPWV4Gc0al6n6HNvSOPjiGBd25xFHN5phO1AEXlS
        aDjXzAK+tNZZlk9ayOTpiGwYM8NW
X-Google-Smtp-Source: APXvYqyRnRdAkkF769AyRhDy71YGwxjiRqpoUYNcY4MYV2skIW+7uhjsCH14yz5Y2GjMS/K4ZS3kqw==
X-Received: by 2002:a5d:424a:: with SMTP id s10mr3721823wrr.108.1571755149095;
        Tue, 22 Oct 2019 07:39:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f17sm6890425wrs.66.2019.10.22.07.39.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 07:39:08 -0700 (PDT)
Message-Id: <5fd06fa881da6d0058b9c78525502a6126f68d71.1571755147.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.407.git.1571755147.gitgitgadget@gmail.com>
References: <pull.407.git.1571755147.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Oct 2019 14:39:07 +0000
Subject: [PATCH 1/1] vreportf: Fix interleaving issues, remove 4096 limitation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

This also fixes t5516 on Windows VS build.
For detailed explanation please refer to code comments in this commit.

There was a lot of back-and-forth already in vreportf():
d048a96e (2007-11-09) - 'char msg[256]' is introduced to avoid interleaving
389d1767 (2009-03-25) - Buffer size increased to 1024 to avoid truncation
625a860c (2009-11-22) - Buffer size increased to 4096 to avoid truncation
f4c3edc0 (2015-08-11) - Buffer removed to avoid truncation
b5a9e435 (2017-01-11) - Reverts f4c3edc0 to be able to replace control
                        chars before sending to stderr

This fix attempts to solve all issues:
1) avoid multiple fprintf() interleaving
2) avoid truncation
3) avoid char interleaving in fprintf() on some platforms
4) avoid buffer block interleaving when output is large
5) avoid out-of-order messages
6) replace control characters in output

Other commits worthy of notice:
9ac13ec9 (2006-10-11) - Another attempt to solve interleaving.
						This is seemingly related to d048a96e.
137a0d0e (2007-11-19) - Addresses out-of-order for display()
34df8aba (2009-03-10) - Switches xwrite() to fprintf() in recv_sideband()
						to support UTF-8 emulation
eac14f89 (2012-01-14) - Removes the need for fprintf() for UTF-8 emulation,
						so it's safe to use xwrite() again
5e5be9e2 (2016-06-28) - recv_sideband() uses xwrite() again

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 usage.c | 154 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 148 insertions(+), 6 deletions(-)

diff --git a/usage.c b/usage.c
index 2fdb20086b..ccdd91a7b9 100644
--- a/usage.c
+++ b/usage.c
@@ -6,17 +6,159 @@
 #include "git-compat-util.h"
 #include "cache.h"
 
+static void replace_control_chars(char* str, size_t size, char replacement)
+{
+	size_t i;
+
+	for (i = 0; i < size; i++) {
+    		if (iscntrl(str[i]) && str[i] != '\t' && str[i] != '\n')
+			str[i] = replacement;
+	}
+}
+
+/*
+ * Atomically report (prefix + vsnprintf(err, params) + '\n') to stderr.
+ * Always returns desired buffer size.
+ * Doesn't write to stderr if content didn't fit.
+ *
+ * This function composes everything into a single buffer before
+ * sending to stderr. This is to defeat various non-atomic issues:
+ * 1) If stderr is fully buffered:
+ *    the ordering of stdout and stderr messages could be wrong,
+ *    because stderr output waits for the buffer to become full.
+ * 2) If stderr has any type of buffering:
+ *    buffer has fixed size, which could lead to interleaved buffer
+ *    blocks when two threads/processes write at the same time.
+ * 3) If stderr is not buffered:
+ *    There are two problems, one with atomic fprintf() and another
+ *    for non-atomic fprintf(), and both occur depending on platform
+ *    (see details below). If atomic, this function still writes 3
+ *    parts, which could get interleaved with multiple threads. If
+ *    not atomic, then fprintf() will basically write char-by-char,
+ *    which leads to unreadable char-interleaved writes if two
+ *    processes write to stderr at the same time (threads are OK
+ *    because fprintf() usually locks file in current process). This
+ *    for example happens in t5516 where 'git-upload-pack' detects
+ *    an error, reports it to parent 'git fetch' and both die() at the
+ *    same time.
+ *
+ *    Behaviors, at the moment of writing:
+ *    a) libc - fprintf()-interleaved
+ *       fprintf() enables temporary stream buffering.
+ *       See: buffered_vfprintf()
+ *    b) VC++ - char-interleaved
+ *       fprintf() enables temporary stream buffering, but only if
+ *       stream was not set to no buffering. This has no effect,
+ *       because stderr is not buffered by default, and git takes
+ *       an extra step to ensure that in swap_osfhnd().
+ *       See: _iob[_IOB_ENTRIES],
+ *            __acrt_stdio_temporary_buffering_guard,
+ *            has_any_buffer()
+ *    c) MinGW - char-interleaved (console), full buffering (file)
+ *       fprintf() obeys stderr buffering. But it uses old MSVCRT.DLL,
+ *       which eventually calls _flsbuf(), which enables buffering unless
+ *       isatty(stderr) or buffering is disabled. Buffering is not disabled
+ *       by default for stderr. Therefore, buffering is enabled for
+ *       file-redirected stderr.
+ *       See: __mingw_vfprintf(),
+ *            __pformat_wcputs(),
+ *            _fputc_nolock(),
+ *            _flsbuf(),
+ *            _iob[_IOB_ENTRIES]
+ * 4) If stderr is line buffered: MinGW/VC++ will enable full
+ *    buffering instead. See MSDN setvbuf().
+ */
+static size_t vreportf_buf(char *buf, size_t buf_size, const char *prefix, const char *err, va_list params)
+{
+	int printf_ret = 0;
+	size_t prefix_size = 0;
+	size_t total_size = 0;
+
+	/*
+	 * NOTE: Can't use strbuf functions here, because it can be called when
+	 * malloc() is no longer possible, and strbuf will recurse die().
+	 */
+
+	/* Prefix */
+	prefix_size = strlen(prefix);
+	if (total_size + prefix_size <= buf_size)
+		memcpy(buf + total_size, prefix, prefix_size);
+	
+	total_size += prefix_size;
+
+	/* Formatted message */
+	if (total_size <= buf_size)
+		printf_ret = vsnprintf(buf + total_size, buf_size - total_size, err, params);
+	else
+		printf_ret = vsnprintf(NULL, 0, err, params);
+
+	if (printf_ret < 0)
+		BUG("your vsnprintf is broken (returned %d)", printf_ret);
+
+	/*
+	 * vsnprintf() returns _desired_ size (without terminating null).
+	 * If vsnprintf() was truncated that will be seen when appending '\n'.
+	 */
+	total_size += printf_ret;
+
+	/* Trailing \n */
+	if (total_size + 1 <= buf_size)
+		buf[total_size] = '\n';
+
+	total_size += 1;
+
+	/* Send the buffer, if content fits */
+	if (total_size <= buf_size) {
+	    replace_control_chars(buf, total_size, '?');
+	    fwrite(buf, total_size, 1, stderr);
+	}
+
+	return total_size;
+}
+
 void vreportf(const char *prefix, const char *err, va_list params)
 {
+	size_t res = 0;
+	char *buf = NULL;
+	size_t buf_size = 0;
+
+	/*
+	 * NOTE: This can be called from failed xmalloc(). Any malloc() can
+	 * fail now. Let's try to report with a fixed size stack based buffer.
+	 * Also, most messages should fit, and this path is faster.
+	 */
 	char msg[4096];
-	char *p;
+	res = vreportf_buf(msg, sizeof(msg), prefix, err, params);
+	if (res <= sizeof(msg)) {
+		/* Success */
+		return;
+	}
 
-	vsnprintf(msg, sizeof(msg), err, params);
-	for (p = msg; *p; p++) {
-		if (iscntrl(*p) && *p != '\t' && *p != '\n')
-			*p = '?';
+	/*
+	 * Try to allocate a suitable sized malloc(), if possible.
+	 * NOTE: Do not use xmalloc(), because on failure it will call
+	 * die() or warning() and lead to recursion.
+	 */
+	buf_size = res;
+	buf = malloc(buf_size);
+	if (buf) {
+		res = vreportf_buf(buf, buf_size, prefix, err, params);
+		FREE_AND_NULL(buf);
+
+		if (res <= buf_size) {
+			/* Success */
+			return;
+		}
 	}
-	fprintf(stderr, "%s%s\n", prefix, msg);
+
+	/* 
+	 * When everything fails, report in parts.
+	 * This can have all problems prevented by vreportf_buf().
+	 */
+	fprintf(stderr, "vreportf: not enough memory (tried to allocate %lu bytes)\n", (unsigned long)buf_size);
+	fputs(prefix, stderr);
+	vfprintf(stderr, err, params);
+	fputc('\n', stderr);
 }
 
 static NORETURN void usage_builtin(const char *err, va_list params)
-- 
gitgitgadget
