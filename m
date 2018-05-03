Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1298200B9
	for <e@80x24.org>; Thu,  3 May 2018 15:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751495AbeECPbB (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 11:31:01 -0400
Received: from mout.gmx.net ([212.227.17.20]:34955 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751152AbeECPay (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 11:30:54 -0400
Received: from virtualbox.mshome.net ([37.201.195.116]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MF9WR-1f6o4H1zkh-00GFJD; Thu, 03 May 2018 17:30:50 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 08/18] branch-diff: suppress the diff headers
Date:   Thu,  3 May 2018 17:30:47 +0200
Message-Id: <00ea45123ae87205820ec3d00e83ded6ea25eb4b.1525361419.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.409.g0f525fc0ba7
In-Reply-To: <cover.1525361419.git.johannes.schindelin@gmx.de>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:KpbxyEHTnGKYWeXo7YMM8nPg5vb2XwyzNZUpgzLiZta7mOEVaxo
 dCiKNkWdufThvUVHSqw6GjC4Rzcg1IVyZwKxOx08T2XpGaBZGow2CesNDLVyXGXgaeaAVIT
 iWkeK3+9rX+Ai8JQw8Oepxpgv3lzC+O1dW1Pkd6NKrzF7zulgKio8geJr1Av0N1QSjmRlzH
 bnBcOWF34r9J4z8EUTmVg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+9AbFkWrYvA=:yvdPEENSnCGMq2y/l1oUl0
 SYxl/j3dRMTXL9uS0cY4KHBB5QTqZyuJFRMINOUubKDNk/o9EEiXZr4ZjEQmKzbtVwdbwFOzO
 5aKCkdfVrPvlb0V4T6OzE21BuYhMBXgbTBu4qjcmuRPGfsUzLyZOF+kHVphEcklNkL+Qlu7Ak
 5ckwqK7Y89P2IfWYEMxSM/t/Apz5I18ebHQzfYFLGKsF6m02KG03u858TTECFfxTBc34HOynt
 o/inap71nLhePOQOWQR8juhR6xrHiWXMudOPYFusuH4P9Iodby03o4rUyLQ8JVgOlNFeZipVL
 Mdyxu6YVVDcuU12UCzSzEfjuH5w0sYmagxAsDp0hAvkroiUgxxryXXV8fWg2VdTwj0GVTPhEd
 hlJm1dU5rPsk1ifect3cBDpvFXKDyq9iYOKVqJJuhd2fii7dz4l0kJZmR4QyHnfP0+Ov+kfNh
 /i3v5L33Qk5HmAW0LMj8YDq4DxScItCbrl6ooElWNUnNRvvaFp9YU1z1mqolTGzqA+O3+HrRN
 hQmatl1/dosH4waRSYiXhwv84S2E9dy+8oBvnL+MtHj+ejlXBjCozgh8ROkB3g5LOmh53y+qO
 nkVhjwozU/67vuWV3inFCzD2JuuFtk6DfAuEvGyZBr35WD7zwWkPz6EUPddX55F4Pfjy4HOx0
 ghIzHwp3X0EpLwYb3+4RfvLQfRYF+sP965tg6MG3VZcGldXELuGq92G+/r8UoQ4HuKY65VBK3
 tokYuSD/F9TQTEbbOJPH/uHmg0C5BYxIJo09P5E8n2n4DGhSNNOGf/QOVZb0JfApeybZGHZVw
 nyzuqWZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When showing the diff between corresponding patches of the two branch
versions, we have to make up a fake filename to run the diff machinery.

That filename does not carry any meaningful information, hence tbdiff
suppresses it. So we should, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/branch-diff.c | 1 +
 diff.c                | 5 ++++-
 diff.h                | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/builtin/branch-diff.c b/builtin/branch-diff.c
index a4e602deb5d..9edc5a0e89b 100644
--- a/builtin/branch-diff.c
+++ b/builtin/branch-diff.c
@@ -374,6 +374,7 @@ int cmd_branch_diff(int argc, const char **argv, const char *prefix)
 
 	diff_setup(&diffopt);
 	diffopt.output_format = DIFF_FORMAT_PATCH;
+	diffopt.flags.suppress_diff_headers = 1;
 	diffopt.output_prefix = output_prefix_cb;
 	strbuf_addstr(&four_spaces, "    ");
 	diffopt.output_prefix_data = &four_spaces;
diff --git a/diff.c b/diff.c
index 1289df4b1f9..f1bda0db3f5 100644
--- a/diff.c
+++ b/diff.c
@@ -3197,13 +3197,16 @@ static void builtin_diff(const char *name_a,
 		memset(&xpp, 0, sizeof(xpp));
 		memset(&xecfg, 0, sizeof(xecfg));
 		memset(&ecbdata, 0, sizeof(ecbdata));
+		if (o->flags.suppress_diff_headers)
+			lbl[0] = NULL;
 		ecbdata.label_path = lbl;
 		ecbdata.color_diff = want_color(o->use_color);
 		ecbdata.ws_rule = whitespace_rule(name_b);
 		if (ecbdata.ws_rule & WS_BLANK_AT_EOF)
 			check_blank_at_eof(&mf1, &mf2, &ecbdata);
 		ecbdata.opt = o;
-		ecbdata.header = header.len ? &header : NULL;
+		if (header.len && !o->flags.suppress_diff_headers)
+			ecbdata.header = &header;
 		xpp.flags = o->xdl_opts;
 		xpp.anchors = o->anchors;
 		xpp.anchors_nr = o->anchors_nr;
diff --git a/diff.h b/diff.h
index d29560f822c..0dd6a71af60 100644
--- a/diff.h
+++ b/diff.h
@@ -94,6 +94,7 @@ struct diff_flags {
 	unsigned funccontext:1;
 	unsigned default_follow_renames:1;
 	unsigned stat_with_summary:1;
+	unsigned suppress_diff_headers:1;
 };
 
 static inline void diff_flags_or(struct diff_flags *a,
-- 
2.17.0.395.g6a618d6010f.dirty


