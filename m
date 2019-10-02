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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C47B1F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 03:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfJBDNQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Oct 2019 23:13:16 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40780 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfJBDNQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Oct 2019 23:13:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id l3so17757380wru.7
        for <git@vger.kernel.org>; Tue, 01 Oct 2019 20:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9wrrqikuZm4qWB9PpQhToZovIFZUpEOLUV57azVrSBs=;
        b=Js1/svlkfRBNkst+bWoEQOhsHwXzJaF2uvxel48pfJsm2yLG8MshTsO9ll7mBa+wjb
         TrG+OZZrZbBLJCgXnr5EsJadpwo3GoZymxGkVAU7vNjLUyIt3HTyp1YWwIEj8/l+sAfR
         LoV9iFNqOqiyYNW74B/9p37MuvovV7mw+X2oGYoX0xxjm2iJwqhotVA7nZ4H1pgTJNCw
         bBjDro7uogBP5iEouZIPjJFLIueebDfqxvIX5Nbk1BDMnBCO+t7XhTHQfwCjjjQ/U5fL
         ojlU3Sc6b4tib4pMwK45M7s4a2qz7hIB5wzRD5MRFa5QFn4bNJNTcNsa/R1XmR/BleK0
         TTeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9wrrqikuZm4qWB9PpQhToZovIFZUpEOLUV57azVrSBs=;
        b=TqTWaEcDXdoET7Jj3lcAOpwRiWsAmdfTbtE3Q+qeOsG8KF65sYavfWMjL6aYZap5oE
         fe2MSZqPL+jHJS1h7IN/olOxXEZ1pGuPh8wkPMEhk8hJvqaixkNzSNjJE3dnhOWZ2UeP
         bj72Ow8lcx5/3RB5oljlJumvPxr3P4U2FBpEBchxBioiA+q20PJIlTVKBblStcSBBpIX
         S8weVlCoZ4YovLrYwIu7nrfDkKopOr8uII3bWr8J97twH6kv4Aou5+iJgQKNlMqGKk45
         W/uruex/WoKhs72+aHstPQVthSLL1pYRcmqOfp5iqRRJlG/h7cGig6dNNd7ZozUIpEnr
         UYOw==
X-Gm-Message-State: APjAAAXAhGxg1MntPuqhVOMRe3ZyA7qn4rHbYSKgaKVZ/cE94Uel+cue
        pcVVhM5uLZGaGQuBUGRNdJxtqq3Z
X-Google-Smtp-Source: APXvYqwZ69UMlwmX6tOzo/vK2FEPf2WXbeKtMKC9GTwQ20aqaRhbJ+QkLWkMBXuHIEKVo5SZebKVsw==
X-Received: by 2002:adf:f00d:: with SMTP id j13mr681259wro.140.1569985994115;
        Tue, 01 Oct 2019 20:13:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g11sm4912614wmh.45.2019.10.01.20.13.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 20:13:13 -0700 (PDT)
Date:   Tue, 01 Oct 2019 20:13:13 -0700 (PDT)
X-Google-Original-Date: Wed, 02 Oct 2019 03:13:11 GMT
Message-Id: <e448214e87b46dc649781b10727043bc390d9aab.1569985991.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.370.git.gitgitgadget@gmail.com>
References: <pull.370.git.gitgitgadget@gmail.com>
From:   "Chris Zehner via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] gitignore: ignore comments on the same line as a pattern
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Chris Zehner <cbzehner@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Chris Zehner <cbzehner@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Chris Zehner <cbzehner@gmail.com>

Signed-off-by: Chris Zehner <cbzehner@gmail.com>
---
 Documentation/gitignore.txt |  8 ++++++--
 dir.c                       | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index d47b1ae296..1778cf1d38 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -74,8 +74,12 @@ PATTERN FORMAT
    for readability.
 
  - A line starting with # serves as a comment.
-   Put a backslash ("`\`") in front of the first hash for patterns
-   that begin with a hash.
+   Put a backslash ("`\`") in front of each hash for patterns
+   containing a hash.
+
+ - A # after a pattern will be treated as the start of a comment.
+   Put a backslash ("`\`") in front of each hash for patterns
+   containing a hash.
 
  - Trailing spaces are ignored unless they are quoted with backslash
    ("`\`").
diff --git a/dir.c b/dir.c
index cab9c2a458..aeefe142bc 100644
--- a/dir.c
+++ b/dir.c
@@ -658,6 +658,38 @@ void clear_pattern_list(struct pattern_list *pl)
 	memset(pl, 0, sizeof(*pl));
 }
 
+static void trim_trailing_comments(char *buf)
+{
+	char *p, *last_hash = NULL;
+	int escape_seq = 0;
+
+	for (p = buf; *p; p++)
+	{
+		if (!*p)
+			return;
+		switch (*p) {
+		case '#':
+			if (escape_seq)
+			{
+				escape_seq = 0;
+				p++;
+				break;
+			}
+			if (!last_hash)
+				last_hash = p;
+			break;
+		case '\\':
+			escape_seq = 1;
+			break;
+		default:
+			escape_seq = 0;
+		}
+	}
+
+	if (last_hash)
+		*last_hash = '\0';
+}
+
 static void trim_trailing_spaces(char *buf)
 {
 	char *p, *last_space = NULL;
@@ -859,6 +891,7 @@ static int add_patterns_from_buffer(char *buf, size_t size,
 		if (buf[i] == '\n') {
 			if (entry != buf + i && entry[0] != '#') {
 				buf[i - (i && buf[i-1] == '\r')] = 0;
+				trim_trailing_comments(entry);
 				trim_trailing_spaces(entry);
 				add_pattern(entry, base, baselen, pl, lineno);
 			}
-- 
gitgitgadget
