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
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CA391F454
	for <e@80x24.org>; Tue,  5 Nov 2019 17:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390367AbfKERHm (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 12:07:42 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:41936 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388983AbfKERHl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 12:07:41 -0500
Received: by mail-wr1-f51.google.com with SMTP id p4so22291749wrm.8
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 09:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RNTLds/q9TLhbJaJE58Es0K92GjK4xXk4bCGiItcte4=;
        b=Sjqo4lbarA46tfvtcgE/5D+BqrfgubGTytJJRChiIyn41obd041NxAIT/YqNQb2ZVo
         fDrkwvCHfn/KYw4MYEPXj7p/MvGf0JO4t5WY3OFxka55srJqfvIaii101K1Q1ILfnnBr
         d+SZVJ2MAT5rz3jThQyIiVB/hvAHQ1DqhRz3ntwceSOlIBA70G2GxLv0Z8dUIoxZK+J1
         IM3z8+l4rvIrdM1JYTSnfsRAj5fVMr4yGzbcFyY+ircIm0da9EiFk0s8B9YC4QaxZICu
         SBzYCLZ/LxcPcEtLN9FanVIpSdP06y5hx3Vc9Lz5Hib5nSnsodTJpUO8l21b/FdqcxFq
         YtkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RNTLds/q9TLhbJaJE58Es0K92GjK4xXk4bCGiItcte4=;
        b=jKyLcdmx5F0wUZKxrjOiZIyCTh6qcr2HVIYXuvLjNZ3oBZkZDKYvYvoBJ+4507aa3s
         PbW6z6FjdRwq14VcQvoh0fxE7EcRmUvnWOUogQ39zEhNF5vxpcJj3FzgW8TNNLw2NPz1
         mmfKB2pOWpC6I9TXsP0l7QbguUkQRvcP4d5U48aB6CHlzP+SYluNFPGm90fbiaIonblf
         D1JiAr1hajQLboERfCYL0U1CpRgAth8WtMb3vxbZtGRiUx6KpT+bLth7GBO9LViIzgIL
         fIvDqXft0qBAa5AORw8EDoD4UJIXnN6c5yFXXVbHilXKQeF/o2XA1q8+0DJaxCqrbpD4
         pBmA==
X-Gm-Message-State: APjAAAUYKUqgqGsBlxijU0bnx4OlbSfecDmGOjqFK7GNmLr/FmTUStih
        Aj2NA1wubFlYvW+9NN1kqAjK12VY
X-Google-Smtp-Source: APXvYqxBAjRQw0WnyGdw5YYpTHgMh6q3EZlTUqVu7sk8NHmeV7DVMxuHTDE9hqdh9yx9KqA7FQV6xA==
X-Received: by 2002:a05:6000:18e:: with SMTP id p14mr1670503wrx.98.1572973658860;
        Tue, 05 Nov 2019 09:07:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c15sm18787992wmb.45.2019.11.05.09.07.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 09:07:38 -0800 (PST)
Message-Id: <6e6e5ad54931d33533d3367ba9124493c1e1ab7d.1572973652.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.418.v2.git.1572973650.gitgitgadget@gmail.com>
References: <pull.418.git.1571790574.gitgitgadget@gmail.com>
        <pull.418.v2.git.1572973650.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Nov 2019 17:07:24 +0000
Subject: [PATCH v2 05/11] Fix spelling errors in comments of testcases
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Reported-by: Jens Schleusener <Jens.Schleusener@fossies.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t0000-basic.sh                    | 2 +-
 t/t0027-auto-crlf.sh                | 2 +-
 t/t0500-progress-display.sh         | 4 ++--
 t/t1512-rev-parse-disambiguation.sh | 2 +-
 t/t4100/t-apply-3.patch             | 2 +-
 t/t4100/t-apply-7.patch             | 2 +-
 t/t4213-log-tabexpand.sh            | 2 +-
 t/t5528-push-default.sh             | 2 +-
 t/t5702-protocol-v2.sh              | 4 ++--
 t/t6043-merge-rename-directories.sh | 6 +++---
 t/t7519-status-fsmonitor.sh         | 2 +-
 t/t9350-fast-export.sh              | 2 +-
 t/t9809-git-p4-client-view.sh       | 2 +-
 t/t9902-completion.sh               | 2 +-
 14 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 4d3f7ba295..7aabde1a69 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -126,7 +126,7 @@ check_sub_test_lib_test () {
 
 check_sub_test_lib_test_err () {
 	name="$1" # stdin is the expected output from the test
-	# expected error output is in descriptior 3
+	# expected error output is in descriptor 3
 	(
 		cd "$name" &&
 		sed -e 's/^> //' -e 's/Z$//' >expect.out &&
diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index 959b6da449..9fcd56fab3 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -215,7 +215,7 @@ stats_ascii () {
 }
 
 
-# contruct the attr/ returned by git ls-files --eol
+# construct the attr/ returned by git ls-files --eol
 # Take none (=empty), one or two args
 # convert.c: eol=XX overrides text=auto
 attr_ascii () {
diff --git a/t/t0500-progress-display.sh b/t/t0500-progress-display.sh
index 24ccbd8d3b..d2d088d9a0 100755
--- a/t/t0500-progress-display.sh
+++ b/t/t0500-progress-display.sh
@@ -76,7 +76,7 @@ EOF
 '
 
 test_expect_success 'progress display breaks long lines #2' '
-	# Note: we dont need that many spaces after the title to cover up
+	# Note: we do not need that many spaces after the title to cover up
 	# the last line before breaking the progress line.
 	sed -e "s/Z$//" >expect <<\EOF &&
 Working hard.......2.........3.........4.........5.........6:   0% (1/100000)<CR>
@@ -104,7 +104,7 @@ EOF
 '
 
 test_expect_success 'progress display breaks long lines #3 - even the first is too long' '
-	# Note: we dont actually need any spaces at the end of the title
+	# Note: we do not actually need any spaces at the end of the title
 	# line, because there is no previous progress line to cover up.
 	sed -e "s/Z$//" >expect <<\EOF &&
 Working hard.......2.........3.........4.........5.........6:                   Z
diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index c19fb500cb..25744e270a 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -339,7 +339,7 @@ test_expect_success C_LOCALE_OUTPUT 'ambiguity hints' '
 test_expect_success C_LOCALE_OUTPUT 'ambiguity hints respect type' '
 	test_must_fail git rev-parse 000000000^{commit} 2>stderr &&
 	grep ^hint: stderr >hints &&
-	# 5 commits, 1 tag (which is a commitish), plus intro line
+	# 5 commits, 1 tag (which is a committish), plus intro line
 	test_line_count = 7 hints
 '
 
diff --git a/t/t4100/t-apply-3.patch b/t/t4100/t-apply-3.patch
index 90cdbaa5bb..cac172e779 100644
--- a/t/t4100/t-apply-3.patch
+++ b/t/t4100/t-apply-3.patch
@@ -211,7 +211,7 @@ dissimilarity index 82%
 -
 -		/* If this is an exact directory match, we may have
 -		 * directory files following this path. Match on them.
--		 * Otherwise, we're at a pach subcomponent, and we need
+-		 * Otherwise, we're at a patch subcomponent, and we need
 -		 * to try to match again.
 -		 */
 -		if (mtype == 0)
diff --git a/t/t4100/t-apply-7.patch b/t/t4100/t-apply-7.patch
index 07c6589e74..fa24305108 100644
--- a/t/t4100/t-apply-7.patch
+++ b/t/t4100/t-apply-7.patch
@@ -335,7 +335,7 @@ diff a/ls-tree.c b/ls-tree.c
  
 -		/* If this is an exact directory match, we may have
 -		 * directory files following this path. Match on them.
--		 * Otherwise, we're at a pach subcomponent, and we need
+-		 * Otherwise, we're at a patch subcomponent, and we need
 -		 * to try to match again.
 +	if (e->directory) {
 +		/* If this is a directory, we have the following cases:
diff --git a/t/t4213-log-tabexpand.sh b/t/t4213-log-tabexpand.sh
index 7f90f58c03..53a4af3244 100755
--- a/t/t4213-log-tabexpand.sh
+++ b/t/t4213-log-tabexpand.sh
@@ -36,7 +36,7 @@ count_expand ()
 	esac
 
 	# Prefix the output with the command line arguments, and
-	# replace SP with a dot both in the expecte and actual output
+	# replace SP with a dot both in the expected and actual output
 	# so that test_cmp would show the difference together with the
 	# breakage in a way easier to consume by the debugging user.
 	{
diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
index 44309566f1..4d1e0c363e 100755
--- a/t/t5528-push-default.sh
+++ b/t/t5528-push-default.sh
@@ -163,7 +163,7 @@ test_pushdefault_workflow success current master
 # update parent1's foo (which is our upstream)
 test_pushdefault_workflow success upstream foo
 
-# upsream is foo which is not the name of the current branch
+# upstream is foo which is not the name of the current branch
 test_pushdefault_workflow failure simple master
 
 # master and foo are updated
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index ae9175cedf..96f58e40b6 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -682,9 +682,9 @@ test_expect_success 'push with http:// and a config of v2 does not request v2' '
 	git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" log -1 --format=%s client_branch >expect &&
 	test_cmp expect actual &&
 
-	# Client didnt request to use protocol v2
+	# Client did not request to use protocol v2
 	! grep "Git-Protocol: version=2" log &&
-	# Server didnt respond using protocol v2
+	# Server did not respond using protocol v2
 	! grep "git< version 2" log
 '
 
diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
index c966147d5d..df321cab78 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -744,7 +744,7 @@ test_expect_success '3b-check: Avoid implicit rename if involved as source on cu
 #
 # What if we were to attempt to do directory rename detection when someone
 # "mostly" moved a directory but still left some files around, or,
-# equivalently, fully renamed a directory in one commmit and then recreated
+# equivalently, fully renamed a directory in one commit and then recreated
 # that directory in a later commit adding some new files and then tried to
 # merge?
 #
@@ -941,7 +941,7 @@ test_expect_success '5a-check: Merge directories, other side adds files to origi
 #   Commit B: z/{b,c,d_1,e}, y/d_3
 #   Expected: y/{b,c,e}, CONFLICT(add/add: y/d_2 vs. y/d_3)
 #   NOTE: If z/d_1 in commit B were to be involved in dir rename detection, as
-#         we normaly would since z/ is being renamed to y/, then this would be
+#         we normally would since z/ is being renamed to y/, then this would be
 #         a rename/delete (z/d_1 -> y/d_1 vs. deleted) AND an add/add/add
 #         conflict of y/d_1 vs. y/d_2 vs. y/d_3.  Add/add/add is not
 #         representable in the index, so the existence of y/d_3 needs to
@@ -2089,7 +2089,7 @@ test_expect_success '8b-check: Dual-directory rename, one into the others way, w
 #
 #   Note: It could easily be argued that the correct resolution here is
 #         y/{b,c,e}, CONFLICT(rename/delete: z/d -> y/d vs deleted)
-#         and that the modifed version of d should be present in y/ after
+#         and that the modified version of d should be present in y/ after
 #         the merge, just marked as conflicted.  Indeed, I previously did
 #         argue that.  But applying directory renames to the side of
 #         history where a file is merely modified results in spurious
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index 997d5fb349..1e47ed2ca2 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -294,7 +294,7 @@ do
 	done
 done
 
-# test that splitting the index dosn't interfere
+# test that splitting the index doesn't interfere
 test_expect_success 'splitting the index results in the same state' '
 	write_integration_script &&
 	dirty_repo &&
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 2e4e214815..db084fe625 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -541,7 +541,7 @@ test_expect_success 'tree_tag'        '
 
 # NEEDSWORK: not just check return status, but validate the output
 # Note that these tests DO NOTHING other than print a warning that
-# they are ommitting the one tag we asked them to export (because the
+# they are omitting the one tag we asked them to export (because the
 # tags resolve to a tree).  They exist just to make sure we do not
 # abort but instead just warn.
 test_expect_success 'tree_tag-obj'    'git fast-export tree_tag-obj'
diff --git a/t/t9809-git-p4-client-view.sh b/t/t9809-git-p4-client-view.sh
index 3cff1fce1b..9c9710d8c7 100755
--- a/t/t9809-git-p4-client-view.sh
+++ b/t/t9809-git-p4-client-view.sh
@@ -407,7 +407,7 @@ test_expect_success 'reinit depot' '
 '
 
 #
-# What happens when two files of the same name are overlayed together?
+# What happens when two files of the same name are overlaid together?
 # The last-listed file should take preference.
 #
 # //depot
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 54f8ce18cb..e4af70aff1 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1257,7 +1257,7 @@ test_path_completion ()
 		# In the following tests calling this function we only
 		# care about how __git_complete_index_file() deals with
 		# unusual characters in path names.  By requesting only
-		# untracked files we dont have to bother adding any
+		# untracked files we do not have to bother adding any
 		# paths to the index in those tests.
 		__git_complete_index_file --others &&
 		print_comp
-- 
gitgitgadget

