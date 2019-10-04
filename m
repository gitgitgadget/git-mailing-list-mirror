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
	by dcvr.yhbt.net (Postfix) with ESMTP id C6BD11F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 21:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbfJDVly (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 17:41:54 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42810 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfJDVly (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 17:41:54 -0400
Received: by mail-wr1-f68.google.com with SMTP id n14so8767261wrw.9
        for <git@vger.kernel.org>; Fri, 04 Oct 2019 14:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bHcOjCoyERkzwy/GcF2mEtiRQ9pVZDHt02wedx+0TNM=;
        b=pT9X4B+NmmJ2KAbvH9pOK0FOMLfeFDJFj5Px8RXq9bgE4JF+tnw47mCNap7oCbBej4
         PP1YTe3rTp2hjC6LxtBR4uI4f6L3BdQ3b1NLJ2espt1FFkKc2Fo901HBZyhTRc1FvXCC
         nTcOVMJpd6L9mQNc8YDhB8BpOgB50HxV7aN+YElxCu9cYWqDC/5Aol/IaHrLP3knrZUg
         UPAbYUbPShKcroWpiHhTQT/l9kLjdFf/St8/o7YR7+rUjuTJHTDF9t8VmgfLDuwap5Lp
         2y0lqjyD6ypUcUA4pxVR/vtsNzbmQu+4xPDa3ZAG3QF1r8sQrmEWlB7er+zSPuathrIA
         Hb8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bHcOjCoyERkzwy/GcF2mEtiRQ9pVZDHt02wedx+0TNM=;
        b=ccuXrkQnRjFKTH+XDKLdehOA9JmTeG9YJXjm1cskL30xDu9k9028boRditYyWXK8td
         /jczFs9eXanPqZwHGn+g8KX3x7qXK7SoMRNazIBp2XQKUU3Be0IEA4E8qzS6/DQDf7lw
         pAOD2Bhbe5R3/RmO6QdRgVECKMRYMnAOpGyPsXuaj5HS+6i2wzh14MquovwwaAB3/tSz
         fS6CnLzYwfoeAKrMyJvTQmcwgwKGZUHhHE2vt/62pAdWG1EONn9VldYxSwY/V7DiW+To
         FmyxlnFCFMbSUgiLoCt77eI0i2LrYmUe/4Ji4f082r1HjX3lZRUC8MSGM7Jdg1btksjC
         gaVA==
X-Gm-Message-State: APjAAAW9ibCGW0pQQ0eeyVTfwj/5dF+58WEI3+60/XYCKSUfB4o5gMNp
        Wp0kaOieUsrQPImnwnQOxg1GOaK/
X-Google-Smtp-Source: APXvYqxjuj2iao6cdK9reDq2HW/mKj86rQpr7NEFftBm7vgULM0COYPOj8MPakJBAWGBlT21zd/HtQ==
X-Received: by 2002:adf:aa87:: with SMTP id h7mr646750wrc.112.1570225312817;
        Fri, 04 Oct 2019 14:41:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v7sm6888972wrr.4.2019.10.04.14.41.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 14:41:52 -0700 (PDT)
Date:   Fri, 04 Oct 2019 14:41:52 -0700 (PDT)
X-Google-Original-Date: Fri, 04 Oct 2019 21:41:50 GMT
Message-Id: <65c2fa33e1aeec03930921ee0ef562d3f9dc5ccf.1570225311.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.361.v3.git.gitgitgadget@gmail.com>
References: <pull.361.v2.git.gitgitgadget@gmail.com>
        <pull.361.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 1/1] Fix gitdir e.g. to respect core.hooksPath
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Bert Wesarg <bert.wesarg@googlemail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>

Since v2.9.0, Git knows about the config variable core.hookspath
that allows overriding the path to the directory containing the
Git hooks.

Since v2.10.0, the `--git-path` option respects that config
variable, too, so we may just as well use that command.

For Git versions older than v2.5.0 (which was the first version to
support the `--git-path` option for the `rev-parse` command), we
simply fall back to the previous code.

An original patch handled only the hooksPath setting, however, during
the code submission it was deemed better to fix all call to the `gitdir`
function.

To avoid spawning a gazillion `git rev-parse --git-path` instances, we
cache the returned paths, priming the cache upon startup in a single
`git rev-parse invocation` with the known entries.

This fixes https://github.com/git-for-windows/git/issues/1755

Initial-patch-by: Philipp Gortan <philipp@gortan.org>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-gui.sh | 52 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index fd476b6999..8b72e59cd0 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -158,6 +158,7 @@ if {[tk windowingsystem] eq "aqua"} {
 
 set _appname {Git Gui}
 set _gitdir {}
+array set _gitdir_cache {}
 set _gitworktree {}
 set _isbare {}
 set _gitexec {}
@@ -197,12 +198,57 @@ proc appname {} {
 	return $_appname
 }
 
+proc prime_gitdir_cache {} {
+	global _gitdir _gitdir_cache
+
+	set gitdir_cmd [list git rev-parse --git-dir]
+
+	# `--git-path` is only supported since Git v2.5.0
+	if {[package vcompare $::_git_version 2.5.0] >= 0} {
+		set gitdir_keys [list \
+			CHERRY_PICK_HEAD FETCH_HEAD GITGUI_BCK GITGUI_EDITMSG \
+			GITGUI_MSG HEAD hooks hooks/prepare-commit-msg \
+			index.lock info info/exclude logs MERGE_HEAD MERGE_MSG \
+			MERGE_RR objects "objects/4\[0-1\]/*" \
+			"objects/4\[0-3\]/*" objects/info \
+			objects/info/alternates objects/pack packed-refs \
+			PREPARE_COMMIT_MSG rebase-merge/head-name remotes \
+			rr-cache rr-cache/MERGE_RR SQUASH_MSG \
+		]
+
+		foreach key $gitdir_keys {
+			lappend gitdir_cmd --git-path $key
+		}
+	}
+
+	set i -1
+	foreach path [split [eval $gitdir_cmd] "\n"] {
+		if {$i eq -1} {
+			set _gitdir $path
+		} else {
+			set _gitdir_cache([lindex $gitdir_keys $i]) $path
+		}
+		incr i
+	}
+}
+
 proc gitdir {args} {
-	global _gitdir
+	global _gitdir _gitdir_cache
+
 	if {$args eq {}} {
 		return $_gitdir
 	}
-	return [eval [list file join $_gitdir] $args]
+
+	set args [eval [list file join] $args]
+	if {![info exists _gitdir_cache($args)]} {
+		if {[package vcompare $::_git_version 2.5.0] >= 0} {
+			set _gitdir_cache($args) [git rev-parse --git-path $args]
+		} else {
+			set _gitdir_cache($args) [file join $_gitdir $args]
+		}
+	}
+
+	return $_gitdir_cache($args)
 }
 
 proc gitexec {args} {
@@ -1242,7 +1288,7 @@ if {[catch {
 	&& [catch {
 		# beware that from the .git dir this sets _gitdir to .
 		# and _prefix to the empty string
-		set _gitdir [git rev-parse --git-dir]
+		prime_gitdir_cache
 		set _prefix [git rev-parse --show-prefix]
 	} err]} {
 	load_config 1
-- 
gitgitgadget
