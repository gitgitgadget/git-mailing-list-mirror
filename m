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
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BFBA1F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 10:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfJ3Kom (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 06:44:42 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50932 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfJ3Kom (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Oct 2019 06:44:42 -0400
Received: by mail-wm1-f67.google.com with SMTP id 11so1568937wmk.0
        for <git@vger.kernel.org>; Wed, 30 Oct 2019 03:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=N5lD922FG8R/irvjjWqfqK3oC6InYH4lrK1VgdIy0uM=;
        b=Tf1JFJxRTa3aGjvmHDhkio4InxYowRiv5hOsCJ8/ub797T7mHbE2SeICiXONCwKkFL
         mVM9ujt+JS+SRTP7wFG+SsWEZhhVsJ5E8lUQ4WHUq+6+UA+MTPmuSBoqIibUo7KLiz+h
         ROMtpp8Ixb+jJKBGuCaNYHd7tfxUPXOexXkQ4KVMtrX5u7XePeU5AtoxZMWVVcHNXW90
         iDXqOI7/QECuUeaZ0El2kr3LHIKRVYHMFMJxn88SB5bBiT2JrN3v5K4IrL0pQBU3S8ju
         0pmGtGMFDLLPl5ITaTOSBIykP59jZXatxvtw7oF/YW+1iBeduhpzqW2f7CSmLIhsHd5G
         0F8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=N5lD922FG8R/irvjjWqfqK3oC6InYH4lrK1VgdIy0uM=;
        b=PlJ60HJEHbCDVAwufar+U3Qnx6MU3GgTAmOq3liz7Sz7wQGS+XwRPxC88m7jf5oC6r
         wgz5Onyd2wnt5P4A+Bfu5MtTjASc37PS6ghp5LPTzDvyzD/kO/3sgzv5MA/cF6Ax/yy/
         yiH2/4WmPuvi30toRwvmx9VcPgrm78R4r56bePzjntkL/GZOoRwtEYuN8rA3ipwu0NNC
         e5rWaehruCBoviextDasQnwCYyuGLxZW+u2/uEe3QJdpF/B3z6QT7jab0Kaobewoz4Gz
         9JhCO4ngl+WsZCtaEAd5LJ59eX/H9tHNQzvJiHGuR4msTlpTDfS8IjelXi/2bULnZMVc
         zFGQ==
X-Gm-Message-State: APjAAAW6z96mK30gy3RODDSEgcB+7pD2fFcbOFB8qH2yYLTbezPdLn9E
        PYxSdFklIMv2Ue34UOHgBvfXZ6XT
X-Google-Smtp-Source: APXvYqwtLyGUInGvT8hH8lCB0j6ZJOXcvAPiosBmXs2/+z0l1XeqfiRNZULp5Fx6N6IKvPGlIDVQIg==
X-Received: by 2002:a7b:c011:: with SMTP id c17mr8565454wmb.95.1572432278420;
        Wed, 30 Oct 2019 03:44:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r5sm1976120wrl.86.2019.10.30.03.44.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Oct 2019 03:44:37 -0700 (PDT)
Message-Id: <f6d6c8122abbd6339cf83309ac3761bbdac44023.1572432276.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.428.v4.git.1572432276.gitgitgadget@gmail.com>
References: <pull.428.v3.git.1572379280.gitgitgadget@gmail.com>
        <pull.428.v4.git.1572432276.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 30 Oct 2019 10:44:36 +0000
Subject: [PATCH v4 1/1] vreportf(): avoid relying on stdio buffering
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

The process may have written to `stderr` and there may be something left
in the buffer kept in the stdio layer. Call `fflush(stderr)` before
writing the message we prepare in this function.

Helped-by: Jeff King <peff@peff.net>
Helped-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 usage.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/usage.c b/usage.c
index 2fdb20086b..58fb5fff5f 100644
--- a/usage.c
+++ b/usage.c
@@ -9,14 +9,26 @@
 void vreportf(const char *prefix, const char *err, va_list params)
 {
 	char msg[4096];
-	char *p;
+	char *p, *pend = msg + sizeof(msg);
+	size_t prefix_len = strlen(prefix);
 
-	vsnprintf(msg, sizeof(msg), err, params);
-	for (p = msg; *p; p++) {
+	if (sizeof(msg) <= prefix_len) {
+		fprintf(stderr, "BUG!!! too long a prefix '%s'\n", prefix);
+		abort();
+	}
+	memcpy(msg, prefix, prefix_len);
+	p = msg + prefix_len;
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
