Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D19A20229
	for <e@80x24.org>; Fri, 21 Oct 2016 12:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932823AbcJUM0m (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 08:26:42 -0400
Received: from mout.gmx.net ([212.227.15.18]:60740 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932810AbcJUM0k (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 08:26:40 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MQRWm-1cMxVN1sVQ-00ThTl; Fri, 21 Oct 2016 14:26:33
 +0200
Date:   Fri, 21 Oct 2016 14:26:32 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v5 27/27] sequencer: mark all error messages for
 translation
In-Reply-To: <cover.1477052405.git.johannes.schindelin@gmx.de>
Message-ID: <b343290202b5cb3df1595ccbfbec3e18e4faf2c9.1477052405.git.johannes.schindelin@gmx.de>
References: <cover.1476450940.git.johannes.schindelin@gmx.de> <cover.1477052405.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:oI6XUWfL85rmUACeNTXjFjaNXhtENaYy2hiRD4EGQPvVn5qMBov
 KhpIq7T0N83Qeaj6ZfrfXqPd7RSfGreLVUsp9LvcVUpLCvRBQrORfbvjdqJ73dZ3amStyP7
 m0w9z8gjNvJSE8mjrInEykzJUICpFu9QZI0XXiCjCw6o3HhUWTOekK7Sy2M4UlftoeojXSW
 uEimebiDuKCvtYWBZxFgQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IZd3NnyVLv0=:8m4TdeKFdKhUZHhXePpvOI
 TANh/yYXan9yYF3Q4gtDD7MXHlMLK274ii8wClLwnQbu27Wr8FDCgh62FPn51PJdBBAwMSWDh
 IwbKihOEnYfC4uFijcaXrPqqnFvCC5OGGsfC2m3D1ZHl9hjTw/HVTt/+D0rpZWQquMqSAFUPy
 +Cx4RvCC+eDF4IRmD27XWRnKl/CleZfKzRqZvXFoggx+7kQNICayp6lhNGWeN3R0DOQJuzK4l
 +ys0olJSJReoLcEF1gfpH+j1P1rcj6mmfDWGbQ0F4vdLj8ImhJ0HlI5CSkqTZBfK4Nc+sAfvF
 QDzh8k9+4u/VZ+Mrdee0ugFQye0ydLSPikRdCV15PrMLMPxcedHEdjrCaQNzqh7sv9WKFXRDO
 aahFeaPA036EeWCip7RY7so22/2M8SgHUtzTSok28NRUtEYU8mkUcoCY8XqB+CZUHlFaJOBh+
 aw0IjT1PaLcpxdO5c34l73S+J2PrVJu+gYQA1E+yZrbKX1z+8dPr84doDMLUUI3CxRhp7rrbJ
 R1Kov5/HM+AcBlCU09ROD/Oy+fC+Vz3yijMEImE+RccMtbum7FOwPTwMzbRqxhY+tOaLtlkOb
 ECsljzzCrkNAm8+X5i9gGHRCMmCbpI1KRB/IVOzmP4grdXDPrwC7yn+L6X4M6jyTFpTFX5Gxv
 5d3HfIjL8usW4IXPDkSqg5P1Wa7dscvK7t+KDDhb6ib4AEHhJY6XNQ3BfbVwzI3ZRi9N7cI64
 g8FalhzxNNLo3KKE4zjFMWY7tPI6x/8R2nlBiOqPUye3Ng6rluYeKPqugJVXgIiWurzbm9WR4
 f4+yXMJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There was actually only one error message that was not yet marked for
translation.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 4c10c93..a61fe76 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -479,6 +479,20 @@ static char **read_author_script(void)
 	return env;
 }
 
+static const char staged_changes_advice[] =
+N_("you have staged changes in your working tree\n"
+"If these changes are meant to be squashed into the previous commit, run:\n"
+"\n"
+"  git commit --amend %s\n"
+"\n"
+"If they are meant to go into a new commit, run:\n"
+"\n"
+"  git commit %s\n"
+"\n"
+"In both cases, once you're done, continue with:\n"
+"\n"
+"  git rebase --continue\n");
+
 /*
  * If we are cherry-pick, and if the merge did not result in
  * hand-editing, we will hit this commit and inherit the original
@@ -505,16 +519,8 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 		if (!env) {
 			const char *gpg_opt = gpg_sign_opt_quoted(opts);
 
-			return error("you have staged changes in your working "
-				"tree. If these changes are meant to be\n"
-				"squashed into the previous commit, run:\n\n"
-				"  git commit --amend %s\n\n"
-				"If they are meant to go into a new commit, "
-				"run:\n\n"
-				"  git commit %s\n\n"
-				"In both cases, once you're done, continue "
-				"with:\n\n"
-				"  git rebase --continue\n", gpg_opt, gpg_opt);
+			return error(_(staged_changes_advice),
+				     gpg_opt, gpg_opt);
 		}
 	}
 
-- 
2.10.1.583.g721a9e0
