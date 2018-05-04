Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7439C200B9
	for <e@80x24.org>; Fri,  4 May 2018 15:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751432AbeEDPe6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 11:34:58 -0400
Received: from mout.gmx.net ([212.227.15.18]:52161 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751294AbeEDPez (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 11:34:55 -0400
Received: from virtualbox.mshome.net ([37.201.195.116]) by mail.gmx.com
 (mrgmx002 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0LngNT-1ehSVD2VHL-00htVe; Fri, 04 May 2018 17:34:48 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 08/18] branch-diff: suppress the diff headers
Date:   Fri,  4 May 2018 17:34:47 +0200
Message-Id: <35a9681a192e63d1b5dd1a60571f5c5991e90457.1525448066.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.409.g71698f11835
In-Reply-To: <cover.1525448066.git.johannes.schindelin@gmx.de>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <cover.1525448066.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:efNhHP/OnqTl8EBdd72+T2mVaur4GrvsLHNt69lI+5ObRk0GbbA
 MsocJlMivnGyuxD+hDNN/vWiYVkcfwGAcsi4twB6Zk+avbYy+fOJAxLP6kWxlFJvoLw/CWy
 65ZANgRsyzaUw5iFQr4BVBjcQ0qMkFmORHzjvak8B4wXPywFBVimveOrI3AwpIA+7RRCxBk
 BX6HbobuAbysw3KXEp9vQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oDS7kJNaqiA=:9nrVSvEvHqrR/CDPuo+f2k
 YBlZaOCF0BuH5c9sECJtZalQlCSXQWi97O4GFZeetPD4AC4okLdMgKMyhelwRCD/SQuNbreyD
 bAACEtO7BY7o7FxzpwBAgcJ+6SqLZM5aR/JbZIPTZn/h0+seNlQTf38HTqOKydQtP92sLim9f
 VP/VjHnE0AEn3V7GUss8f8WAB8UcNrdElXi1Bmzn8e+ySOCZFFHG6PZJfOLhfnpaAK0UkS2Px
 9Tm57A1eaFO8Olh7133d83tD0UdSFDc2+BXUk6C7NtEO/zaJNF8tZYF7Hi1DUKSPQZSn30849
 Q/DRU9wjn3qBFBlTd+ISryXc2nACvu7do8Z5m3jQwLWS4dptxNCqTuiA5X8EgwRif/cM34k0z
 cKw56RluqupY72U6PnQ12qK36jtgVWMOLnfpM8n0HsF5kXKQceY8EABzQFG8BsLgA8PRFbod4
 MfRoYS5h0/4JAL2WAj8Iwogbbm/FPqj4HQVixW4NbejI+OpLJ9gTMjjvmwgvzEXvUSc0G3rHB
 209mnWoLBZ7itJbaaWK/9ZhdlVQv0oinw92awjTCNq4OZGTb0YxUiSpLbLujSczIJabTjX9rh
 l/AYva1t2jHU4I5SwmMaGSD9mlGYiCZUwMBXoz3RHHTZKnwpNuEgBVHFvYvR74NJB9bHta37p
 d4fI8Fy7TTOmAntPjWDXIhhKoNb2LCkdxN69qVOoZkiXJL4JtLS41Kj4+ciOQlbymrQixReIk
 z16NxDfTZqLkYRuvC74jSK8Bjjm2c4GaFimUL95xLkwFSEjKLyu1UbuOeNvCyKT+r8roH4oCb
 os3J1OA
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
index 4fc9fd74531..ed520d6229d 100644
--- a/builtin/branch-diff.c
+++ b/builtin/branch-diff.c
@@ -377,6 +377,7 @@ int cmd_branch_diff(int argc, const char **argv, const char *prefix)
 
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
2.17.0.409.g71698f11835


