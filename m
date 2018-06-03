Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4D781F403
	for <e@80x24.org>; Sun,  3 Jun 2018 16:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751451AbeFCQfI (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 12:35:08 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:43021 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751423AbeFCQfE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 12:35:04 -0400
Received: by mail-lf0-f67.google.com with SMTP id n15-v6so4268772lfn.10
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 09:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DmUbqaiuzoAuTK5kAl4N/VmILHBtekX9fHj7k+KqSgI=;
        b=Y1F/wCjJbb76dDBNfi5GmrzjDbToYYM7ajRXqGMo/E1AuFDss2p6EHfwha7hc/7KmM
         bY0rA/3oGGmLWQQJ+XFQEZtQn34cFSInE0geZvmqNmFgQFvva2bpB25Wyf+cWM0V4XQP
         GzDvg3X0/Gcvene6RO3/drtTXOZ6CEnSsnpZAhYofhHAp0YLfAe+MAnzQ0jF5Cyq65GB
         RyadiBtb/AVDOB39wz6UdM2u7/UoYlQa9c9fZOZJfnrtkqpx9nel7Jakog6wjnvC9e5G
         HEbVxRXmHXmTEY3nPHEHuWt5v1HbrLs4iH92WyLwUtOcXEpHsJ+D/coxdw29krWgatjO
         vjdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DmUbqaiuzoAuTK5kAl4N/VmILHBtekX9fHj7k+KqSgI=;
        b=bqLIScOJOdCD89NiGwByNE8rJeWBKgvGJPnFHhdSPyJt/GtMDsXBi4xF/hkwPVtNMM
         6ISUcRPkiShv+G/FJp3TZdVa+FSzeOzdJKtVwEgYXjrjvo2PEwMMQllWIaqhstcWfnYS
         pf592IgeWaLNZoQrAmg6r6CKksdMxM6WVn0ETEI/TiGhZCYAWocO238m/SMcSHIeKZQY
         plOG7V2MTl/07RHHMkRhGlb4nebuFXDevt0dqOjbRvYtd2NFtfhd9sm7ct9QP0VanI6h
         324QBjrL4B5HOSKpmRFUKjgL6jrBtb7mSxqi9+1t+BIWDe9nQsMMOW5JMNBNEKylF3IR
         P53Q==
X-Gm-Message-State: APt69E0vvqbFny42iFzGjHHpKNLYVwTvKSgwNtB4f98I3NkuVZ6LrEZG
        1/3C4b+vdQDs2y4vCX14G5E=
X-Google-Smtp-Source: ADUXVKI4FjfBVQYE8G7ytn5AdPvG6YV4L2MbOJURkCJqqCRGDPfaD+3vU0glSAycDiiGnUJsq5/Gxg==
X-Received: by 2002:a2e:f01:: with SMTP id 1-v6mr1515905ljp.47.1528043702964;
        Sun, 03 Jun 2018 09:35:02 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id v79-v6sm4726895lfd.32.2018.06.03.09.35.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Jun 2018 09:35:02 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 20/23] sequencer.c: mark more strings for translation
Date:   Sun,  3 Jun 2018 18:34:17 +0200
Message-Id: <20180603163420.13702-21-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180603163420.13702-1-pclouds@gmail.com>
References: <20180602043241.9941-1-pclouds@gmail.com>
 <20180603163420.13702-1-pclouds@gmail.com>
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
index def8ae587f..01f3afe7f4 100644
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
-	die("unknown command: %d", command);
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
-		fprintf_ln(stderr, "Could not apply %s... %.*s",
+		fprintf_ln(stderr, _("Could not apply %s... %.*s"),
 			short_commit_name(commit), subject_len, subject);
 
 	return exit_code;
@@ -2716,7 +2718,7 @@ static int do_label(const char *name, int len)
 	struct object_id head_oid;
 
 	if (len == 1 && *name == '#')
-		return error("illegal label name: '%.*s'", len, name);
+		return error(_("illegal label name: '%.*s'"), len, name);
 
 	strbuf_addf(&ref_name, "refs/rewritten/%.*s", len, name);
 	strbuf_addf(&msg, "rebase -i (label) '%.*s'", len, name);
-- 
2.18.0.rc0.333.g22e6ee6cdf

