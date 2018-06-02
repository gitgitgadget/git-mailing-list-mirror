Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8124A1F42D
	for <e@80x24.org>; Sat,  2 Jun 2018 04:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751756AbeFBEdn (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 00:33:43 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33385 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751537AbeFBEdM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 00:33:12 -0400
Received: by mail-lf0-f67.google.com with SMTP id y20-v6so17612434lfy.0
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 21:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Espz6AWqrcjCbEVT098w5ZQrujuewc8hBvmu5jWt4A=;
        b=eii+LOlAb6uYHAHgKuImDEx/FyMUniHGkSuJSk2IwDtidUXHAnx1M5gxIZthMJ5rBr
         64LLWnl1c1/Bw9JOEFIK9qffIopouscM7+3gtLAGafdMj/WQLq2KcHTXhtd3NLwSxycn
         trjbrUUHD0TFaooJP3YhMR6c//hcys5qNTliEzipYnVStsx4wvjUZYRQ5Z08Y4VEkJ7y
         dax59cceMnjUtS4gN63j4RZNW808oJ5GWMRxO7XrN5k+Pm0sis5Kv6xoC4CcxBUslxXX
         zqyQirvvXnGy7d44H8FI80pRN4cRA1+Ema3FgWHzN+YG1oHzCymsk4llQKm5F5INdG8c
         B1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Espz6AWqrcjCbEVT098w5ZQrujuewc8hBvmu5jWt4A=;
        b=uL1bf+wEpmLjeyOsmZUhhoq96M7pQTrmDx0FtA6PQAAzJe8s2vEykaCsojKGOvvJGz
         gLeCssjPlG9rvbhruOiSnNpArkO0BjpofM2Eu+44xCjIiNL7xcfM3tfwFiJ+8z/u7J1F
         Ubv3iysE6LYqGwzPkwYSnLHMBdJI97Ajv5BNHuJtgwkRIkLwJCHlFX/NMZU2tAHOI86e
         7AaaVWrm4xxlrzvX3MyykTMEWwVNq8UuKliNvIhYccfOaKwYIOEv95NZvYbEIPGFbc9k
         NFFJaEdelbH4V+AI7BU+hDjqDGGaTl0a6ze9SsCR5wYpBsaTE6K2uIiDNerkzsBQ9ok4
         IBFA==
X-Gm-Message-State: ALKqPwcV5GBtkybS6Omx7OdMdoYAL82bxg1qt7iPCDciT8wygP6YlWOp
        yC178oo18kxynDVpxZdEvohLCA==
X-Google-Smtp-Source: ADUXVKLhRRPdMKQ5L8RWvJ7aGMNL+iHTmiE1gIce8DZs3GFd/VAl4coPiAioyKRO+hCisNA56ijRZg==
X-Received: by 2002:a2e:8184:: with SMTP id e4-v6mr9770458ljg.93.1527913990553;
        Fri, 01 Jun 2018 21:33:10 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o11-v6sm644776lji.0.2018.06.01.21.33.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Jun 2018 21:33:09 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 19/22] sequencer.c: mark more strings for translation
Date:   Sat,  2 Jun 2018 06:32:38 +0200
Message-Id: <20180602043241.9941-20-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.309.g77c7720784
In-Reply-To: <20180602043241.9941-1-pclouds@gmail.com>
References: <20180602043241.9941-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sequencer.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index cca968043e..1802b49626 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -714,7 +714,7 @@ static const char *read_author_ident(struct strbuf *buf)
 	/* dequote values and construct ident line in-place */
 	for (in = out = buf->buf; i < 3 && in - buf->buf < buf->len; i++) {
 		if (!skip_prefix(in, keys[i], (const char **)&in)) {
-			warning("could not parse '%s' (looking for '%s'",
+			warning(_("could not parse '%s' (looking for '%s'"),
 				rebase_path_author_script(), keys[i]);
 			return NULL;
 		}
@@ -736,7 +736,7 @@ static const char *read_author_ident(struct strbuf *buf)
 	}
 
 	if (i < 3) {
-		warning("could not parse '%s' (looking for '%s')",
+		warning(_("could not parse '%s' (looking for '%s')"),
 			rebase_path_author_script(), keys[i]);
 		return NULL;
 	}
@@ -1442,7 +1442,7 @@ static const char *command_to_string(const enum todo_command command)
 {
 	if (command < TODO_COMMENT)
 		return todo_command_info[command].str;
-	die("Unknown command: %d", command);
+	die(_("unknown command: %d"), command);
 }
 
 static char command_to_char(const enum todo_command command)
@@ -2597,15 +2597,17 @@ static int error_with_patch(struct commit *commit,
 		if (intend_to_amend())
 			return -1;
 
-		fprintf(stderr, "You can amend the commit now, with\n"
-			"\n"
-			"  git commit --amend %s\n"
-			"\n"
-			"Once you are satisfied with your changes, run\n"
-			"\n"
-			"  git rebase --continue\n", gpg_sign_opt_quoted(opts));
+		fprintf(stderr,
+			_("You can amend the commit now, with\n"
+			  "\n"
+			  "  git commit --amend %s\n"
+			  "\n"
+			  "Once you are satisfied with your changes, run\n"
+			  "\n"
+			  "  git rebase --continue\n"),
+			gpg_sign_opt_quoted(opts));
 	} else if (exit_code)
-		fprintf(stderr, "Could not apply %s... %.*s\n",
+		fprintf_ln(stderr, _("Could not apply %s... %.*s"),
 			short_commit_name(commit), subject_len, subject);
 
 	return exit_code;
@@ -2716,7 +2718,7 @@ static int do_label(const char *name, int len)
 	struct object_id head_oid;
 
 	if (len == 1 && *name == '#')
-		return error("Illegal label name: '%.*s'", len, name);
+		return error(_("illegal label name: '%.*s'"), len, name);
 
 	strbuf_addf(&ref_name, "refs/rewritten/%.*s", len, name);
 	strbuf_addf(&msg, "rebase -i (label) '%.*s'", len, name);
-- 
2.18.0.rc0.309.g77c7720784

