Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4689320958
	for <e@80x24.org>; Thu, 23 Mar 2017 16:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965555AbdCWQHV (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 12:07:21 -0400
Received: from mout.gmx.net ([212.227.15.18]:62299 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965368AbdCWQHT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 12:07:19 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Mcmmn-1cZ8uK0jR3-00I039; Thu, 23
 Mar 2017 17:07:09 +0100
Date:   Thu, 23 Mar 2017 17:07:07 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH v2 1/3] t7504: document regression: reword no longer calls
 commit-msg
In-Reply-To: <cover.1490285210.git.johannes.schindelin@gmx.de>
Message-ID: <773531a3892fb78e8f70e540fc000bceb2c1bb7b.1490285210.git.johannes.schindelin@gmx.de>
References: <cover.1490194846.git.johannes.schindelin@gmx.de> <cover.1490285210.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:gU8K22oHuPznEu9btaeKktB6GCetgiopHqoeUn7IUpFQCXJ8Oo1
 cbpcli6qeip8TOqhqzXY9FqctsRVFw6TWSr8Jtkhnw5uLqW7KR6ckXOGzTtEfRPT/Hs9nmL
 tin0KHcezCp6HYxM7XveNnfG/gihlQevcLVzqucqy4Xknwc8JAFpvcAfS6IYUQBQaKouVDj
 v3jbymjxo+Rikirqb68Vg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YEBA/2xefh4=:DyTR2O8yvmPAhMmflISetk
 uoK+fxGWdz4oj9X3E3apcrj57zak+tfabewtXHUXSBvmtp4kqvFwtLShR1WqS2FWydss2yS0l
 OEN44n3UlbgPFGtuAq87V6rbfhzVuDa6HGd/Mgpo/bRDD+i5m8tpm2KbXgKV7m8/JPDIiLW5C
 Dmc00IzulQ9D/ofNvP6a3zafJNVkGhgIT1iLsr2cuyvBz6fcQwQoV8fZgxbCVYnFy8Zrj4DZ1
 NEUm3wvB/dznVowcNkTojFNcgwecqv8QK6ZtOfbaZLza8cRUzNgcjrb6DsocvyK5CmupY6Bg9
 hE5QcPnE06jT2TmB1wu8EFPDt2y6lh5f7wocjFaB8oNeeqVD9XpK3ZFXqunwustTdBfne1v0L
 rsu1XXUcpIS6ORGDTMyYiAO+oCy2aHj3kXWSL80FpmVUo7ejE8eljT5kHIec73UDy7Mj1J4Pb
 qGYJH/qAhrf/A0g5QBG6dbX9Jd7nB5LL79nJ+CVpb8zItcjFnGLaiBQ+zRGlAE5BK2ggZCkWS
 hkfp3H18Fw0+O7NiTnySZ44e7r9KQitmrm2QngWcB/ElDK+QKqdKPx4uzOXEAB8+VtEwuLQpl
 oHc1DE3kMmnJVdLML+vPq14920Wi8znK1QuYK15VRp7GgCI4EkiKIwbOd955Yeg8oljgBhqDs
 rgpDj+n9YVw06sOXTSYXq3lpZKAOHbKqf9EbpSiLg9AsVICXEsVXYU7Q22TYgSeHxPnAzld7X
 0Bh52lZknP2//TXaaFu8GRU5Q749CJrk/zGijNJyNQopljUkwgzrGQ5hKUrBPGRO7F3rmaBv5
 tcUKvuabS3tXtqZqSpMGACyXo6mqA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `reword` command of an interactive rebase used to call the
commit-msg hooks, but that regressed when we switched to the
rebase--helper backed by the sequencer.

Noticed by Sebastian Schuberth.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t7504-commit-msg-hook.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/t7504-commit-msg-hook.sh b/t/t7504-commit-msg-hook.sh
index 8728db61d38..c3d9ab02a3b 100755
--- a/t/t7504-commit-msg-hook.sh
+++ b/t/t7504-commit-msg-hook.sh
@@ -220,4 +220,21 @@ test_expect_success "hook doesn't edit commit message (editor)" '
 
 '
 
+# set up fake editor to replace `pick` by `reword`
+cat > reword-editor <<'EOF'
+#!/bin/sh
+mv "$1" "$1".bup &&
+sed 's/^pick/reword/' <"$1".bup >"$1"
+EOF
+chmod +x reword-editor
+REWORD_EDITOR="$(pwd)/reword-editor"
+export REWORD_EDITOR
+
+test_expect_failure 'hook is called for reword during `rebase -i`' '
+
+	GIT_SEQUENCE_EDITOR="\"$REWORD_EDITOR\"" git rebase -i HEAD^ &&
+	commit_msg_is "new message"
+
+'
+
 test_done
-- 
2.12.1.windows.1


