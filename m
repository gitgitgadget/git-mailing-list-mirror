Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC6591F744
	for <e@80x24.org>; Thu,  7 Jul 2016 11:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751614AbcGGLr2 (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 07:47:28 -0400
Received: from mout.gmx.net ([212.227.15.19]:60184 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751332AbcGGLr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 07:47:27 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M0xbD-1bZEPf39up-00v9p0; Thu, 07 Jul 2016 13:47:20
 +0200
Date:	Thu, 7 Jul 2016 13:47:19 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] am: counteract gender bias
Message-ID: <d54f8f8b32ecc024eb3a58dd42ef9f855f8e2cb9.1467892022.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:hRefAu33r3KHDUYtb/Mm8RiLwSb+QxU3qY3HuqqCDef0AUU98i+
 coUBxCpukT6+sWxqu2hGoRomzW3rvgTKn6wmn3UZOZUsECFkvNVTJ075JQ0+qzSbJbnoKq4
 0lGptnRmp4BgQVYVOtWzyWCFLiEXQQi0vkvnbvaQMCM1TTU954j6R6/j6rE2MLB0oczb1oz
 PHT1z0AFKkN5AO0n2cU8Q==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:wUXGXOAXgLs=:MI+uK5/x7hVKAybnnWUgas
 rYpFpOS78rjzh6GRH6LjWbDN71DWU7UWHPWbEr7eSxLpPiI1IP09fUHP/73WPFx3yOjv/zJ3Y
 pUVB1NWGY6zg5KcY6bg9LrT1LzHkOpmb8EH3lq5ZiqMm9y/AHXfrnGJqLHMZvWlgRhMJtIhwt
 wOqxNbPIcBvt0vAbCOxgF3Ugqc55hJGyYmKua3nG7jmaoW+6uGywZCD/IsHA/cidP4p5h/Opt
 EdvLWsWxurMuVN6O9A52JUg550y6WivEaYqs5JefWUZ3ntrEL8ldZGiTkDxD+Piw+AYMwksFe
 MOjJf5sf+Ih34KgG7AySD7mcme/vE8+YrA+hJy3s0t9Ym8atT5+aqmxq8VAhTMaPqzclVpqcI
 A24HPx4OBmaT14uedmuScDWclaymqCcTH1hKa5HnPWSCvmdFcsfX/5siLAMISqWx2ZgYDD+bH
 /igSqL0FhIlGTTFqvn18IimFDMBDwQWSvmZNUwb/PmfOOlOcH/IAuAYZH82p/hd49Rbg3eLNz
 dNxn+uUSU4WWrS7UjPOJSa+3NIxXN4YgXHFLhE+eaZXv1X8dujg9ybEYivuMeS5J4cx+Tinzv
 jC0TwkW+wrlTG+ioUznxAFsDrbjosskG6gzyF8+K0ZIESxkMARAdxZNyjSo03fJTCkh1SDNKY
 D1hR5bMvRGeewFLvPI9PrQQVS9bsQPm2zl4QeCnthk8pXRyFQNaJ0zhrp1losk8KQ2ehDJHhY
 yiSaxPUc49X768vxr2PmTOu8tYct3bBZesnYTz+EQ7jeZ+srdI44/q9a40QjU+Nx7EBGfh8k2
 wM9hWB6
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
Published-As: https://github.com/dscho/git/releases/tag/gender-bias-v1
 builtin/am.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index d5da5fe..2c7f3dd 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1584,14 +1584,14 @@ static int build_fake_ancestor(const struct am_state *state, const char *index_f
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
@@ -1599,7 +1599,7 @@ static int run_fallback_merge_recursive(const struct am_state *state,
 	cp.git_cmd = 1;
 
 	argv_array_pushf(&cp.env_array, "GITHEAD_%s=%.*s",
-			 sha1_to_hex(his_tree), linelen(state->msg), state->msg);
+			 sha1_to_hex(her_tree), linelen(state->msg), state->msg);
 	if (state->quiet)
 		argv_array_push(&cp.env_array, "GIT_MERGE_VERBOSITY=0");
 
@@ -1607,7 +1607,7 @@ static int run_fallback_merge_recursive(const struct am_state *state,
 	argv_array_push(&cp.args, sha1_to_hex(orig_tree));
 	argv_array_push(&cp.args, "--");
 	argv_array_push(&cp.args, sha1_to_hex(our_tree));
-	argv_array_push(&cp.args, sha1_to_hex(his_tree));
+	argv_array_push(&cp.args, sha1_to_hex(her_tree));
 
 	status = run_command(&cp) ? (-1) : 0;
 	discard_cache();
@@ -1620,7 +1620,7 @@ static int run_fallback_merge_recursive(const struct am_state *state,
  */
 static int fall_back_threeway(const struct am_state *state, const char *index_path)
 {
-	unsigned char orig_tree[GIT_SHA1_RAWSZ], his_tree[GIT_SHA1_RAWSZ],
+	unsigned char orig_tree[GIT_SHA1_RAWSZ], her_tree[GIT_SHA1_RAWSZ],
 		      our_tree[GIT_SHA1_RAWSZ];
 
 	if (get_sha1("HEAD", our_tree) < 0)
@@ -1657,7 +1657,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 		return error(_("Did you hand edit your patch?\n"
 				"It does not apply to blobs recorded in its index."));
 
-	if (write_index_as_tree(his_tree, &the_index, index_path, 0, NULL))
+	if (write_index_as_tree(her_tree, &the_index, index_path, 0, NULL))
 		return error("could not write tree");
 
 	say(state, stdout, _("Falling back to patching base and 3-way merge..."));
@@ -1667,13 +1667,13 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 
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
2.9.0.278.g1caae67

base-commit: 5c589a73de4394ad125a4effac227b3aec856fa1
