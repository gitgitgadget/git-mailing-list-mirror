Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E8201F453
	for <e@80x24.org>; Sat,  3 Nov 2018 11:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbeKCVER (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 17:04:17 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43164 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbeKCVEQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 17:04:16 -0400
Received: by mail-pl1-f194.google.com with SMTP id g59-v6so2203455plb.10
        for <git@vger.kernel.org>; Sat, 03 Nov 2018 04:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jLfdHDQ0xm7BVvKfEWNXdkQ0oEhGFgNFKbcaeONDGRU=;
        b=iOXXRg0jMESZWicN1tFm3lPLSnUCn+a+hpajWEJNvNQ99TFlT6DPoSd0z6nWm2bkh8
         el3ilCRgp23VOxW5V0+ZMdLuHCMo+nsILhTJHCofBcGRu5e6mQHJ+ddlnhO4wNMADjQI
         JGvCiK/SiWBF27eK9+VAdWD3v2Z3cCUZFz5+9xiBFp4Gw1CUr5i+sl3s8dGNoHeH2HCc
         oIGCaNuBT8WYA/SDqaoca13Rc2X2+qTdz6mmIDlSGvFO9CrJD8y5U4omWFC9hU3pCM9s
         w0s/v5HrfUz1NjiNcQgOFF8YDu0lZp+tOaoTRX4A0rzGzFMln9A3oYXQyj+IoWIegJ01
         Ya6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jLfdHDQ0xm7BVvKfEWNXdkQ0oEhGFgNFKbcaeONDGRU=;
        b=IWSd+199FCKMp84uem8/WuB6z3MXBgzx3vu0/YDAphvjBbqbsttfG9SycalQ2qKmGt
         VhWhFFUAn9SxRc/x6qlTHAedcGjtIRImAGyhXp+URHFPmCFiXdLZSeUajPE8j+YkhuCF
         qQo2gzfQGuVIzMzkyGQY9djNQ651sGxGxrGgiCXc1ChfiXCiSevrOvxRYbBZsKfMWxvB
         2pEg3vtP43yukMoDtmluTHP+8xG5bPVcEJhETFXohZ3+C/9Mo8bkQrGRhPKOHGFKRK4i
         Q3KTsRd5xfKUQMplAzZ/yCsQlYQCb5MABH6yzz4tdiuPw/XSUngPY6lF4oU5NYUhrhRt
         EwWQ==
X-Gm-Message-State: AGRZ1gIgqMrnofsY8/dDr08q+Gfq8zPuCbQhAtX9oyMLziJCRgfxh52G
        XDYMb2uL7Mfun3GperXU4+F996J3
X-Google-Smtp-Source: AJdET5c/cx5kb05fJmvx3efmoUqL9RD+i7JRfSkgmfaHALfWUu1yPXg2oUruX0vkx49LmORoi1Tq1Q==
X-Received: by 2002:a17:902:9693:: with SMTP id n19-v6mr15268037plp.20.1541245991354;
        Sat, 03 Nov 2018 04:53:11 -0700 (PDT)
Received: from localhost.localdomain ([183.82.20.190])
        by smtp.gmail.com with ESMTPSA id i12-v6sm41290187pfe.7.2018.11.03.04.53.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 04:53:10 -0700 (PDT)
From:   tanushree27 <tanushreetumane@gmail.com>
To:     git@vger.kernel.org
Cc:     tanushree27 <tanushreetumane@gmail.com>
Subject: [[PATCH v2]] commit: add a commit.allowempty config variable
Date:   Sat,  3 Nov 2018 17:23:00 +0530
Message-Id: <20181103115300.6518-1-tanushreetumane@gmail.com>
X-Mailer: git-send-email 2.19.1.windows.1.495.g7e9d1c442b.dirty
In-Reply-To: <20181103112535.5730-1-tanushreetumane@gmail.com>
References: <20181103112535.5730-1-tanushreetumane@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add commit.allowempty configuration variable as a convenience for those
who always prefer --allow-empty.

Add tests to check the behavior introduced by this commit.

This closes https://github.com/git-for-windows/git/issues/1854

Signed-off-by: tanushree27 <tanushreetumane@gmail.com>
---
 Documentation/config.txt     |  5 +++++
 Documentation/git-commit.txt |  3 ++-
 builtin/commit.c             |  8 ++++++++
 t/t7500-commit.sh            | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c0727b7866..ac63b12ab3 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1467,6 +1467,11 @@ commit.verbose::
 	A boolean or int to specify the level of verbose with `git commit`.
 	See linkgit:git-commit[1].
 
+commit.allowempty::
+	A boolean to specify whether empty commits are allowed with `git
+	commit`. See linkgit:git-commit[1]. 
+	Defaults to false.
+
 credential.helper::
 	Specify an external helper to be called when a username or
 	password credential is needed; the helper may consult external
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index f970a43422..07a5b60ab9 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -176,7 +176,8 @@ The `-m` option is mutually exclusive with `-c`, `-C`, and `-F`.
 	Usually recording a commit that has the exact same tree as its
 	sole parent commit is a mistake, and the command prevents you
 	from making such a commit.  This option bypasses the safety, and
-	is primarily for use by foreign SCM interface scripts.
+	is primarily for use by foreign SCM interface scripts. See
+	`commit.allowempty` in linkgit:git-config[1].
 
 --allow-empty-message::
        Like --allow-empty this command is primarily for use by foreign
diff --git a/builtin/commit.c b/builtin/commit.c
index 67fa949204..4516309ac2 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -101,6 +101,7 @@ static int all, also, interactive, patch_interactive, only, amend, signoff;
 static int edit_flag = -1; /* unspecified */
 static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
 static int config_commit_verbose = -1; /* unspecified */
+static int config_commit_allow_empty = -1; /* unspecified */
 static int no_post_rewrite, allow_empty_message;
 static char *untracked_files_arg, *force_date, *ignore_submodule_arg, *ignored_arg;
 static char *sign_commit;
@@ -1435,6 +1436,10 @@ static int git_commit_config(const char *k, const char *v, void *cb)
 		config_commit_verbose = git_config_bool_or_int(k, v, &is_bool);
 		return 0;
 	}
