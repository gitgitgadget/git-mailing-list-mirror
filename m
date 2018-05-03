Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 374BD200B9
	for <e@80x24.org>; Thu,  3 May 2018 15:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751464AbeECPaz (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 11:30:55 -0400
Received: from mout.gmx.net ([212.227.17.22]:42817 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751283AbeECPav (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 11:30:51 -0400
Received: from virtualbox.mshome.net ([37.201.195.116]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MLA45-1fDz4o177x-000M2E; Thu, 03 May 2018 17:30:47 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 07/18] branch-diff: indent the diffs just like tbdiff
Date:   Thu,  3 May 2018 17:30:46 +0200
Message-Id: <218e56a69e0e4a721a3ace7e05fc4b2c3e0d0e32.1525361419.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.409.g0f525fc0ba7
In-Reply-To: <cover.1525361419.git.johannes.schindelin@gmx.de>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:y/B+jcprX/p8hWyx6mx/gXV3BrVtuEpCvhXMv17GxQ5KrzDIlmC
 m6PvK+4qMy3z8JJl//3wSjjxTTm8uH9L1AEKajPPCNMYLyapsXtiYWuotj7KrUoZfRmcu+U
 TLbtBs8qrVuCRSNz1H40qnCEcAWV4hX2s0r4J1kPkYFJzJJzOPvcJjVlMlNrKRWRO7lZHjl
 iARy5CIUTEO+8ngL2oiaw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:67WlWCAxs8A=:Z9J2z/K+4gWPsfXdWtKS5n
 TrvW/E6YjkT/9oqmDR0u56ugzv75DH+e45xn9yHCUPvNnPwxPYhP6lXRswoKzBxOe9u9CQrWJ
 UhZErT7jr1jDupgCBY9GctlIkbeweWKfXbtMXIiRMK2FvFi3zfiIub3MpZ/JFQ45B7TuNQPWX
 YWk+BafHmCJ/0gkG1MPbWcVZFcaqlO/R3ntaETd3cQxC9RXzQeaKyHRTO9vnjSTdRdvUh9gL8
 3ujndqM7Fot1S4rVY1yIL6Q5qHsA2yBLVvRcOl3e3/v+nquUx8ZrC7jXcJYOgdqQRQR0HFRgo
 7Mvz33+CQcIcHBOGZ4K1iXoMY+GUCrzW3UbbRxvXzMxJBc19I4e/WsUTaD8ZHg+FcJj9ATXum
 7vxWsT5tvomeGiPo7U1IETnTRpcSz+P+UNsJ3pphGhIxmsfpq2vdqpUkrrN1pkV1cjarncERl
 EzDmEstu3Hw1cIGfHMqMY4NtboYOq7VIAOfjRAq4mcaI9KsuWem38XWeNyn7DJy4vZ/j/DhIP
 VoqEk0k0fqhk5bBuACvcrgGj0fpBQTDA/nvPguyBthrtDWvjfdHqHTburvRUPubk2j4SZudO7
 slw1kDsT+6Q9pbcMrUsMJQUvbGtotvhqqS0MSOV+Al5rcPu1oxhH4ooqvmY+FRX/6rtI+pK2D
 X+QKUkicKATipSEgqVZtPivW32P8jKhfiY57qRc/02bVWa+EQT1YMRkYHn/JeQP3Z2IrOOxLa
 uF8181BUh9FD6heyM4Ufms9sVTkyQXZHQC3LdCG7bptl4tEzjCBE2QivxMQt/Xrm/pcg3lqLo
 726ayGt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The main information in the branch-diff view comes from the list of
matching and non-matching commits, the diffs are additional information.
Indenting them helps with the reading flow.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/branch-diff.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/builtin/branch-diff.c b/builtin/branch-diff.c
index 9dc581087bb..a4e602deb5d 100644
--- a/builtin/branch-diff.c
+++ b/builtin/branch-diff.c
@@ -272,6 +272,11 @@ static const char *short_oid(struct patch_util *util)
 	return find_unique_abbrev(&util->oid, DEFAULT_ABBREV);
 }
 
+static struct strbuf *output_prefix_cb(struct diff_options *opt, void *data)
+{
+	return data;
+}
+
 static struct diff_filespec *get_filespec(const char *name, const char *p)
 {
 	struct diff_filespec *spec = alloc_filespec(name);
@@ -350,6 +355,7 @@ static void output(struct string_list *a, struct string_list *b,
 int cmd_branch_diff(int argc, const char **argv, const char *prefix)
 {
 	struct diff_options diffopt = { 0 };
+	struct strbuf four_spaces = STRBUF_INIT;
 	double creation_weight = 0.6;
 	struct option options[] = {
 		OPT_SET_INT(0, "no-patches", &diffopt.output_format,
@@ -368,6 +374,9 @@ int cmd_branch_diff(int argc, const char **argv, const char *prefix)
 
 	diff_setup(&diffopt);
 	diffopt.output_format = DIFF_FORMAT_PATCH;
+	diffopt.output_prefix = output_prefix_cb;
+	strbuf_addstr(&four_spaces, "    ");
+	diffopt.output_prefix_data = &four_spaces;
 
 	argc = parse_options(argc, argv, NULL, options,
 			builtin_branch_diff_usage, PARSE_OPT_KEEP_UNKNOWN);
-- 
2.17.0.395.g6a618d6010f.dirty


