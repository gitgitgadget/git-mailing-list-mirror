Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E6EC1F404
	for <e@80x24.org>; Tue,  4 Sep 2018 22:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbeIEC1P (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 22:27:15 -0400
Received: from mail-pg1-f179.google.com ([209.85.215.179]:34044 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbeIEC1O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 22:27:14 -0400
Received: by mail-pg1-f179.google.com with SMTP id d19-v6so2332236pgv.1
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 15:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XK+vaMxv64RLoIZ2pv27EvCSdB+Vwk94hRpo/2tSj4Q=;
        b=MFOUnd0l/6vJUYmwuzw+4Ju26dB6Ms9v6EWip1cDKYYGxaV3JXF49naF4EfqglrtJ5
         BV3eHqOXO/H1kaRMOqQ7qdbol6kZM7dbdx0SnAVO55pGakG1FKjsoeSuQ5mFHUH+mWLh
         jMHsHKN6KV2lVQBzbmVRs4rnkezw15D8D9QRm6XMnOOVQ+7mcymdpvFETS1/8oq5Gurq
         e7KjXynYnZiCTiLtThZFXyek+pbabhj08SecEpUz2o/ykJVX2a16Sfj9V2egi6B0VuAy
         YMhfXGeEasYny2nlPA5F4wEFl2BsOreC6v0P5IXYX9suwoR89wZcnWILZfhqDhWenOiQ
         u9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XK+vaMxv64RLoIZ2pv27EvCSdB+Vwk94hRpo/2tSj4Q=;
        b=S3TXeUoxCZyuUL1DDdxBYUF04WCVG2cIWQaGVqwzHtjE2ZnAWw5lFX4xs9rr86p3mN
         cdWMP+BYKK/Z9+9VQ2tWvuHvEhfl7pb7D9x7iKMH/8MTpBPYo2EyrqSSUqwTFWMFopSw
         PW1+OWH1j81OL6IOEatbPAoeFy1FkRYzKjqmGTnlkyMmQIPP8EXWLhA3ZLn+/4YajhIv
         +T+DmL/np48sNgE4LdJJTfUeh6Sh/UtyCBGOj31/s4o8/2wtAeb9WjHE7+BGIPAR/tDl
         MHAdnVCVeGNgWuEeckoI5R0hsavBT4s3bYPwmNMvE8xzSAYdyaW5Hm/FxyGiNqE1HkFw
         AXiQ==
X-Gm-Message-State: APzg51B1IugGFX1q01l+Sx5GloqgkiqsUCCzjgtGNkooXF0kvVuNJcYl
        9IvpLAgYgPb85ksAgAXwv0GiJjAM
X-Google-Smtp-Source: ANB0VdZr2Sq9/vyHl9xmcEZ3Ry8YgB5fx0gBetM7/UMswSW02yaeYdqHntYtuh9X7NeWkAz7jSwHBQ==
X-Received: by 2002:a62:5882:: with SMTP id m124-v6mr37011451pfb.249.1536098409265;
        Tue, 04 Sep 2018 15:00:09 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id a192-v6sm40629917pfa.124.2018.09.04.15.00.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 15:00:08 -0700 (PDT)
Date:   Tue, 04 Sep 2018 15:00:08 -0700 (PDT)
X-Google-Original-Date: Tue, 04 Sep 2018 21:59:42 GMT
Message-Id: <05652bccfeed8b9a70a3b1e16e5490e6c91acbc8.1536098386.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.33.v2.git.gitgitgadget@gmail.com>
References: <20180808152140.14585-1-predatoramigo@gmail.com>
        <pull.33.v2.git.gitgitgadget@gmail.com>
From:   "Pratik Karki via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 15/18] merge-base --fork-point: extract libified function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Pratik Karki <predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pratik Karki <predatoramigo@gmail.com>

We need this functionality in the builtin rebase.

Note: to make this function truly reusable, we have to switch the call
get_merges_many_dirty() to get_merges_many() because we want the commit
flags to be reset (otherwise, subsequent get_merge_bases() calls would
obtain incorrect results). This did not matter when the function was
called in `git rev-parse --fork-point` because in that command, the
process definitely did not traverse any commits before exiting.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/merge-base.c | 81 ++++----------------------------------------
 commit.c             | 81 ++++++++++++++++++++++++++++++++++++++++++++
 commit.h             |  2 ++
 3 files changed, 89 insertions(+), 75 deletions(-)

diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 08d91b1f0c..790ceaeed6 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -110,54 +110,12 @@ static int handle_is_ancestor(int argc, const char **argv)
 		return 1;
 }
 
-struct rev_collect {
-	struct commit **commit;
-	int nr;
-	int alloc;
-	unsigned int initial : 1;
-};
-
-static void add_one_commit(struct object_id *oid, struct rev_collect *revs)
-{
-	struct commit *commit;
-
-	if (is_null_oid(oid))
-		return;
-
-	commit = lookup_commit(the_repository, oid);
-	if (!commit ||
-	    (commit->object.flags & TMP_MARK) ||
-	    parse_commit(commit))
-		return;
-
-	ALLOC_GROW(revs->commit, revs->nr + 1, revs->alloc);
-	revs->commit[revs->nr++] = commit;
-	commit->object.flags |= TMP_MARK;
-}
-
-static int collect_one_reflog_ent(struct object_id *ooid, struct object_id *noid,
-				  const char *ident, timestamp_t timestamp,
-				  int tz, const char *message, void *cbdata)
-{
-	struct rev_collect *revs = cbdata;
-
-	if (revs->initial) {
-		revs->initial = 0;
-		add_one_commit(ooid, revs);
-	}
-	add_one_commit(noid, revs);
-	return 0;
-}
-
 static int handle_fork_point(int argc, const char **argv)
 {
 	struct object_id oid;
 	char *refname;
+	struct commit *derived, *fork_point;
 	const char *commitname;
-	struct rev_collect revs;
-	struct commit *derived;
-	struct commit_list *bases;
-	int i, ret = 0;
 
 	switch (dwim_ref(argv[0], strlen(argv[0]), &oid, &refname)) {
 	case 0:
@@ -173,41 +131,14 @@ static int handle_fork_point(int argc, const char **argv)
 		die("Not a valid object name: '%s'", commitname);
 
 	derived = lookup_commit_reference(the_repository, &oid);
-	memset(&revs, 0, sizeof(revs));
-	revs.initial = 1;
-	for_each_reflog_ent(refname, collect_one_reflog_ent, &revs);
 
-	if (!revs.nr && !get_oid(refname, &oid))
-		add_one_commit(&oid, &revs);
+	fork_point = get_fork_point(refname, derived);
 
-	for (i = 0; i < revs.nr; i++)
-		revs.commit[i]->object.flags &= ~TMP_MARK;
-
-	bases = get_merge_bases_many_dirty(derived, revs.nr, revs.commit);
-
-	/*
-	 * There should be one and only one merge base, when we found
-	 * a common ancestor among reflog entries.
-	 */
-	if (!bases || bases->next) {
-		ret = 1;
-		goto cleanup_return;
-	}
-
-	/* And the found one must be one of the reflog entries */
-	for (i = 0; i < revs.nr; i++)
-		if (&bases->item->object == &revs.commit[i]->object)
-			break; /* found */
-	if (revs.nr <= i) {
-		ret = 1; /* not found */
-		goto cleanup_return;
-	}
-
-	printf("%s\n", oid_to_hex(&bases->item->object.oid));
+	if (!fork_point)
+		return 1;
 
-cleanup_return:
-	free_commit_list(bases);
-	return ret;
+	printf("%s\n", oid_to_hex(&fork_point->object.oid));
+	return 0;
 }
 
 int cmd_merge_base(int argc, const char **argv, const char *prefix)
diff --git a/commit.c b/commit.c
index 30d1af2b20..a3fc77a4eb 100644
--- a/commit.c
+++ b/commit.c
@@ -17,6 +17,7 @@
 #include "sha1-lookup.h"
 #include "wt-status.h"
 #include "advice.h"
+#include "refs.h"
 
 static struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);
 
@@ -958,6 +959,86 @@ static struct commit_list *merge_bases_many(struct commit *one, int n, struct co
 	return result;
 }
 
+struct rev_collect {
+	struct commit **commit;
+	int nr;
+	int alloc;
+	unsigned int initial : 1;
+};
+
+static void add_one_commit(struct object_id *oid, struct rev_collect *revs)
+{
+	struct commit *commit;
+
+	if (is_null_oid(oid))
+		return;
+
+	commit = lookup_commit(the_repository, oid);
+	if (!commit ||
+	    (commit->object.flags & TMP_MARK) ||
+	    parse_commit(commit))
+		return;
+
+	ALLOC_GROW(revs->commit, revs->nr + 1, revs->alloc);
+	revs->commit[revs->nr++] = commit;
+	commit->object.flags |= TMP_MARK;
+}
+
+static int collect_one_reflog_ent(struct object_id *ooid, struct object_id *noid,
+				  const char *ident, timestamp_t timestamp,
+				  int tz, const char *message, void *cbdata)
+{
+	struct rev_collect *revs = cbdata;
+
+	if (revs->initial) {
+		revs->initial = 0;
+		add_one_commit(ooid, revs);
+	}
+	add_one_commit(noid, revs);
+	return 0;
+}
+
+struct commit *get_fork_point(const char *refname, struct commit *commit)
+{
+	struct object_id oid;
+	struct rev_collect revs;
+	struct commit_list *bases;
+	int i;
+	struct commit *ret = NULL;
+
+	memset(&revs, 0, sizeof(revs));
+	revs.initial = 1;
+	for_each_reflog_ent(refname, collect_one_reflog_ent, &revs);
+
+	if (!revs.nr && !get_oid(refname, &oid))
+		add_one_commit(&oid, &revs);
+
+	for (i = 0; i < revs.nr; i++)
+		revs.commit[i]->object.flags &= ~TMP_MARK;
+
+	bases = get_merge_bases_many(commit, revs.nr, revs.commit);
+
+	/*
+	 * There should be one and only one merge base, when we found
+	 * a common ancestor among reflog entries.
+	 */
+	if (!bases || bases->next)
+		goto cleanup_return;
+
+	/* And the found one must be one of the reflog entries */
+	for (i = 0; i < revs.nr; i++)
+		if (&bases->item->object == &revs.commit[i]->object)
+			break; /* found */
+	if (revs.nr <= i)
+		goto cleanup_return;
+
+	ret = bases->item;
+
+cleanup_return:
+	free_commit_list(bases);
+	return ret;
+}
+
 struct commit_list *get_octopus_merge_bases(struct commit_list *in)
 {
 	struct commit_list *i, *j, *k, *ret = NULL;
diff --git a/commit.h b/commit.h
index da0db36eba..b34240017f 100644
--- a/commit.h
+++ b/commit.h
@@ -211,6 +211,8 @@ extern struct commit_list *get_octopus_merge_bases(struct commit_list *in);
 /* To be used only when object flags after this call no longer matter */
 extern struct commit_list *get_merge_bases_many_dirty(struct commit *one, int n, struct commit **twos);
 
+struct commit *get_fork_point(const char *refname, struct commit *commit);
+
 /* largest positive number a signed 32-bit integer can contain */
 #define INFINITE_DEPTH 0x7fffffff
 
-- 
gitgitgadget