+	if (!strcmp(k, "commit.allowempty")) {
+		config_commit_allow_empty = git_config_bool(k, v);
+		return 0;
+	}
 
 	status = git_gpg_config(k, v, NULL);
 	if (status)
@@ -1556,6 +1561,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	if (verbose == -1)
 		verbose = (config_commit_verbose < 0) ? 0 : config_commit_verbose;
 
+	if (config_commit_allow_empty >= 0)  /* if allowEmpty is allowed in config*/
+		allow_empty = config_commit_allow_empty;
+	
 	if (dry_run)
 		return dry_run_commit(argc, argv, prefix, current_head, &s);
 	index_file = prepare_index(argc, argv, prefix, current_head, 0);
diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
index 170b4810e0..fb9bfbfb03 100755
--- a/t/t7500-commit.sh
+++ b/t/t7500-commit.sh
@@ -359,4 +359,36 @@ test_expect_success 'new line found before status message in commit template' '
 	test_i18ncmp expected-template editor-input
 '
 
+# Tests for commit.allowempty config
+
+test_expect_success "no commit.allowempty and no --allow-empty" "
+	test_must_fail git commit -m 'test'
+"
+
+test_expect_success "no commit.allowempty and --allow-empty" "
+	git commit --allow-empty -m 'test'
+"
+
+for i in true 1
+do
+	test_expect_success "commit.allowempty=$i and no --allow-empty" "
+		git -c commit.allowempty=$i commit -m 'test'
+	"
+
+	test_expect_success "commit.allowempty=$i and --allow-empty" "
+		git -c commit.allowempty=$i commit --allow-empty -m 'test'
+	"
+done
+
+for i in false 0
+do
+	test_expect_success "commit.allowempty=$i and no --allow-empty" "
+		test_must_fail git -c commit.allowempty=$i commit -m 'test'
+	"
+
+	test_expect_success "commit.allowempty=$i and --allow-empty" "
+		test_must_fail git -c commit.allowempty=$i commit --allow-empty -m 'test'
+	"
+done
+
 test_done
-- 
2.19.1.windows.1.495.gd17cbd8b09

