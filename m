Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 000B42023C
	for <e@80x24.org>; Fri,  8 Jul 2016 07:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752008AbcGHHR6 (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 03:17:58 -0400
Received: from mout.gmx.net ([212.227.15.19]:61861 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751427AbcGHHR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 03:17:58 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Le5bY-1beHjO44qq-00py7Z; Fri, 08 Jul 2016 09:17:35
 +0200
Date:	Fri, 8 Jul 2016 09:17:34 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>, Mike Hommey <mh@glandium.org>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v2] am: counteract gender bias
In-Reply-To: <d54f8f8b32ecc024eb3a58dd42ef9f855f8e2cb9.1467892022.git.johannes.schindelin@gmx.de>
Message-ID: <ceb80e45d1f02b71cc5ad2d7ded04360c530a9a8.1467962234.git.johannes.schindelin@gmx.de>
References: <d54f8f8b32ecc024eb3a58dd42ef9f855f8e2cb9.1467892022.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:7gi0wiOs0qQyEm0BEfFtMELZq4GtFnDZ9creQ2fIDJ8k9PTPcsb
 JpD1S6qQwIjvJhIihHmEQJ95Fp3Oz4ZmsAxr+TY0W3aQJXO1u+XMQduhUPjon5BwWrVQ0M/
 qkCCKM2tScgyfzTgL9KutzgEbqdLPO/vfcrh5yRd2/VZ2ZX/LwzEnAyiOhWTqW9f+naYy4w
 y+2BqJKSggdDLxINnbGCg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:CdOJPr26TBQ=:5NJ79JyAsN68j1msI8pgef
 UZAJZ0YHpJVbaRO8KmTelZS3oDn9tHnzyDE5JkPJboGoYf9k2iMd9cDYOjnXXoif6C0komZyw
 3qULIpIHEJB3xWTEYz0tWw8YdJkTPP47U4siJYNFPTJxiwMIt2ofcrbJXpev4XHM4XSrglGnW
 8KtLhrzU6aHYeJ/9Q4JoS8XwQRKzaof+hEACbNzqSM3rw3NSqm/XFi1S4Ufde6j4ulln0A1kZ
 YnUeBUV/9wQsqCm5ZR/BF80+gWm3slemwKqK2cetcnymz1lXAsbJxQN8eiN7xIRFHY79pEYOK
 IRK2gFLDaktVrQh9h542JLfjeUSl7m7gtt4i1O5PQF5+txqrvk0vqvYo3X79xCEEXpntLwDdF
 lD5puQPZ0dI7isSnTiBPwkQ0v6GdL/W9y7+OQVdlUNQ2QSbSMaIn8c7movYAKNxN8DTkny5Ho
 xWLu1Ks0dN7vG+AERQDoOSauoKBC8hOeD1iUpCKpG5mPGjfxjzXNWRMaagsweYCMKN5XSInu5
 O2OWBE/guW1D3qOkXRrJum79SwgVljqifi0UaMdmDXTG8tFznLA0u9+2BX/l+Yul61+r7KkgE
 CKrTZ63OtoNsmUMOpBeuJ6Vjkqbj9g19fQ+rjwmTIAwwSrNOSaIICjQ9BXd7jktMpQsMZoJul
 3H8SGTinQEyE/tA82ztSipaf6iYwePE2zRYHRuAarBt2f8FL5OnGc1EffwETp1BdG9VaX8Nhp
 7Dz6RNopKRpjqfWVasN8xZ9Q64dY+uSxbgtOpg6+c/dM8h1CkEW8zFgN2ycWaNUEdsQCuEpFB
 GKOJPCg
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07), i.e. for
almost 11 years already, we used a male form to describe "the other
tree".

While most likely unintended, this gave the erroneous impression as if
the Git developers thought of users as male, and were unaware of the
important role in software development played by female actors such as
Ada Lovelace, Grace Hopper and Margaret Hamilton. In fact, the first
professional software developers were all female.

Let's change those unfortunate references to the gender neutral "their
tree".

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Published-As: https://github.com/dscho/git/releases/tag/gender-bias-v2
 builtin/am.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)
