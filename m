Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02FE72023C
	for <e@80x24.org>; Tue,  5 Jul 2016 11:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932899AbcGELYV (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 07:24:21 -0400
Received: from mout.gmx.net ([212.227.15.18]:59185 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932838AbcGELYG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2016 07:24:06 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M8m7Q-1bAWZ80DOe-00CEWX; Tue, 05 Jul 2016 13:23:58
 +0200
Date:	Tue, 5 Jul 2016 13:23:57 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH v2 11/17] am: counteract gender bias
In-Reply-To: <cover.1467717729.git.johannes.schindelin@gmx.de>
Message-ID: <ea23faf258b6e62e770879362869f49eea4db869.1467717730.git.johannes.schindelin@gmx.de>
References: <cover.1467199553.git.johannes.schindelin@gmx.de> <cover.1467717729.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:NpLz4oyymEetwXkgTc/+5IhQMFK5HiSr3OKFEXh87LED0qKoRb4
 Wlf1mgaGPQNb58VNHDtfsZkQQwpIw1LiRXsBCR2i0EVW1T0i/JTAaoRUpowflz/125H8A09
 6HvLBXyFEOnDr1Rx2hp8JIdnFw8+FdhPDQ6JSZfX6YM/QJx9AXX4PaclEsyxk7s9UMBYxgv
 RrVPvgAV+8raNp/psjCBw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:bqlS3ZH7WMA=:c6PBQ2LzELQ7jqUGAnwB5D
 PXwSqFpiYfMwMqpVzJwdlfcZKi5DTyt6eYTytXzqh4fGpDIFfzbjiJkdFg3o5qeo9dGjvqp4b
 nMmW7wuIRF09XydDvPbQzE/TQtpmVyfwDbAjmoKVYXY0kd88BQwDNEDAs6aMqIr7VLTNeo2Wn
 c8M4J5PS32/7+Th1tVcYSA1X5cu59kmEe1WI+GMOOGBKxLI2e4M+mzAL5a1NzhaifBD9PrdaA
 CBq9seeYYhGFKAzRBV4p0p4jxczwwwlw/KiUuni7nJS9ati5/Tm56ypKnSELT2iHeskTscOp2
 k2d9KAS2uCFsmW+leTTm9Ub3ioNWdXy9DU56I9WHTWbmKESEebIw5jvE024w7klYLQGKtkhu9
 0S5maOChxLMv/qRlZeMuCk05YzAHPLrEfbAlG39qLNkdAL9ptETnawfWLqY+GwrEuWkjOXV5i
 aZip4pK7JVM8mi8A+7ockZd2JfJZUDt0cO8Nhg4jrP4jFw5fxneSzHbY8GBvT5bAKQBAx6iMw
 tpZagsfSAsDO6JNOjb7Bprf24EY76JKQE4SazirfxicTCtmDsp5ySypIjR3lBxWQw6xWQw6ev
 OsJThdAV2wt7UfE5TYbAMIU4HRCPJdntW0fAmCt53bOpUl4iThcok3NsE2amO3UeE60xqxNNQ
 k3f6iIXFeFF2SB5/tHC/zi7d4Ri+Rjpv6aiw2aLN/6FZpKBQDcCSGm/MSrpvg7LPFAqxLKuDz
 /xRnDz/NfQYsnOdvBTQFqDMW97BoDRdc+c8mPK5RIe+RhTf0NeGBwN4ctvae4YJJeHNPHdh94
 frWTnB6
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07), i.e. for
almost 11 years already, we demonstrated our disrespect to the pioneers
of software development like Ada Lovelace, Grace Hopper and Margaret
Hamilton, by pretending that each and every software developer is male
("his_tree"). It appears almost as if we weren't fully aware that the
first professional software developers were all female.

We know our field to have this unfortunate gender bias that has nothing
to do with qualification or biological reasons, and we are very sad
about the current gender imbalance of the Git developer community.

Let's start changing that by using the variable name "her_tree" for an
equal number of years out of fairness, and change to the gender neutral
"their_tree" after that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/am.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 3dfe70b..f07f89a 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1578,14 +1578,14 @@ static int build_fake_ancestor(const struct am_state *state, const char *index_f
 }
 
 /**
- * Do the three-way merge using fake ancestor, his tree constructed
+ * Do the three-way merge using fake ancestor, her tree constructed
  * from the fake ancestor and the postimage of the patch, and our
  * state.
  */
 static int run_fallback_merge_recursive(const struct am_state *state,
 					unsigned char *orig_tree,
 					unsigned char *our_tree,
-					unsigned char *his_tree)
+					unsigned char *her_tree)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	int status;
@@ -1593,7 +1593,7 @@ static int run_fallback_merge_recursive(const struct am_state *state,
 	cp.git_cmd = 1;
 
 	argv_array_pushf(&cp.env_array, "GITHEAD_%s=%.*s",
-			 sha1_to_hex(his_tree), linelen(state->msg), state->msg);
+			 sha1_to_hex(her_tree), linelen(state->msg), state->msg);
 	if (state->quiet)
 		argv_array_push(&cp.env_array, "GIT_MERGE_VERBOSITY=0");
 
@@ -1601,7 +1601,7 @@ static int run_fallback_merge_recursive(const struct am_state *state,
 	argv_array_push(&cp.args, sha1_to_hex(orig_tree));
 	argv_array_push(&cp.args, "--");
 	argv_array_push(&cp.args, sha1_to_hex(our_tree));
-	argv_array_push(&cp.args, sha1_to_hex(his_tree));
+	argv_array_push(&cp.args, sha1_to_hex(her_tree));
 
 	status = run_command(&cp) ? (-1) : 0;
 	discard_cache();
@@ -1614,7 +1614,7 @@ static int run_fallback_merge_recursive(const struct am_state *state,
  */
 static int fall_back_threeway(const struct am_state *state, const char *index_path)
 {
-	unsigned char orig_tree[GIT_SHA1_RAWSZ], his_tree[GIT_SHA1_RAWSZ],
+	unsigned char orig_tree[GIT_SHA1_RAWSZ], her_tree[GIT_SHA1_RAWSZ],
 		      our_tree[GIT_SHA1_RAWSZ];
 
 	if (get_sha1("HEAD", our_tree) < 0)
@@ -1651,7 +1651,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 		return error(_("Did you hand edit your patch?\n"
 				"It does not apply to blobs recorded in its index."));
 
-	if (write_index_as_tree(his_tree, &the_index, index_path, 0, NULL))
+	if (write_index_as_tree(her_tree, &the_index, index_path, 0, NULL))
 		return error("could not write tree");
 
 	say(state, stdout, _("Falling back to patching base and 3-way merge..."));
@@ -1661,13 +1661,13 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 
 	/*
 	 * This is not so wrong. Depending on which base we picked, orig_tree
-	 * may be wildly different from ours, but his_tree has the same set of
+	 * may be wildly different from ours, but her_tree has the same set of
 	 * wildly different changes in parts the patch did not touch, so
 	 * recursive ends up canceling them, saying that we reverted all those
 	 * changes.
 	 */
 
-	if (run_fallback_merge_recursive(state, orig_tree, our_tree, his_tree)) {
+	if (run_fallback_merge_recursive(state, orig_tree, our_tree, her_tree)) {
 		rerere(state->allow_rerere_autoupdate);
 		return error(_("Failed to merge in the changes."));
 	}
-- 
2.9.0.280.g32e2a70


