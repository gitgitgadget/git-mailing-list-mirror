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
	by dcvr.yhbt.net (Postfix) with ESMTP id 139791F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 13:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388784AbfJ2Nh5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 09:37:57 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36386 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388602AbfJ2Nh5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 09:37:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id w18so13715221wrt.3
        for <git@vger.kernel.org>; Tue, 29 Oct 2019 06:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=fkaoSLPaUyFCyXUYZ2WiqtKApdOntsrWRd/6T2qy5Ws=;
        b=BhRxswKAfX2PYlWdI1/qf05JgmfPSau8pgnVqiSVr0kUE27ZXpBctQjIFYG6AnJDbf
         HGeZJV3zBKKIHfR4r3fP4+/omj0DWfFgeBsc0yUecpDPJpSX27TSMb9um1AL1CUE88Zh
         EwAbRtdRgsN9VnRVxpPLIJmPfDvkGxEo5CPivSQIPHhAkhdB9X9xJ4Yem9j8HsB4PuJH
         w8ALAQkF+Cra3fn+0pEPDwyIxt67MtnXgvfxZdW+chN8bEs0B/CxlvOtlFd4bpDrvOh7
         2ZYNTjXdkOgbi9sqN+qiEGjtCZX3jJvZJgMyBRdZr86Nw5t9JEDMQwsYgr7DTqqcITvZ
         NfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=fkaoSLPaUyFCyXUYZ2WiqtKApdOntsrWRd/6T2qy5Ws=;
        b=p2TuVVxHZLVdq4ud+T7N/w7sqA7YQn05H0vFl7d/yCu8WW0r/OV2Up83pgKm37nrig
         EZvLk+23bYPCmWq08t/0ZN2SgnKevDLkPA3qDsXWvSjXJDY1hQEuRlptKuHG+ShigZmN
         GutaTm9ya64O1KBsbD2fY1aBPjqqVRR55WSTxzdI3DPTPQyGjwplFvYiidet/yUhl0fz
         CoKRHqkC2gv3rICf4E20uRt5hsxCLmqRNLtY/6Ko4wBhxb4ATa4bGQ4blM0ExPoUFWnG
         9IpTrzHlGARppwbMZvzEgnevUJFFMmenV5+33A3sbtMx6W181C7xmQzgykdg6BIzSg9b
         fInQ==
X-Gm-Message-State: APjAAAU0EqXDE72+3epZLPljaC0aGLtzpER5sMhauzkTSnZo8+G7bv+M
        Rj1p05jECj1A924wqgh3l5fDYqdV
X-Google-Smtp-Source: APXvYqxG3yIRiTUCTz2j55R3zYjVm50QpcsyXEh6JIgToXPbjS5ahfjGdnCotzYwL4fxqWXNtgdtuA==
X-Received: by 2002:adf:eec9:: with SMTP id a9mr5996490wrp.8.1572356274862;
        Tue, 29 Oct 2019 06:37:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o187sm2927398wmo.20.2019.10.29.06.37.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 06:37:54 -0700 (PDT)
Message-Id: <e426627e1494e31e548fe044c1c1806ff59340cf.1572356272.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.428.v2.git.1572356272.gitgitgadget@gmail.com>
References: <pull.428.git.1572274859.gitgitgadget@gmail.com>
        <pull.428.v2.git.1572356272.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Oct 2019 13:37:52 +0000
Subject: [PATCH v2 1/1] vreportf(): avoid relying on stdio buffering
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
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
`xwrite()`.

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

Helped-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 usage.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/usage.c b/usage.c
index 2fdb20086b..5dfd38acb8 100644
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
+	p = msg + off < pend ? msg + off : pend - 1;
+	if (vsnprintf(p, pend - p, err, params) < 0)
+		return; /* vsnprintf() failed, there is nothing we can do */
+
+	for (; p != pend - 1 && *p; p++) {
 		if (iscntrl(*p) && *p != '\t' && *p != '\n')
 			*p = '?';
 	}
-	fprintf(stderr, "%s%s\n", prefix, msg);
+
+	*(p++) = '\n'; /* we no longer need a NUL */
+	fflush(stderr);
+	xwrite(2, msg, p - msg);
 }
 
 static NORETURN void usage_builtin(const char *err, va_list params)
-- 
gitgitgadget
