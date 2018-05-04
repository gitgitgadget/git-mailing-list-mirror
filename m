Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 083D4200B9
	for <e@80x24.org>; Fri,  4 May 2018 15:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751456AbeEDPfG (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 11:35:06 -0400
Received: from mout.gmx.net ([212.227.17.20]:54305 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751411AbeEDPex (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 11:34:53 -0400
Received: from virtualbox.mshome.net ([37.201.195.116]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0LcVOE-1eWB2f0dfS-00jtkl; Fri, 04 May 2018 17:34:47 +0200
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
Subject: [PATCH v2 07/18] branch-diff: indent the diffs just like tbdiff
Date:   Fri,  4 May 2018 17:34:45 +0200
Message-Id: <c856c460a47dbe885bbb82babc6be6848d31ed32.1525448066.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.409.g71698f11835
In-Reply-To: <cover.1525448066.git.johannes.schindelin@gmx.de>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <cover.1525448066.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:6ho+T2VGWfNG22XphIjmPvLYy/MwwSO29qsPYO6XhTKQ6VIDBnw
 gx4Hgr+sa64axa5AsEUR7nhC+CpO38yAL/NH81k+vl4vf9g2TLIdEKeDGdZI00BH98gqAEn
 UT4DRYSD+wDTUeLD3CZfzV5GQZn28NSB4ruzokuOxVlm2QIpXa7mlFVCPO0azcgENFkCLXj
 1m/o2eaoiyErj08FMVbbw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0Lm+CkstCy8=:c86M3iTNcEEVvGW3pYo7vD
 wKzOxEM5uA1YLl9YszzlcGkiF8QOjPhST3LFoFMfsupsoLvAM5MlHUjwQScK5alEVO+2IkB9Z
 UzwlPAytT1/glXJUomMwrrRTFL9WaJRDyd8uCBfiJDL3e7XYnv+Nex8nVG+2Gt3zgpKR+K6vZ
 xdXJDeLcXqZm0oC4V4c7S6xu24Za9zEkQsMJYa3qsN9sCVNn6U+SEOjx7se96DowWHhd/eT7Z
 P/o436m52SrrieMyvejS68qDnnJNCh9d0RStguui1wEckAyz06o/lss3QGt5VT3/wioASrhpy
 KOukFdzAdIsI4xhiQ4uSKbiB6y478q5Gg15xEcVvF5Xv2B8CIeD/UrLraT+Vo8IVIOJ6Vviae
 82N0t1hjPTvViRyZ14rzyAbCbTm0zs2i4mm+Fja/tJSlg7X5D3HDjHGMFsXI8NXm9ct4wltjU
 i9xnQbrxa4l6izx5ghAGjC3VEH18eAsL/Drb/uZTXEQTGvktGAk9RRaIYZ5pAOLBJU908Xa3w
 db/9kYPKGrpQqaOq0k7n//DWlGNrbV6zniaNH+WOMadaIu2cUk/uRpT1UZjobDMpX+Ha8hZuZ
 1mrDVNyDSc+CkP4GqVn+bPeN7edwwVFJqTA4qsHecpWXXjG0xGuNJ1vhNjael0FiDDGu+qzBj
 Po/G3My1RDxKYKd8H0qQy+YNY1JlSsXYitMByQpJTHMIbBnWP3AhpIg6pCK5rGjGvKXo44sD/
 r4ri4xjyhjBstZOhwrNE0LVgsImBuyZHJzr6cW56rdmCMK6zePLIkahBniZm3fC5Yf6lYMWtO
 62AlnQP
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
index e2337b905b1..4fc9fd74531 100644
--- a/builtin/branch-diff.c
+++ b/builtin/branch-diff.c
@@ -275,6 +275,11 @@ static const char *short_oid(struct patch_util *util)
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
@@ -353,6 +358,7 @@ static void output(struct string_list *a, struct string_list *b,
 int cmd_branch_diff(int argc, const char **argv, const char *prefix)
 {
 	struct diff_options diffopt = { NULL };
+	struct strbuf four_spaces = STRBUF_INIT;
 	double creation_weight = 0.6;
 	struct option options[] = {
 		OPT_SET_INT(0, "no-patches", &diffopt.output_format,
@@ -371,6 +377,9 @@ int cmd_branch_diff(int argc, const char **argv, const char *prefix)
 
 	diff_setup(&diffopt);
 	diffopt.output_format = DIFF_FORMAT_PATCH;
+	diffopt.output_prefix = output_prefix_cb;
+	strbuf_addstr(&four_spaces, "    ");
+	diffopt.output_prefix_data = &four_spaces;
 
 	argc = parse_options(argc, argv, NULL, options,
 			builtin_branch_diff_usage, PARSE_OPT_KEEP_UNKNOWN);
-- 
2.17.0.409.g71698f11835


