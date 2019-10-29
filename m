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
	by dcvr.yhbt.net (Postfix) with ESMTP id 951071F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 20:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbfJ2UBZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 16:01:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43860 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728971AbfJ2UBZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 16:01:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id n1so7575283wra.10
        for <git@vger.kernel.org>; Tue, 29 Oct 2019 13:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=+dNtdCsbflQxgI1WAfZaapmuP/vWkJe8/YqyTMzFsRU=;
        b=GuT5O8FGYNxCJ5Lm+JdBoPwE3jdNWC8MguJiqzm0hznTM8UCHNsP2XgaG1gTAIOC5v
         owc/ib0abiYWpMb66xXZkag0lcD3TSAJYT0DyX7uxWw1vUjvL/kxcA2NBvZxjQS9Si4k
         aERi5bh+8VnEGLyOk8lIVBOe6FeCC5dLOf/tYnnyN+ktZiKzLu9OOiT7WA9cDRA9+1MK
         BQljeySPNPN7I+OQPKBtflbMYpyfldJnm/fBhgb1JhKC69pso4RMFl0XvwdRSjDMuir7
         B5oIM4KCmXpe0g50FJk0quqtLFGIbQ0uky5Ko9/vu8wrNZIuwsvC15ku15fNiIewNhCi
         0sUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=+dNtdCsbflQxgI1WAfZaapmuP/vWkJe8/YqyTMzFsRU=;
        b=iMJ1hOykuy4ObjFi8haUZnKtlyC68ZWpiIkYrLKj2a2BI5J5Xye/wDZ6AxKIeFZamB
         bkT5gqQP3FMM7v8yWacPuFfjtuis1MhGLJgVuNKeVdOQbs5e7Lfw++B/yK+wH/lFvFeH
         A8554XS6jGRtnWOftpqla5S8ZyKu7oSCHGgDLXPvxWEYLZjju6Kov4WTeIu8olpuyBK4
         i/oNm0zx42CtRF9ecZFTkzNHiNknOJqneRPuYGRT2iMU4bEJ4JMc01dUuNCLeSxGlyyB
         aOKP91Il6tcgnno+N4u5U+AclaFqMXEz0Fa3jOPsS/nYqgXY1AsilZ3TfkxJlcPd1hKR
         PunQ==
X-Gm-Message-State: APjAAAWyRXqoQVX7yqdyU4kiH3mDhsm7g7m97TTwCm868V8HQqKUNTTV
        sQRgXRjKA7+YYBTDAWNc6rtCIN2T
X-Google-Smtp-Source: APXvYqy5HB71dGGtEF1LKtBdhbfN4NIEPCGyz4UAo+sBIxPMGAd9h327kL3F1OigAU88DZw1StqJaw==
X-Received: by 2002:adf:ee10:: with SMTP id y16mr21096817wrn.67.1572379282862;
        Tue, 29 Oct 2019 13:01:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a11sm4393165wmh.40.2019.10.29.13.01.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 13:01:22 -0700 (PDT)
Message-Id: <fce0894ee46f737322551b51edf5cd2a53413a50.1572379280.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.428.v3.git.1572379280.gitgitgadget@gmail.com>
References: <pull.428.v2.git.1572356272.gitgitgadget@gmail.com>
        <pull.428.v3.git.1572379280.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Oct 2019 20:01:20 +0000
Subject: [PATCH v3 1/1] vreportf(): avoid relying on stdio buffering
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The MSVC runtime behavior differs from glibc's with respect to
`fprintf(stderr, ...)` in that the former writes out the message
character by character.

In t5516, this leads to a funny problem where a `git fetch` process as
well as the `git upload-pack` process spawned by it _both_ call `die()`
at the same time. The output can look like this:

	fatal: git uploadfata-lp: raemcokte :error:  upload-pnot our arcef k6: n4ot our ea4cr1e3f 36d45ea94fca1398e86a771eda009872d63adb28598f6a9
	8e86a771eda009872d6ab2886

Let's avoid this predicament altogether by rendering the entire message,
including the prefix and the trailing newline, into the buffer we
already have (and which is still fixed size) and then write it out via
`write_in_full()`.

We still clip the message to at most 4095 characters.

The history of `vreportf()` with regard to this issue includes the
following commits:

d048a96e (2007-11-09) - 'char msg[256]' is introduced to avoid interleaving
389d1767 (2009-03-25) - Buffer size increased to 1024 to avoid truncation
625a860c (2009-11-22) - Buffer size increased to 4096 to avoid truncation
f4c3edc0 (2015-08-11) - Buffer removed to avoid truncation
b5a9e435 (2017-01-11) - Reverts f4c3edc0 to be able to replace control
                        chars before sending to stderr
9ac13ec9 (2006-10-11) - Another attempt to solve interleaving.
                        This is seemingly related to d048a96e.
137a0d0e (2007-11-19) - Addresses out-of-order for display()
34df8aba (2009-03-10) - Switches xwrite() to fprintf() in recv_sideband()
                        to support UTF-8 emulation
eac14f89 (2012-01-14) - Removes the need for fprintf() for UTF-8 emulation,
                        so it's safe to use xwrite() again
5e5be9e2 (2016-06-28) - recv_sideband() uses xwrite() again

Note that we print nothing if the `vsnprintf()` call failed to render
the error message; There is little we can do in that case, and it should
not happen anyway.

Also please note that we `fflush(stderr)` here to help when running in a
Git Bash on Windows: in this case, `stderr` is not actually truly
unbuffered, and needs the extra help.

Helped-by: Jeff King <peff@peff.net>
Helped-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 usage.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/usage.c b/usage.c
index 2fdb20086b..471efb2de9 100644
--- a/usage.c
+++ b/usage.c
@@ -9,14 +9,21 @@
 void vreportf(const char *prefix, const char *err, va_list params)
 {
 	char msg[4096];
-	char *p;
+	size_t off = strlcpy(msg, prefix, sizeof(msg));
+	char *p, *pend = msg + sizeof(msg);
 
-	vsnprintf(msg, sizeof(msg), err, params);
-	for (p = msg; *p; p++) {
+	p = off < pend - msg ? msg + off : pend - 1;
+	if (vsnprintf(p, pend - p, err, params) < 0)
+		*p = '\0'; /* vsnprintf() failed, clip at prefix */
+
+	for (; p != pend - 1 && *p; p++) {
 		if (iscntrl(*p) && *p != '\t' && *p != '\n')
 			*p = '?';
 	}
-	fprintf(stderr, "%s%s\n", prefix, msg);
+
+	*(p++) = '\n'; /* we no longer need a NUL */
+	fflush(stderr);
+	write_in_full(2, msg, p - msg);
 }
 
 static NORETURN void usage_builtin(const char *err, va_list params)
-- 
gitgitgadget
