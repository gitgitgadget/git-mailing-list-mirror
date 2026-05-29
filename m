Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E953264FF
	for <git@vger.kernel.org>; Fri, 29 May 2026 08:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780042647; cv=none; b=lL4rNg23+a0TEiWWhS1X4V4jIeUWBzR8tiD0okbqqjtad7fBcv4vkb5GA1h/smjnsk9MvQLj4XKf7pcszKSSMhipq4NqMsploUCy2ovMhIAKBS5eVq8UhKJJcAg+KPZzyIUX/3i/ohMh5JDy4teUBQinjnuH1h9hkflulZ1GYEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780042647; c=relaxed/simple;
	bh=pJzSLU+F1Pn36jD0wlDmI/gBqty3m4nOBHDh052O9us=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pByubOpFqsZA0F2QprDZ8QNlx/RU9nCmkC7YCeJsAqzyzarj6/T7N+E6tiv8liiHlKRslI671xD9iFiICj5IhmmC/7qI+chowpR/Vss3ndpU2Dsz+Nopkg333MdjL+B6EpGaVYTeKpSGEdQ2FSTMUKRwK0V7XmpqLhFaU9JMnR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=duJYzT8n; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="duJYzT8n"
Date: Fri, 29 May 2026 16:17:04 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wyuan.org; s=key1;
	t=1780042642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=piM7GKwEXzhxYoS/PuORhq67KW3qADIulFUlA7anS1s=;
	b=duJYzT8n5hzJNl1Yrca5fCT6lCMG31la8rxhdJ2F/eGkmy9xAqCbipSIzaiUDyV0bq7gi9
	6acngUw35HxvwkVHO5rkldC3qv3g0qZSCCfNIEe9WSGifRm/EHL7K3OniCRxoTyx3+NsnA
	+aKNYbTgK3dU8NLAHfAqPvD8/fGFrVeikWp5r3N0PqsuvKSW4v5KJW8pF3G+G5yO+JcdH8
	w1dBVbftlnj18XuXDLu46fyRAY93CP2Nh8iFVie/QGhi84i/J4z8Ea9wCorCVz+CymfRg6
	u+MUVlRH8b1pBU8IvdKV0qz1Gl9Y5MpZWDVpY10Ya0Nu5kIoNWyR9VgKUxu0cg==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Weijie Yuan <wy@wyuan.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Andrew Kreimer <algonell@gmail.com>, git@vger.kernel.org
Subject: [PATCH] docs: fix typos and grammar
Message-ID: <7b502e20e9495cd4720496bd6738a1fbeb453410.1780041658.git.wy@wyuan.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahHi0r7DZYfQ1Xqy@wy@wyuan.org>
X-Migadu-Flow: FLOW_OUT

Fix several spelling mistakes, subject-verb agreement issues, and
duplicated words.

Signed-off-by: Weijie Yuan <wy@wyuan.org>
---

Sorry for my previous meaningless email, now I realize it's better to
come up with a real patch, insteading of talks.

I hope this does not duplicate the previous patch, though I've check
twice.

summary:

* the ones that has
                -> have

* duplicated words

* ambigious -> ambiguous


ps: my last email has an invalid Message-ID, sorry for b4 users.


 Documentation/fetch-options.adoc     | 2 +-
 combine-diff.c                       | 2 +-
 contrib/subtree/t/t7900-subtree.sh   | 2 +-
 csum-file.h                          | 2 +-
 delta-islands.c                      | 2 +-
 diffcore-pickaxe.c                   | 2 +-
 odb.h                                | 2 +-
 parse-options.c                      | 2 +-
 rerere.c                             | 2 +-
 t/t4203-mailmap.sh                   | 2 +-
 t/t9100-git-svn-basic.sh             | 2 +-
 t/test-lib-github-workflow-markup.sh | 2 +-
 t/test-lib-junit.sh                  | 2 +-
 tree-walk.h                          | 2 +-
 14 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
index 8074004377..035f780e58 100644
--- a/Documentation/fetch-options.adoc
+++ b/Documentation/fetch-options.adoc
@@ -1,6 +1,6 @@
 `--all`::
 `--no-all`::
-	Fetch all remotes, except for the ones that has the
+	Fetch all remotes, except for the ones that have the
 	`remote.<name>.skipFetchAll` configuration variable set.
 	This overrides the configuration variable `fetch.all`.

