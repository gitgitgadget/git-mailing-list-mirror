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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EA4A1F4C1
	for <e@80x24.org>; Mon, 28 Oct 2019 11:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbfJ1LUW (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 07:20:22 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36111 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbfJ1LUV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 07:20:21 -0400
Received: by mail-wr1-f68.google.com with SMTP id w18so9460112wrt.3
        for <git@vger.kernel.org>; Mon, 28 Oct 2019 04:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rf58ctcRegeRy/dZyPcek8fKkPbIZ/4vb0rrrq+UkKA=;
        b=uqCcDZTENIV7xIApEP+QQkMrsgdFt+8WJWyJDdnb9iSEkpfGDzPOJbixHd9vNC3pjh
         2P0SDEmX2iBAcW+UE+XHK73PhzOCtBw3QVvsyXRLP1c8BNzswdigAv8n0mSy8MhI2mgo
         nI6JAW1FO4cz7ykUQm1zZB+LK5mb/lvi7i6vNnl9C93qfaMm+NFphFA1mM4NnygP8TYu
         WHBfGMw3jCWLyYRW7p+Sfon3emHebX3IcZPDBKPmSvl0ZbjXnXkrP08R01XNaXGOeivg
         4IenVeEZvJqkNrKv/9GEQIouoXVNN35HYuurf9k5kQifkp2Iur0vicS4GTz+fRW1r8GV
         5eNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rf58ctcRegeRy/dZyPcek8fKkPbIZ/4vb0rrrq+UkKA=;
        b=f8mvyWa4toFfU72FL//CxSfdjYwdnm/mq5kUfQkAtyhKAxHXCwFaaVEa6FLYLX0kPz
         kCTkaGjXM0QjkIsIW/7nNU+szO/L0FdReOJv5v1kmjPkkz5Hf7TEuQqhZWTleMjfgtIa
         sY0V70+SvnB2tKBx5ur6zftyr+Audag4c3FCDjd1g3ximI7iKav4Cn8iJh5KKCxzhao5
         j06NDEbL5NEna3FYgU3HS0o3v+18YDS4U34/FiwEDVq/v6ODpQN6+CdEG+MH/cGwXBgf
         D+f7UbTUDksPu42U4TBOQ8Nr5xYMF1FfD21MqvZCRou2ozIJZzs1ZcC7Kv5L1K+PU5Hn
         Spew==
X-Gm-Message-State: APjAAAXrqDH6TvTXX0S9uqjA3jacZZcTmnbyQjdK5anFQ8U58FMjVyo1
        NeCsIWNguoE7Cfs0HYPJ9E9RCeXA
X-Google-Smtp-Source: APXvYqyjWc9IcbqSpecwwD1yNOVjQakmgC7/zp8T67NHdsQsal/xru1t5myCztkCtX9Vv/5PO7B7zA==
X-Received: by 2002:adf:f010:: with SMTP id j16mr14958969wro.317.1572261617945;
        Mon, 28 Oct 2019 04:20:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z13sm11091903wrm.64.2019.10.28.04.20.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Oct 2019 04:20:17 -0700 (PDT)
Message-Id: <86dbb11f159375da281acd6266df019106abeadb.1572261615.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.355.v2.git.1572261615.gitgitgadget@gmail.com>
References: <pull.355.git.gitgitgadget@gmail.com>
        <pull.355.v2.git.1572261615.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Oct 2019 11:20:14 +0000
Subject: [PATCH v2 1/2] update-index: optionally leave skip-worktree entries
 alone
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

While `git update-index` mostly ignores paths referring to index entries
whose skip-worktree bit is set, in b4d1690df11 (Teach Git to respect
skip-worktree bit (reading part), 2009-08-20), for reasons that are not
entirely obvious, the `--remove` option was made special: it _does_
remove index entries even if their skip-worktree bit is set.

Seeing as this behavior has been in place for a decade now, it does not
make sense to change it.

However, in preparation for fixing a bug in `git stash` where it
pretends that skip-worktree entries have actually been removed, we need
a mode where `git update-index` leaves all skip-worktree entries alone,
even if the `--remove` option was passed.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-update-index.txt |  6 ++++++
 builtin/update-index.c             |  6 +++++-
 t/t7012-skip-worktree-writing.sh   | 14 ++++++++++++++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 1c4d146a41..08393445e7 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -16,6 +16,7 @@ SYNOPSIS
 	     [--chmod=(+|-)x]
 	     [--[no-]assume-unchanged]
 	     [--[no-]skip-worktree]
+	     [--[no-]ignore-skip-worktree-entries]
 	     [--[no-]fsmonitor-valid]
 	     [--ignore-submodules]
 	     [--[no-]split-index]
@@ -113,6 +114,11 @@ you will need to handle the situation manually.
 	set and unset the "skip-worktree" bit for the paths. See
 	section "Skip-worktree bit" below for more information.
 
+
+--[no-]ignore-skip-worktree-entries::
+	Do not remove skip-worktree (AKA "index-only") entries even when
+	the `--remove` option was specified.
+
 --[no-]fsmonitor-valid::
 	When one of these flags is specified, the object name recorded
 	for the paths are not updated. Instead, these options
diff --git a/builtin/update-index.c b/builtin/update-index.c
index dff2f4b837..074d563df0 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -35,6 +35,7 @@ static int verbose;
 static int mark_valid_only;
 static int mark_skip_worktree_only;
 static int mark_fsmonitor_only;
+static int ignore_skip_worktree_entries;
 #define MARK_FLAG 1
 #define UNMARK_FLAG 2
 static struct strbuf mtime_dir = STRBUF_INIT;
@@ -381,7 +382,8 @@ static int process_path(const char *path, struct stat *st, int stat_errno)
 		 * so updating it does not make sense.
 		 * On the other hand, removing it from index should work
 		 */
-		if (allow_remove && remove_file_from_cache(path))
+		if (!ignore_skip_worktree_entries && allow_remove &&
+		    remove_file_from_cache(path))
 			return error("%s: cannot remove from the index", path);
 		return 0;
 	}
