Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6239520248
	for <e@80x24.org>; Sun,  3 Mar 2019 17:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfCCRMA (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 12:12:00 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42210 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfCCRL5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 12:11:57 -0500
Received: by mail-ed1-f67.google.com with SMTP id j89so2303754edb.9
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 09:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=g+pGs+pPQS4yupX4F+r6Rl4wu7svmR1go94XtrRFlIY=;
        b=MPBvQxg1koAEFAjys1DbBbxUYzgBGVUxmamnznFezsN2g87lSfp/WcXEZhUVTHKa90
         aFbatdUPG4RPeR0TP/0aHVM1evU/JfHZb4OBNaePvBJV/F/UcWN/sU6uuFX7f3vKdfTw
         9QSmjBs8eveLru7Y22FSURskENAeHFPZMhr2Wj9BsQr/2g5QPyxA+cIJEphAqnWzzcsC
         /WGiBYPYJ3a03hbLBrjyWsklMliDJ/581xcBtdjqKMi9vOcA7mGCdr5ha0CTWPXuzUBc
         YSSojjc2aK5o7qXUTan2E6+qhqA2XzRS7Y2g5utWsy4ZVuvyynRPMCEdHuqIuwTrUpzQ
         TbqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=g+pGs+pPQS4yupX4F+r6Rl4wu7svmR1go94XtrRFlIY=;
        b=jmPi425OKBXTC1SlmCAuJnk6wmWdeGc7w5yCnwSxLydf3Stlz8X7BDouoyiWR54pOz
         LlAcoWc8u7So6W05i5xZLDwVIu326R3wZVTH6QxyTk41xABuUMffI4N2yFLcKBM4bGe4
         mm3lIJZcz5lfSNZ1r30kTAx45ddfKE6Oy1zylTM6b/PGsKImkvLv5v5sS1p89RKc1D9C
         2XAfau76x8yd1l/7kQ84zULGNl6ak4pRZ0rdAiMlE5t8qYk5nIA5o87gaLQdE62XvU8s
         GDYxGDY8m+j2YVOH9h8mRX8sFi1LGyyEif9QJTqBEfrabph+WvxykPlOEzy94a40uZMz
         AA5Q==
X-Gm-Message-State: APjAAAUMTr7lh8tzs0hGb57oMeIpj1TpIrK5IeQW7QlfSKDiPIkjFizy
        PBseycDRlIjOEC6TjzWIncKK1PoL
X-Google-Smtp-Source: APXvYqyDagq1jLzhv8plq8r8pXR6d5PJaLcl34KBGc/mSZKWzsIw/vjX//HMIE5G8P25qz2cVW572Q==
X-Received: by 2002:a50:b1b7:: with SMTP id m52mr12507900edd.18.1551633115875;
        Sun, 03 Mar 2019 09:11:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z39sm1365338edc.96.2019.03.03.09.11.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 09:11:55 -0800 (PST)
Date:   Sun, 03 Mar 2019 09:11:55 -0800 (PST)
X-Google-Original-Date: Sun, 03 Mar 2019 17:11:52 GMT
Message-Id: <7891c05f51583e2391c74753c0377ed416314b8c.1551633112.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.153.v2.git.gitgitgadget@gmail.com>
References: <pull.153.git.gitgitgadget@gmail.com>
        <pull.153.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 4/4] built-in rebase: set ORIG_HEAD just once, before the
 rebase
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Nazri Ramliy <ayiehere@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Technically, the scripted version set ORIG_HEAD only in two spots (which
really could have been one, because it called `git checkout $onto^0` to
start the rebase and also if it could take a shortcut, and in both cases
it called `git update-ref $orig_head`).

Practically, it *implicitly* reset ORIG_HEAD whenever `git reset --hard`
was called.

However, what we really want is that it is set exactly once, at the
beginning of the rebase.

So let's do that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c  | 31 ++++++++++++++++++-------------
 t/t3400-rebase.sh |  2 +-
 2 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index aa469ec964..0f4e1ead49 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -369,6 +369,7 @@ static void add_var(struct strbuf *buf, const char *name, const char *value)
 #define RESET_HEAD_DETACH (1<<0)
 #define RESET_HEAD_HARD (1<<1)
 #define RESET_HEAD_REFS_ONLY (1<<2)
+#define RESET_ORIG_HEAD (1<<3)
 
 static int reset_head(struct object_id *oid, const char *action,
 		      const char *switch_to_branch, unsigned flags,
@@ -377,6 +378,7 @@ static int reset_head(struct object_id *oid, const char *action,
 	unsigned detach_head = flags & RESET_HEAD_DETACH;
 	unsigned reset_hard = flags & RESET_HEAD_HARD;
 	unsigned refs_only = flags & RESET_HEAD_REFS_ONLY;
+	unsigned update_orig_head = flags & RESET_ORIG_HEAD;
 	struct object_id head_oid;
 	struct tree_desc desc[2] = { { NULL }, { NULL } };
 	struct lock_file lock = LOCK_INIT;
@@ -453,18 +455,21 @@ static int reset_head(struct object_id *oid, const char *action,
 	strbuf_addf(&msg, "%s: ", reflog_action ? reflog_action : "rebase");
 	prefix_len = msg.len;
 
-	if (!get_oid("ORIG_HEAD", &oid_old_orig))
-		old_orig = &oid_old_orig;
-	if (!get_oid("HEAD", &oid_orig)) {
-		orig = &oid_orig;
-		if (!reflog_orig_head) {
-			strbuf_addstr(&msg, "updating ORIG_HEAD");
-			reflog_orig_head = msg.buf;
-		}
-		update_ref(reflog_orig_head, "ORIG_HEAD", orig, old_orig, 0,
-			   UPDATE_REFS_MSG_ON_ERR);
-	} else if (old_orig)
-		delete_ref(NULL, "ORIG_HEAD", old_orig, 0);
+	if (update_orig_head) {
+		if (!get_oid("ORIG_HEAD", &oid_old_orig))
+			old_orig = &oid_old_orig;
+		if (!get_oid("HEAD", &oid_orig)) {
+			orig = &oid_orig;
+			if (!reflog_orig_head) {
+				strbuf_addstr(&msg, "updating ORIG_HEAD");
+				reflog_orig_head = msg.buf;
+			}
+			update_ref(reflog_orig_head, "ORIG_HEAD", orig,
+				   old_orig, 0, UPDATE_REFS_MSG_ON_ERR);
+		} else if (old_orig)
+			delete_ref(NULL, "ORIG_HEAD", old_orig, 0);
+	}
+
 	if (!reflog_head) {
 		strbuf_setlen(&msg, prefix_len);
 		strbuf_addstr(&msg, "updating HEAD");
@@ -1725,7 +1730,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	strbuf_addf(&msg, "%s: checkout %s",
 		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT), options.onto_name);
 	if (reset_head(&options.onto->object.oid, "checkout", NULL,
-		       RESET_HEAD_DETACH, NULL, msg.buf))
+		       RESET_HEAD_DETACH | RESET_ORIG_HEAD, NULL, msg.buf))
 		die(_("Could not detach HEAD"));
 	strbuf_release(&msg);
 
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 7e8d5bb200..460d0523be 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -59,7 +59,7 @@ test_expect_success 'rebase against master' '
 	git rebase master
 '
 
-test_expect_failure 'rebase sets ORIG_HEAD to pre-rebase state' '
+test_expect_success 'rebase sets ORIG_HEAD to pre-rebase state' '
 	git checkout -b orig-head topic &&
 	pre="$(git rev-parse --verify HEAD)" &&
 	git rebase master &&
-- 
gitgitgadget