diff --git a/combine-diff.c b/combine-diff.c
index b799862068..720768ce41 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -666,7 +666,7 @@ static int make_hunks(struct sline *sline, unsigned long cnt,
 		 *   (-) line, which records from what parents the line
 		 *       was removed; this line does not appear in the result.
 		 * then check the set of parents the result has difference
-		 * from, from all lines.  If there are lines that has
+		 * from, from all lines.  If there are lines that have
 		 * different set of parents that the result has differences
 		 * from, that means we have more than two versions.
 		 *
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 18d2b56448..4194687cfb 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -75,7 +75,7 @@ test_create_pre2_32_repo () {
 #
 # Create a simple subtree on a new branch named ORPHAN in REPO.
 # The subtree is then merged into the current branch of REPO,
-# under PREFIX. The generated subtree has has one commit
+# under PREFIX. The generated subtree has one commit
 # with subject and tag FILENAME with a single file "FILENAME.t"
 #
 # When this method returns:
diff --git a/csum-file.h b/csum-file.h
index a9b390d336..a270738a7a 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -52,7 +52,7 @@ struct hashfd_options {
 	 */
 	struct progress *progress;

-	/* The length of the buffer that shall be used read read data. */
+	/* The length of the buffer that shall be used to read data. */
 	size_t buffer_len;
 };

diff --git a/delta-islands.c b/delta-islands.c
index f4d2468790..e71a7e1c05 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -527,7 +527,7 @@ void free_island_marks(void)
 		kh_destroy_oid_map(island_marks);
 	}

-	/* detect use-after-free with a an address which is never valid: */
+	/* detect use-after-free with an address which is never valid: */
 	island_marks = (void *)-1;
 }

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index a52d569911..b0915be86f 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -203,7 +203,7 @@ static void pickaxe(struct diff_queue_struct *q, struct diff_options *o,
 		for (i = 0; i < q->nr; i++)
 			diff_free_filepair(q->queue[i]);
 	} else {
-		/* Showing only the filepairs that has the needle */
+		/* Showing only the filepairs that have the needle */
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
 			if (pickaxe_match(p, o, regexp, kws, fn))
diff --git a/odb.h b/odb.h
index 73553ed5a7..0030467a52 100644
--- a/odb.h
+++ b/odb.h
@@ -40,7 +40,7 @@ struct object_database {
 	struct repository *repo;

 	/*
-	 * State of current current object database transaction. Only one
+	 * State of current object database transaction. Only one
 	 * transaction may be pending at a time. Is NULL when no transaction is
 	 * configured.
 	 */
diff --git a/parse-options.c b/parse-options.c
index a676da86f5..f4647e0099 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -1149,7 +1149,7 @@ enum parse_opt_result parse_options_step(struct parse_opt_ctx_t *ctx,
 		    (ctx->flags & PARSE_OPT_KEEP_UNKNOWN_OPT)) {
 			/*
 			 * Found an unknown option given to a command with
-			 * subcommands that has a default operation mode:
+			 * subcommands that have a default operation mode:
 			 * we treat this option and all remaining args as
 			 * arguments meant to that default operation mode.
 			 * So we are done parsing.
diff --git a/rerere.c b/rerere.c
index 0296700f9f..28a740b771 100644
--- a/rerere.c
+++ b/rerere.c
@@ -548,7 +548,7 @@ static int check_one_conflict(struct index_state *istate, int i, int *type)

 /*
  * Scan the index and find paths that have conflicts that rerere can
- * handle, i.e. the ones that has both stages #2 and #3.
+ * handle, i.e. the ones that have both stages #2 and #3.
  *
  * NEEDSWORK: we do not record or replay a previous "resolve by
  * deletion" for a delete-modify conflict, as that is inherently risky
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 74b7ddccb2..03f6df9d24 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -180,7 +180,7 @@ test_expect_success 'mailmap.file set' '
 	git shortlog HEAD >actual &&
 	test_cmp expect actual &&

-	# The internal_mailmap/.mailmap file is an a subdirectory, but
+	# The internal_mailmap/.mailmap file is in a subdirectory, but
 	# as shown here it can also be outside the repository
 	test_when_finished "rm -rf sub-repo" &&
 	git clone . sub-repo &&
diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index af28b01fef..1ab98b9c37 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -232,7 +232,7 @@ test_expect_success POSIXPERM,SYMLINKS "$name" '
 	test_cmp expected.$(test_oid algo) a
 '

-test_expect_success 'exit if remote refs are ambigious' '
+test_expect_success 'exit if remote refs are ambiguous' '
 	git config --add svn-remote.svn.fetch \
 		bar:refs/remotes/git-svn &&
 	test_must_fail git svn migrate
diff --git a/t/test-lib-github-workflow-markup.sh b/t/test-lib-github-workflow-markup.sh
index 33405c90d7..fa29a62aa3 100644
--- a/t/test-lib-github-workflow-markup.sh
+++ b/t/test-lib-github-workflow-markup.sh
@@ -18,7 +18,7 @@
 #
 # The idea is for `test-lib.sh` to source this file when run in GitHub
 # workflows; these functions will then override (empty) functions
-# that are are called at the appropriate times during the test runs.
+# that are called at the appropriate times during the test runs.

 test_skip_test_preamble=t

diff --git a/t/test-lib-junit.sh b/t/test-lib-junit.sh
index 76cbbd3299..f4994dd9d3 100644
--- a/t/test-lib-junit.sh
+++ b/t/test-lib-junit.sh
@@ -19,7 +19,7 @@
 #
 # The idea is for `test-lib.sh` to source this file when the user asks
 # for JUnit XML; these functions will then override (empty) functions
-# that are are called at the appropriate times during the test runs.
+# that are called at the appropriate times during the test runs.

 start_test_output () {
 	junit_xml_dir="$TEST_OUTPUT_DIRECTORY/out"
diff --git a/tree-walk.h b/tree-walk.h
index 29a55328bd..9646c47ac5 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -177,7 +177,7 @@ struct traverse_info {

 /**
  * Walk trees starting with "tree_oid" to find the entry for "name", and
- * return the the object name and the mode of the found entry via the
+ * return the object name and the mode of the found entry via the
  * "oid" and "mode" parameters.  Return 0 if the entry is found, and -1
  * otherwise.
  */
--
2.54.0