@@ -1013,6 +1015,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		{OPTION_SET_INT, 0, "no-skip-worktree", &mark_skip_worktree_only, NULL,
 			N_("clear skip-worktree bit"),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, UNMARK_FLAG},
+		OPT_BOOL(0, "ignore-skip-worktree-entries", &ignore_skip_worktree_entries,
+			 N_("do not touch index-only entries")),
 		OPT_SET_INT(0, "info-only", &info_only,
 			N_("add to index only; do not add content to object database"), 1),
 		OPT_SET_INT(0, "force-remove", &force_remove,
diff --git a/t/t7012-skip-worktree-writing.sh b/t/t7012-skip-worktree-writing.sh
index 9d1abe50ef..28b1b0b2b9 100755
--- a/t/t7012-skip-worktree-writing.sh
+++ b/t/t7012-skip-worktree-writing.sh
@@ -134,6 +134,20 @@ test_expect_success 'git-clean, dirty case' '
 	test_i18ncmp expected result
 '
 
+test_expect_success '--ignore-skip-worktree-entries leaves worktree alone' '
+	test_commit geroff-me &&
+	git update-index --skip-worktree geroff-me.t &&
+	rm geroff-me.t &&
+
+	: ignoring the worktree &&
+	git update-index --remove --ignore-skip-worktree-entries geroff-me.t &&
+	git diff-index --cached --exit-code HEAD &&
+
+	: not ignoring the worktree, a deletion is staged &&
+	git update-index --remove geroff-me.t &&
+	test_must_fail git diff-index --cached --exit-code HEAD
+'
+
 #TODO test_expect_failure 'git-apply adds file' false
 #TODO test_expect_failure 'git-apply updates file' false
 #TODO test_expect_failure 'git-apply removes file' false
-- 
gitgitgadget

