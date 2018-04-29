Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EB901F428
	for <e@80x24.org>; Sun, 29 Apr 2018 22:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754353AbeD2WUF (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Apr 2018 18:20:05 -0400
Received: from mout.gmx.net ([212.227.17.21]:54909 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754117AbeD2WUE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Apr 2018 18:20:04 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MUHbK-1elvuH2lmM-00R1Ef; Mon, 30 Apr 2018 00:19:59 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH 6/6] Convert remaining die*(BUG) messages
Date:   Mon, 30 Apr 2018 00:19:16 +0200
Message-Id: <0e85c7a16e3767eb03cdce0a7ed75a0c2b77d7d5.1525040254.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.36.gdf4ca5fb72a
In-Reply-To: <cover.1525040253.git.johannes.schindelin@gmx.de>
References: <cover.1525040253.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:0QU/KZsJs8gGZwvHhCurj6J9NdAouuOP6GK/yLpzV6GUC986uwh
 fsO8GyBSBCA+4V3gvr/UwdHgIAnnfiXOfMMImtyGgns7I8xUd5jKvzdIHq6Th2hISKuXv3j
 tHylHBxV0JJ91TcXls4gvHh6Y+9cFs+Wq2RyHPQsHfEH8GZTNmvf/W8U+tZBI8O8Xzzvra7
 P+OuKolL2Ta/DB2K++1Dw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:X/1AFk17iVI=:LecPxbygCMlBOjrDytOws4
 Lmz9FomhQ3x/dEzdPqJdguKY349SWVL183dQufcypzdYHC6A/SWmsxQorokYEh0EpAWUUc01Q
 oAjEXtfVGkGeJxC5khOpJZ6073bA5abu8GmNruiwGY3uGvBBibVA5UqibBczjJpuvIyVR5ihR
 E8+zfAjvvcfl2lm6UQpVkEOkcRpkFhYF2yE7qzTQeP/m8Vzv+9j6eludt7w6lH1NbuRJJDegp
 I6mv6/68tte6gy9JDVN9/OSDuILbRJFLycIFGKS5MQRgT4A7kCb51utr9pyrT4d2Z1BSuxVp+
 4cYIZDGRtw7i0MNg3Elw3TgXJ9jwbNZDUWiW0egsO2iu3mMtCYQRh5hVA69p1UMsssX+lb//B
 89v3ukf3A6gr14Oz1iuzx/qKgv0sWQrVXZgyGB39XPY9ybbxQCRZPz3kroXFICeYRkLOucJEW
 9bUH9S0eRq5w0HcWM8VtiBNNz1IFsbzjX04y6xG5ZFEViA/WBYI0XDj0l89gscEd/8ih1/lMu
 xHYcBgDuq4V4gVyBwLoliMA768aI9NP27/M7QrsK3F8FQulMaB3/GZunP7JrXnasM4u4QIZ+X
 agZfvGl/oYmd/78yDfwTkOI2PSB9fxrTm1xJXgUw8kjOBVMtt/QAN96qOA65UR9koVLKA36L8
 sL1nJg0I6XPg9l7wnJjb0Eo0tY8/45Pq/ehDPiX/zX3r+r+dS5LW7OSVPFuIle82K+jziUZKS
 R+sM0xGHio2KXGRBtEXe5CXYOesApIHqVrGniw1u3cQ8dadoNzkVL4Blwn6GGZZsd/xxW5SID
 yKBbT0e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These were not caught by the previous commit, as they did not match the
regular expression.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-compat-util.h     | 2 +-
 pathspec.c            | 2 +-
 submodule.c           | 2 +-
 vcs-svn/fast_export.c | 6 ++++--
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 07e383257b4..3a7216f5313 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1052,7 +1052,7 @@ int git_qsort_s(void *base, size_t nmemb, size_t size,
 
 #define QSORT_S(base, n, compar, ctx) do {			\
 	if (qsort_s((base), (n), sizeof(*(base)), compar, ctx))	\
-		die("BUG: qsort_s() failed");			\
+		BUG("qsort_s() failed");			\
 } while (0)
 
 #ifndef REG_STARTEND
diff --git a/pathspec.c b/pathspec.c
index a637a6d15c0..27cd6067860 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -486,7 +486,7 @@ static void init_pathspec_item(struct pathspec_item *item, unsigned flags,
 	/* sanity checks, pathspec matchers assume these are sane */
 	if (item->nowildcard_len > item->len ||
 	    item->prefix         > item->len) {
-		die ("BUG: error initializing pathspec_item");
+		BUG("error initializing pathspec_item");
 	}
 }
 
diff --git a/submodule.c b/submodule.c
index 733db441714..c282fa8fe51 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2043,7 +2043,7 @@ const char *get_superproject_working_tree(void)
 
 		if (super_sub_len > cwd_len ||
 		    strcmp(&cwd[cwd_len - super_sub_len], super_sub))
-			die (_("BUG: returned path string doesn't match cwd?"));
+			BUG("returned path string doesn't match cwd?");
 
 		super_wt = xstrdup(cwd);
 		super_wt[cwd_len - super_sub_len] = '\0';
diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 3fd047a8b82..b5b8913cb0f 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -320,7 +320,8 @@ const char *fast_export_read_path(const char *path, uint32_t *mode_out)
 	err = fast_export_ls(path, mode_out, &buf);
 	if (err) {
 		if (errno != ENOENT)
-			die_errno("BUG: unexpected fast_export_ls error");
+			BUG("unexpected fast_export_ls error: %s",
+			    strerror(errno));
 		/* Treat missing paths as directories. */
 		*mode_out = S_IFDIR;
 		return NULL;
@@ -338,7 +339,8 @@ void fast_export_copy(uint32_t revision, const char *src, const char *dst)
 	err = fast_export_ls_rev(revision, src, &mode, &data);
 	if (err) {
 		if (errno != ENOENT)
-			die_errno("BUG: unexpected fast_export_ls_rev error");
+			BUG("unexpected fast_export_ls_rev error: %s",
+			    strerror(errno));
 		fast_export_delete(dst);
 		return;
 	}
-- 
2.17.0.windows.1.36.gdf4ca5fb72a
