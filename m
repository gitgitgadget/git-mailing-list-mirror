Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25638200B9
	for <e@80x24.org>; Fri,  4 May 2018 15:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751479AbeEDPfR (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 11:35:17 -0400
Received: from mout.gmx.net ([212.227.15.15]:33259 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751311AbeEDPfO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 11:35:14 -0400
Received: from virtualbox.mshome.net ([37.201.195.116]) by mail.gmx.com
 (mrgmx003 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MYP57-1esmMM0WOX-00VBnU; Fri, 04 May 2018 17:35:07 +0200
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
Subject: [PATCH v2 15/18] branch-diff: offer to dual-color the diffs
Date:   Fri,  4 May 2018 17:35:06 +0200
Message-Id: <b9be01705d6cfa1260dff33c1f2466526511dd18.1525448066.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.409.g71698f11835
In-Reply-To: <cover.1525448066.git.johannes.schindelin@gmx.de>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <cover.1525448066.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:OwYLHi5N9YXDZPH9JasrUL1FqDgPDsF4wTeTHAQIY5swRwtWPSt
 6p0MuptgEOsi4mrd4z8Tu/JQ4h6oURVqBpzZUwz5utFcstfcNgkVWSbzYru208g1D48TfSe
 Q03j5qEbju3ZG6iwbzdEB5DMl40AGfXGHq/UHzCZK+0s0e6zQvDtsOJuWWRXEDSqzFXi0jQ
 n3NobdXQBq6jlTC3YtKmg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6Sa/x56u/P0=:js4osyAw9rzzewPETsSqg3
 stLyNF8DphvTq+RHDXWa1oszJEJF5UreuATkSOKbKARHyR4I76qyy81N6zqEUQEkwV1FYSVml
 EALhdH3e2TeW8BO2WqSvv7SZZxPtbfHbprODTBEQ0BeD8ORmcw8NdkSpxurDswl3GGN9JOPxB
 8kViVsGAfiF+cNFAyqqzade9Uoqtkr20d10fasS1TJQ6ACkxnXQq3bXaoFqJZ/Rh098Fp3kk8
 uCj3TMdewFUQhrRSnNSq1qBD5AexFUiae0Jn/yaSaNnEijcZmxZbFv6whxf2jVv4xY+FY+h7S
 hSyaOcRXB6EWyHpvb8wuqhA3QodGKed7oh1bIerrE5u2DdhW9nJOwU7TV7tkPDuQvZ2itVjcu
 1Xoo5EYrRMErXIOWIKjz5n/BGNeLPm20X4i2eyDsXMJjKhjoSnXoR7YouJk1TC3X2dOgP648K
 rSFf9vY7MbB+7CD96hA+kySA/YlZaPm/X0FFeB3q/d2FsFZ4JofIzyuxgpPSbHtHLa17drmgm
 5OrkQSAsugEOkvkerNkGRaFeNRVbzlh120/aVURCFlsCV/CLnBjTOWpDg3U2g+0mofv0k/fue
 U9cM7miaZORh04yAJ2dFuNgcmoWSDvmCzAgvafU6oC410o+8mjGyO0+6uVgWdd07THkiJzhc3
 0vHQ4F0ODvE3xFQLywejl9ugDhB3qwtyzYekp6pdG5IPg5zHpzm2/XB4PTtSNVmSlJnzWUBSp
 2bbqN9bWgybYz7UsxUZIHHLo0Yr4sZY6xtCoW+9G4fPqp8B0Xe6SeUIXKs5tI3vQ++MW1EIL/
 +4XvKqo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When showing what changed between old and new commits, we show a diff of
the patches. This diff is a diff between diffs, therefore there are
nested +/- signs, and it can be relatively hard to understand what is
going on.

With the --dual-color option, the preimage and the postimage are colored
like the diffs they are, and the *outer* +/- sign is inverted for
clarity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/branch-diff.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/builtin/branch-diff.c b/builtin/branch-diff.c
index 04efd30f0f6..8a16352e3a1 100644
--- a/builtin/branch-diff.c
+++ b/builtin/branch-diff.c
@@ -435,8 +435,11 @@ int cmd_branch_diff(int argc, const char **argv, const char *prefix)
 {
 	struct diff_options diffopt = { NULL };
 	struct strbuf four_spaces = STRBUF_INIT;
+	int dual_color = 0;
 	double creation_weight = 0.6;
 	struct option options[] = {
+		OPT_BOOL(0, "dual-color", &dual_color,
+			    N_("color both diff and diff-between-diffs")),
 		OPT_SET_INT(0, "no-patches", &diffopt.output_format,
 			    N_("short format (no diffs)"),
 			    DIFF_FORMAT_NO_OUTPUT),
@@ -472,6 +475,11 @@ int cmd_branch_diff(int argc, const char **argv, const char *prefix)
 	argc = j;
 	diff_setup_done(&diffopt);
 
+	if (dual_color) {
+		diffopt.use_color = 1;
+		diffopt.flags.dual_color_diffed_diffs = 1;
+	}
+
 	if (argc == 2) {
 		if (!strstr(argv[0], ".."))
 			warning(_("no .. in range: '%s'"), argv[0]);
-- 
2.17.0.409.g71698f11835


