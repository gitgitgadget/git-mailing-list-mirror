Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90D331F6C1
	for <e@80x24.org>; Sun, 21 Aug 2016 14:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753144AbcHUOvE (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Aug 2016 10:51:04 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:61509 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751549AbcHUOvD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2016 10:51:03 -0400
Received: from localhost.localdomain (unknown [IPv6:2a01:e35:2ef1:f910:86a6:c8ff:fe05:d3e0])
        by smtp1-g21.free.fr (Postfix) with ESMTP id CC00FB004E5;
        Sun, 21 Aug 2016 14:50:32 +0200 (CEST)
From:   Jean-Noel Avila <jn.avila@free.fr>
To:     git@vger.kernel.org
Cc:     Jean-Noel Avila <jn.avila@free.fr>
Subject: [PATCH 1/3] i18n: fix typos for translation
Date:   Sun, 21 Aug 2016 16:50:37 +0200
Message-Id: <20160821145039.12121-1-jn.avila@free.fr>
X-Mailer: git-send-email 2.10.0.rc0.37.gd7d1c14.dirty
In-Reply-To: <xmqqy43rxqqz.fsf@gitster.mtv.corp.google.com>
References: <xmqqy43rxqqz.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
---
 bisect.c    | 10 +++++-----
 sequencer.c |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/bisect.c b/bisect.c
index 6f512c2..b9a0701 100644
--- a/bisect.c
+++ b/bisect.c
@@ -760,7 +760,7 @@ static void handle_skipped_merge_base(const unsigned char *mb)
 	char *bad_hex = oid_to_hex(current_bad_oid);
 	char *good_hex = join_sha1_array_hex(&good_revs, ' ');
 
-	warning(_("the merge base between %s and [%s] "
+	warning(_("The merge base between %s and [%s] "
 		"must be skipped.\n"
 		"So we cannot be sure the first %s commit is "
 		"between %s and %s.\n"
@@ -846,7 +846,7 @@ static void check_good_are_ancestors_of_bad(const char *prefix, int no_checkout)
 	int fd;
 
 	if (!current_bad_oid)
-		die(_("a %s revision is needed"), term_bad);
+		die(_("A %s revision is needed"), term_bad);
 
 	/* Check if file BISECT_ANCESTORS_OK exists. */
 	if (!stat(filename, &st) && S_ISREG(st.st_mode))
@@ -863,7 +863,7 @@ static void check_good_are_ancestors_of_bad(const char *prefix, int no_checkout)
 	/* Create file BISECT_ANCESTORS_OK. */
 	fd = open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0600);
 	if (fd < 0)
-		warning_errno(_("could not create file '%s'"),
+		warning_errno(_("Could not create file '%s'"),
 			      filename);
 	else
 		close(fd);
@@ -914,7 +914,7 @@ void read_bisect_terms(const char **read_bad, const char **read_good)
 			*read_good = "good";
 			return;
 		} else {
-			die_errno(_("could not read file '%s'"), filename);
+			die_errno(_("Could not read file '%s'"), filename);
 		}
 	} else {
 		strbuf_getline_lf(&str, fp);
@@ -944,7 +944,7 @@ int bisect_next_all(const char *prefix, int no_checkout)
 
 	read_bisect_terms(&term_bad, &term_good);
 	if (read_bisect_refs())
-		die(_("reading bisect refs failed"));
+		die(_("Reading bisect refs failed"));
 
 	check_good_are_ancestors_of_bad(prefix, no_checkout);
 
diff --git a/sequencer.c b/sequencer.c
index 2e9c7d0..3804fa9 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -702,7 +702,7 @@ static struct commit *parse_insn_line(char *bol, char *eol, struct replay_opts *
 	if (action != opts->action) {
 		if (action == REPLAY_REVERT)
 		      error((opts->action == REPLAY_REVERT)
-			    ? _("Cannot revert during a another revert.")
+			    ? _("Cannot revert during another revert.")
 			    : _("Cannot revert during a cherry-pick."));
 		else
 		      error((opts->action == REPLAY_REVERT)
-- 
2.10.0.rc0.37.gd7d1c14.dirty

