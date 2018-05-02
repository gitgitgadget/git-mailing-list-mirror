Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF15C21841
	for <e@80x24.org>; Wed,  2 May 2018 09:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751469AbeEBJi5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 05:38:57 -0400
Received: from mout.gmx.net ([212.227.17.22]:48465 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751414AbeEBJiw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 05:38:52 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MLS74-1fEMBZ104I-000b6V; Wed, 02 May 2018 11:38:47 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 4/4] Convert remaining die*(BUG) messages
Date:   Wed,  2 May 2018 11:38:41 +0200
Message-Id: <57b3a3e9fe3a04e1f9fbcad9164bc71929d4bb29.1525253893.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.36.gdf4ca5fb72a
In-Reply-To: <cover.1525253892.git.johannes.schindelin@gmx.de>
References: <20170513032414.mfrwabt4hovujde2@sigill.intra.peff.net> <cover.1525253892.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:uLgofy5j+KEgNZeT/DFk/2RFgncDwgZdYtEnrYBOaYicpcP0r+n
 gQHufTmyTEWHDRgjHtHUPDnso/j31L4VnhWq9n7OypI5IpHX8SXLJOg34DR5ZaYIbaVd7TQ
 clDe5UEhT/9t2em/WzULfBHhrekypl9mRy+dqjq90u0AoYQHKyn5/ru9LV7HpfSfPWF0JWG
 t865hDPWlj1C5RkI9gcDQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cAVdpWV0yX0=:RHtVaRLdeu4WYR/ELpRROB
 0i4fJe13y96hMoQtkhFjTiGvI4YEpF8Lc68Nox03S1f+mxWbUIYToh3c2WkK+YTycujezReD+
 i+yFdiscPToEHY3vu4fRQiT5lBc4xYL8tQ0wvuyiMoF0ZfyOyGQ+UBD7xia6U4U8BfWozh0of
 ngmh2d1wZcscFZLTWVaM9moO8VMsRrErmbw+/sbyrwZ8E3e50Jcntn/Tc+pMDYkvaQOlIfW/3
 d8ysLaFZLjg/8WhM+cis0uboMD9/oob8K7foJS0DCqQOR3DcCmyUllluM81xn6DzBLZoNnOe4
 nWIzLppdLOQj4RHiqgIPOO6mp/pgmwuo3MC8gNaWIZePDec8SFcJ1Z2KnbvRgSMlEUygsAoeC
 y1rlw09ohy3ZyBQYW5P/x387ZA/2k4OzAboFTYJcaxPGItk/ZcGeDeTlnHRUXd73aFE2WIais
 wSUpY/li3AkfZu7rNOgorvMKuIpyc+XFZucBYRa6KmDoKMM+VgKdDbTKqZB6Rbz7mfZx63W6L
 vav634a8z3vXpwjYlMDnpbJ+/rQjee6nU/iTpYLaU2puwF9cejF5cGPXGR5IS9mq3OjmEJ8f/
 6+vWRlCWP0Y+kYw9Gbv9FO9/SNsAIgCv84y//239ImKErZwIGtnXv8m/PrlwoSrfvt/z9U+AT
 oRFMGdJj1LJqGgfsyqzmKKTmdi2x6Qfg2zvFtgpJCpSaEPXvPr+Upq8n5gWmzzsIyROrp/Z5Z
 zsARujV/KDutsv6QBxGrvpXk1l+dzLSDL85xJzKPfc3PQpPwE3RTgR4ZcKMo4spaFlqijkcnA
 mbaf/d+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These were not caught by the previous commit, as they did not match the
regular expression.

While at it, remove the localization from one instance: we never want
BUG() messages to be translated, as they target Git developers, not the
end user (hence it would be quite unhelpful to not only burden the
translators, but then even end up with a bug report in a language that
no core Git contributor understands).

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
