Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13556200B9
	for <e@80x24.org>; Fri,  4 May 2018 15:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751527AbeEDPfd (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 11:35:33 -0400
Received: from mout.gmx.net ([212.227.15.15]:53929 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751441AbeEDPfC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 11:35:02 -0400
Received: from virtualbox.mshome.net ([37.201.195.116]) by mail.gmx.com
 (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MEGIi-1f7xpe21Ps-00FRUK; Fri, 04 May 2018 17:34:54 +0200
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
Subject: [PATCH v2 12/18] branch-diff: use color for the commit pairs
Date:   Fri,  4 May 2018 17:34:53 +0200
Message-Id: <ba4791918c78770005d552856d8669648d7004f1.1525448066.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.409.g71698f11835
In-Reply-To: <cover.1525448066.git.johannes.schindelin@gmx.de>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <cover.1525448066.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:WHgFnB8/+HY1SB8S6LjuFfIP2Xc0A+zD/L6ILL+XsUW3GjJ4y5l
 dqKwh8qfJnK2tLRYQGN2jfvk0+SIIV+kTj6b1uhWHTOl5N1umQOjKHcpeCcOQ5FDmCDseoT
 LAdFom/UM+j+NDTGLlOig5Q9iWLhnssYawmkxz9KOKkEIPbGlTUDFCDm5KjAtdfmZhfISGD
 gTsvz7J3Nkanr+ABd4/cw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dTNMOFzhxvI=:g5ZrCNfY04SalVqimX3dAa
 aqhfqLJ/TK2MssnK4QkT/hT/Y/AGUXkMuQ+8FvV1tspN3YFRErUY2cucQWBGlc5YAAeZMxnQd
 Qp929x/t7AN4ptV5Sb0LuXbDTrLGFycMGmEzMK0DSJ9DP56WGERpPrq7neDnK3vZnohBbXqBI
 r8SE9XsWKp/7MsNCjNOcR4Fgkb7n0hWHT/FXU5l9IXT2FoezgO3LxCxQyzySW0Moe81ubX4Lw
 FPgINMno1cit7NuHDwlIFwtVClBEIUd2FH+Wxs+BUU7jkYwuwUIyKxichAfyw+YVrbppEJGHP
 4dpR73ia9FYnLilIrXNcOIkMfjvmuIoaa/n64HTP2e1tC5MRcHGj6TTjbexsup1a1x2AE5vG4
 kG3rjauT1wVqVbsc1rBRW6HMihXrF2rMNCwQdiw+puPCLwovKpIDm1GS2q1loRMOOoq9hKZrH
 ttm4Tq4msP8pkfpPeDvIVS8RDvHmccHAvkA8mVccTNOocufM4NTDGzc5vYK77eKk51b4RVcGv
 tM4jEUituPzxI5Ox1qVGbCf1DVtihnaPfPTdPYXfyutpEXnMAFUwOS4n9Hw4H0jtUIQgZB+7D
 OJDcJRjuC2VewL86v4ZjUnRZKU3+PFvxFTS4oT8nin9GS2I66gnxv6bgvrFYAXbbkTKczpTHo
 5WsbeflLuMshjydzmBS8ojVvw9AYXsMUZrVhhT/CR2PwBWERa34WRZX0bnj6WWrOA8/qyI02N
 qNIx11ueGG3tiRiq14uw7PYRAzE4xBuKQ49ZAzGRTiJXSMjzYKxfwtaOu9LtfEObl52ofwAtn
 i/eeOMU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Arguably the most important part of branch-diff's output is the list of
commits in the two branches, together with their relationships.

For that reason, tbdiff introduced color-coding that is pretty
intuitive, especially for unchanged patches (all dim yellow, like the
first line in `git show`'s output) vs modified patches (old commit is
red, new commit is green). Let's imitate that color scheme.

While at it, also copy tbdiff's change of the fragment color to magenta.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/branch-diff.c | 49 +++++++++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 13 deletions(-)

diff --git a/builtin/branch-diff.c b/builtin/branch-diff.c
index 89d75c93115..04efd30f0f6 100644
--- a/builtin/branch-diff.c
+++ b/builtin/branch-diff.c
@@ -273,13 +273,19 @@ static int get_correspondences(struct string_list *a, struct string_list *b,
 	return res;
 }
 
-static void output_pair_header(struct strbuf *buf,
+static void output_pair_header(struct diff_options *diffopt, struct strbuf *buf,
 			       int i, struct patch_util *a_util,
 			       int j, struct patch_util *b_util)
 {
 	static char *dashes;
 	struct object_id *oid = a_util ? &a_util->oid : &b_util->oid;
 	struct commit *commit;
+	char status;
+	const char *color_reset = diff_get_color_opt(diffopt, DIFF_RESET);
+	const char *color_old = diff_get_color_opt(diffopt, DIFF_FILE_OLD);
+	const char *color_new = diff_get_color_opt(diffopt, DIFF_FILE_NEW);
+	const char *color_commit = diff_get_color_opt(diffopt, DIFF_COMMIT);
+	const char *color;
 
 	if (!dashes) {
 		char *p;
@@ -289,21 +295,33 @@ static void output_pair_header(struct strbuf *buf,
 			*p = '-';
 	}
 
+	if (j < 0) {
+		color = color_old;
+		status = '<';
+	} else if (i < 0) {
+		color = color_new;
+		status = '>';
+	} else if (strcmp(a_util->patch, b_util->patch)) {
+		color = color_commit;
+		status = '!';
+	} else {
+		color = color_commit;
+		status = '=';
+	}
+
 	strbuf_reset(buf);
+	strbuf_addstr(buf, status == '!' ? color_old : color);
 	if (i < 0)
 		strbuf_addf(buf, "-:  %s ", dashes);
 	else
 		strbuf_addf(buf, "%d:  %s ", i + 1,
 			    find_unique_abbrev(&a_util->oid, DEFAULT_ABBREV));
 
-	if (i < 0)
-		strbuf_addch(buf, '>');
-	else if (j < 0)
-		strbuf_addch(buf, '<');
-	else if (strcmp(a_util->patch, b_util->patch))
-		strbuf_addch(buf, '!');
-	else
-		strbuf_addch(buf, '=');
+	if (status == '!')
+		strbuf_addf(buf, "%s%s", color_reset, color);
+	strbuf_addch(buf, status);
+	if (status == '!')
+		strbuf_addf(buf, "%s%s", color_reset, color_new);
 
 	if (j < 0)
 		strbuf_addf(buf, " -:  %s", dashes);
@@ -316,12 +334,15 @@ static void output_pair_header(struct strbuf *buf,
 		const char *commit_buffer = get_commit_buffer(commit, NULL);
 		const char *subject;
 
+		if (status == '!')
+			strbuf_addf(buf, "%s%s", color_reset, color);
+
 		find_commit_subject(commit_buffer, &subject);
 		strbuf_addch(buf, ' ');
 		format_subject(buf, subject, " ");
 		unuse_commit_buffer(commit, commit_buffer);
 	}
-	strbuf_addch(buf, '\n');
+	strbuf_addf(buf, "%s\n", color_reset);
 
 	fwrite(buf->buf, buf->len, 1, stdout);
 }
@@ -384,21 +405,21 @@ static void output(struct string_list *a, struct string_list *b,
 
 		/* Show unmatched LHS commit whose predecessors were shown. */
 		if (i < a->nr && a_util->matching < 0) {
-			output_pair_header(&buf, i, a_util, -1, NULL);
+			output_pair_header(diffopt, &buf, i, a_util, -1, NULL);
 			i++;
 			continue;
 		}
 
 		/* Show unmatched RHS commits. */
 		while (j < b->nr && b_util->matching < 0) {
-			output_pair_header(&buf, -1, NULL, j, b_util);
+			output_pair_header(diffopt, &buf, -1, NULL, j, b_util);
 			b_util = ++j < b->nr ? b->items[j].util : NULL;
 		}
 
 		/* Show matching LHS/RHS pair. */
 		if (j < b->nr) {
 			a_util = a->items[b_util->matching].util;
-			output_pair_header(&buf,
+			output_pair_header(diffopt, &buf,
 					   b_util->matching, a_util, j, b_util);
 			if (!(diffopt->output_format & DIFF_FORMAT_NO_OUTPUT))
 				patch_diff(a->items[b_util->matching].string,
@@ -430,6 +451,8 @@ int cmd_branch_diff(int argc, const char **argv, const char *prefix)
 	struct string_list branch1 = STRING_LIST_INIT_DUP;
 	struct string_list branch2 = STRING_LIST_INIT_DUP;
 
+	git_diff_basic_config("diff.color.frag", "magenta", NULL);
+
 	diff_setup(&diffopt);
 	diffopt.output_format = DIFF_FORMAT_PATCH;
 	diffopt.flags.suppress_diff_headers = 1;
-- 
2.17.0.409.g71698f11835


