Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9CB81FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 15:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753129AbdBJPwB (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 10:52:01 -0500
Received: from mout.gmx.net ([212.227.17.20]:58819 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752078AbdBJPv6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 10:51:58 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LzHZ7-1cOY2Z2vbd-014RWu; Fri, 10
 Feb 2017 16:33:42 +0100
Date:   Fri, 10 Feb 2017 16:33:41 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Michael Rappazzo <rappazzo@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 1/2] rev-parse tests: add tests executed from a
 subdirectory
In-Reply-To: <cover.1486740772.git.johannes.schindelin@gmx.de>
Message-ID: <cc23463af8096c5f8429f939ce881cf0eb5c2dcd.1486740772.git.johannes.schindelin@gmx.de>
References: <50fe3ea3302c40f4c96eaa5a568837e3334f9dc4.1486555851.git.johannes.schindelin@gmx.de> <cover.1486740772.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:hbQIByWk5go7JFRQGPKRedWkopDT9ng3Kg/lSZzHLUCoHaeUb+R
 9pLzhkblCD+YNbRT8yyWrTxXU2+VRcmwEueabUZeUwUxfcRjSHHVQA0aAoB5kySeiZZY4J+
 kHugHDCbi7q+KjeKEUEUv6uYKRF7u4BbnEZCTKdfTUKDq3ZqDRfGpJ8AZUfJBSjh+5lXLfh
 vBI6Qz8OWIxKQ9mDdM1Ng==
X-UI-Out-Filterresults: notjunk:1;V01:K0:L9OqoUE5m8w=:iZraNgqJlWgAqh+trhugyu
 uyKMpjLF0rB2z/4zsOhWaJnx5ZxpWtc1FsLAxl9dM4cf14dI3dlGyXWE6hKe/W/NBqSmOT6Me
 xIKG/JHkeGBdpFbcF5y8oWBBSqnJZdOrioTxy2eO4mG+ZmgAuk4ES9frMo5E8JE5wkd4CP4d+
 LuR+ZKZTqHsFutakq/Cs1ySR9EUOgZsJQ+93R2CiQs6TyLghpmFNCrTWtEhIWwPvn6IXbZN6O
 jahPHxsozRqFTapbmVqtLC3yNZq5yxfnAR49slx8n13bB6eCju+7vR4GGy6yCNB9URk9H5j68
 Eewk/eogKtpJ2JU3hZLCLSbsVuENc2I/MFpbq2gY11gCFeF9kGBU7BX0M9p04MUjdyARdxNEM
 mLp2C+m2Ff0mQSLF+hr7D6q5VsAEbWWIFYH/c6XcaFRsr2FRQ1hF/8JfUmwYRueZj15f1hBye
 Ek6yjW0rbPZni+1UkB+iakmLEtUfeu14mOjJqDNbTHSS/ASxmnYBm0Eki3r/y1q+kF58XA26/
 yadkep427/uEe81tRaN2NLl4/iPOjIf9aLd6FIzB3QmPnFuOwxG6Hyy2KxH/2ZKRK5gLBGTHA
 NboAC0/mySEUPZngoeMNpm1i15kbwyRdf3TpeYL7CdH5LDsQE4tDudbZX4bp2+SxQAIPMwMi4
 ZawY/wTKWCq4i94j3Dyqx7+YtchveN24CFxt+KwgbDBKS58dzJLGdcgVg0y8yfJztKSER8BBk
 8AxiInyamE9zUL5Bqv7d2UmWr8HOpEf7O4Yj+76x7/gG3v9ZZit6hcC+FCqmsc0oVE/LwcjE7
 9cNP/n3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Michael Rappazzo <rappazzo@gmail.com>

t2027-worktree-list has an incorrect expectation for --git-common-dir
which has been adjusted and marked to expect failure.

Some of the tests added have been marked to expect failure.  These
demonstrate a problem with the way that some options to git rev-parse
behave when executed from a subdirectory of the main worktree.

[jes: fixed incorrect assumption that objects/ lives in the
worktree-specific git-dir (it lives in the common dir instead).]

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1500-rev-parse.sh     | 28 ++++++++++++++++++++++++++++
 t/t1700-split-index.sh   | 17 +++++++++++++++++
 t/t2027-worktree-list.sh | 12 ++++++++++--
 3 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 038e24c4014..f39f783f2db 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -87,4 +87,32 @@ test_rev_parse -C work -g ../repo.git -b t 'GIT_DIR=../repo.git, core.bare = tru
 
 test_rev_parse -C work -g ../repo.git -b u 'GIT_DIR=../repo.git, core.bare undefined' false false true ''
 
+test_expect_success 'git-common-dir from worktree root' '
+	echo .git >expect &&
+	git rev-parse --git-common-dir >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'git-common-dir inside sub-dir' '
+	mkdir -p path/to/child &&
+	test_when_finished "rm -rf path" &&
+	echo "$(git -C path/to/child rev-parse --show-cdup).git" >expect &&
+	git -C path/to/child rev-parse --git-common-dir >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git-path from worktree root' '
+	echo .git/objects >expect &&
+	git rev-parse --git-path objects >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'git-path inside sub-dir' '
+	mkdir -p path/to/child &&
+	test_when_finished "rm -rf path" &&
+	echo "$(git -C path/to/child rev-parse --show-cdup).git/objects" >expect &&
+	git -C path/to/child rev-parse --git-path objects >actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index 292a0720fcc..1d6e27a09d8 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -200,4 +200,21 @@ EOF
 	test_cmp expect actual
 '
 
+test_expect_failure 'rev-parse --shared-index-path' '
+	rm -rf .git &&
+	test_create_repo . &&
+	git update-index --split-index &&
+	ls -t .git/sharedindex* | tail -n 1 >expect &&
+	git rev-parse --shared-index-path >actual &&
+	test_cmp expect actual &&
+	mkdir work &&
+	test_when_finished "rm -rf work" &&
+	(
+		cd work &&
+		ls -t ../.git/sharedindex* | tail -n 1 >expect &&
+		git rev-parse --shared-index-path >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
diff --git a/t/t2027-worktree-list.sh b/t/t2027-worktree-list.sh
index 465eeeacd3d..c1a072348e7 100755
--- a/t/t2027-worktree-list.sh
+++ b/t/t2027-worktree-list.sh
@@ -8,16 +8,24 @@ test_expect_success 'setup' '
 	test_commit init
 '
 
-test_expect_success 'rev-parse --git-common-dir on main worktree' '
+test_expect_failure 'rev-parse --git-common-dir on main worktree' '
 	git rev-parse --git-common-dir >actual &&
 	echo .git >expected &&
 	test_cmp expected actual &&
 	mkdir sub &&
 	git -C sub rev-parse --git-common-dir >actual2 &&
-	echo sub/.git >expected2 &&
+	echo ../.git >expected2 &&
 	test_cmp expected2 actual2
 '
 
+test_expect_failure 'rev-parse --git-path objects linked worktree' '
+	echo "$(git rev-parse --show-toplevel)/.git/objects" >expect &&
+	test_when_finished "rm -rf linked-tree && git worktree prune" &&
+	git worktree add --detach linked-tree master &&
+	git -C linked-tree rev-parse --git-path objects >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success '"list" all worktrees from main' '
 	echo "$(git rev-parse --show-toplevel) $(git rev-parse --short HEAD) [$(git symbolic-ref --short HEAD)]" >expect &&
 	test_when_finished "rm -rf here && git worktree prune" &&
-- 
2.11.1.windows.1