Interdiff vs v1:

 diff --git a/builtin/am.c b/builtin/am.c
 index 2c7f3dd..1f0aa99 100644
 --- a/builtin/am.c
 +++ b/builtin/am.c
 @@ -1584,14 +1584,14 @@ static int build_fake_ancestor(const struct am_state *state, const char *index_f
  }
  
  /**
 - * Do the three-way merge using fake ancestor, her tree constructed
 + * Do the three-way merge using fake ancestor, their tree constructed
   * from the fake ancestor and the postimage of the patch, and our
   * state.
   */
  static int run_fallback_merge_recursive(const struct am_state *state,
  					unsigned char *orig_tree,
  					unsigned char *our_tree,
 -					unsigned char *her_tree)
 +					unsigned char *their_tree)
  {
  	struct child_process cp = CHILD_PROCESS_INIT;
  	int status;
 @@ -1599,7 +1599,7 @@ static int run_fallback_merge_recursive(const struct am_state *state,
  	cp.git_cmd = 1;
  
  	argv_array_pushf(&cp.env_array, "GITHEAD_%s=%.*s",
 -			 sha1_to_hex(her_tree), linelen(state->msg), state->msg);
 +			 sha1_to_hex(their_tree), linelen(state->msg), state->msg);
  	if (state->quiet)
  		argv_array_push(&cp.env_array, "GIT_MERGE_VERBOSITY=0");
  
 @@ -1607,7 +1607,7 @@ static int run_fallback_merge_recursive(const struct am_state *state,
  	argv_array_push(&cp.args, sha1_to_hex(orig_tree));
  	argv_array_push(&cp.args, "--");
  	argv_array_push(&cp.args, sha1_to_hex(our_tree));
 -	argv_array_push(&cp.args, sha1_to_hex(her_tree));
 +	argv_array_push(&cp.args, sha1_to_hex(their_tree));
  
  	status = run_command(&cp) ? (-1) : 0;
  	discard_cache();
 @@ -1620,7 +1620,7 @@ static int run_fallback_merge_recursive(const struct am_state *state,
   */
  static int fall_back_threeway(const struct am_state *state, const char *index_path)
  {
 -	unsigned char orig_tree[GIT_SHA1_RAWSZ], her_tree[GIT_SHA1_RAWSZ],
 +	unsigned char orig_tree[GIT_SHA1_RAWSZ], their_tree[GIT_SHA1_RAWSZ],
  		      our_tree[GIT_SHA1_RAWSZ];
  
  	if (get_sha1("HEAD", our_tree) < 0)
 @@ -1657,7 +1657,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
  		return error(_("Did you hand edit your patch?\n"
  				"It does not apply to blobs recorded in its index."));
  
 -	if (write_index_as_tree(her_tree, &the_index, index_path, 0, NULL))
 +	if (write_index_as_tree(their_tree, &the_index, index_path, 0, NULL))
  		return error("could not write tree");
  
  	say(state, stdout, _("Falling back to patching base and 3-way merge..."));
 @@ -1667,13 +1667,13 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
  
  	/*
  	 * This is not so wrong. Depending on which base we picked, orig_tree
 -	 * may be wildly different from ours, but her_tree has the same set of
 +	 * may be wildly different from ours, but their_tree has the same set of
  	 * wildly different changes in parts the patch did not touch, so
  	 * recursive ends up canceling them, saying that we reverted all those
  	 * changes.
  	 */
  
 -	if (run_fallback_merge_recursive(state, orig_tree, our_tree, her_tree)) {
 +	if (run_fallback_merge_recursive(state, orig_tree, our_tree, their_tree)) {
  		rerere(state->allow_rerere_autoupdate);
  		return error(_("Failed to merge in the changes."));
  	}


diff --git a/builtin/am.c b/builtin/am.c
index d5da5fe..1f0aa99 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1584,14 +1584,14 @@ static int build_fake_ancestor(const struct am_state *state, const char *index_f
 }
 
 /**
- * Do the three-way merge using fake ancestor, his tree constructed
+ * Do the three-way merge using fake ancestor, their tree constructed
  * from the fake ancestor and the postimage of the patch, and our
  * state.
  */
 static int run_fallback_merge_recursive(const struct am_state *state,
 					unsigned char *orig_tree,
 					unsigned char *our_tree,
-					unsigned char *his_tree)
+					unsigned char *their_tree)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	int status;
@@ -1599,7 +1599,7 @@ static int run_fallback_merge_recursive(const struct am_state *state,
 	cp.git_cmd = 1;
 
 	argv_array_pushf(&cp.env_array, "GITHEAD_%s=%.*s",
-			 sha1_to_hex(his_tree), linelen(state->msg), state->msg);
+			 sha1_to_hex(their_tree), linelen(state->msg), state->msg);
 	if (state->quiet)
 		argv_array_push(&cp.env_array, "GIT_MERGE_VERBOSITY=0");
 
@@ -1607,7 +1607,7 @@ static int run_fallback_merge_recursive(const struct am_state *state,
 	argv_array_push(&cp.args, sha1_to_hex(orig_tree));
 	argv_array_push(&cp.args, "--");
 	argv_array_push(&cp.args, sha1_to_hex(our_tree));
-	argv_array_push(&cp.args, sha1_to_hex(his_tree));
+	argv_array_push(&cp.args, sha1_to_hex(their_tree));
 
 	status = run_command(&cp) ? (-1) : 0;
 	discard_cache();
@@ -1620,7 +1620,7 @@ static int run_fallback_merge_recursive(const struct am_state *state,
  */
 static int fall_back_threeway(const struct am_state *state, const char *index_path)
 {
-	unsigned char orig_tree[GIT_SHA1_RAWSZ], his_tree[GIT_SHA1_RAWSZ],
+	unsigned char orig_tree[GIT_SHA1_RAWSZ], their_tree[GIT_SHA1_RAWSZ],
 		      our_tree[GIT_SHA1_RAWSZ];
 
 	if (get_sha1("HEAD", our_tree) < 0)
@@ -1657,7 +1657,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 		return error(_("Did you hand edit your patch?\n"
 				"It does not apply to blobs recorded in its index."));
 
-	if (write_index_as_tree(his_tree, &the_index, index_path, 0, NULL))
+	if (write_index_as_tree(their_tree, &the_index, index_path, 0, NULL))
 		return error("could not write tree");
 
 	say(state, stdout, _("Falling back to patching base and 3-way merge..."));
@@ -1667,13 +1667,13 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 
 	/*
 	 * This is not so wrong. Depending on which base we picked, orig_tree
-	 * may be wildly different from ours, but his_tree has the same set of
+	 * may be wildly different from ours, but their_tree has the same set of
 	 * wildly different changes in parts the patch did not touch, so
 	 * recursive ends up canceling them, saying that we reverted all those
 	 * changes.
 	 */
 
-	if (run_fallback_merge_recursive(state, orig_tree, our_tree, his_tree)) {
+	if (run_fallback_merge_recursive(state, orig_tree, our_tree, their_tree)) {
 		rerere(state->allow_rerere_autoupdate);
 		return error(_("Failed to merge in the changes."));
 	}
-- 
2.9.0.278.g1caae67

base-commit: 5c589a73de4394ad125a4effac227b3aec856fa1
