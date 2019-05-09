Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 119E41F45F
	for <e@80x24.org>; Thu,  9 May 2019 14:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfEIOWg (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 10:22:36 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38434 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfEIOWf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 10:22:35 -0400
Received: by mail-ed1-f67.google.com with SMTP id w11so2202669edl.5
        for <git@vger.kernel.org>; Thu, 09 May 2019 07:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=o5ihOxM7HtDO1LAqn6SqgiqUqnM47+LCtyPyIIP1Vzk=;
        b=envlJi4rQ7kbrfRquGbv09a4f1LbW6W11fMNOZtx+mJ5gSLZRJaqNFui4Iv72i4Gxb
         VM0a0eWmyqJXGWh4JI7q2cKZ6nkofBb/1b4S82kSiYvnzXTAosV5BboDM+2GwmtOcyyO
         9PAod6yeAu0dWWHTpHFhg1sJASbZNVt7S8seOd7XvoKhi9qIEZeAsICVxptTv4t5ihgV
         FmfRSI3JPFBGqTWiIUjTXdH/1xeYFRrIkSGVwd8e/2oRZQulq2i4kMYJClZHIdJ9biVX
         xuyau5HcZIWme59PKWjbFC3sOIgeX8xzrM3VRGtfNwC3MEiVwnXtqr9zeMHbolDduIdp
         CNaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=o5ihOxM7HtDO1LAqn6SqgiqUqnM47+LCtyPyIIP1Vzk=;
        b=oVPBhtqbTepQCe8puOEY+pdcXVD6EBi5FBbFSYz9ZiC7BvvTT66Qi7uU5w74bg1+xe
         XmLG7K1YNRz8BHO24q8o8bdrChQLBev7L9tNS4VIu0rAtrIsr2zhz11EEbz8cCBkvHT1
         BxYRadPgYzjk9MPEHvidnGybXSJHEE062FAfA01NVpOTii7KikNw78pNQhcQxxpbRK+I
         EB08vdRvhJ1fG6zXPUFhgD3DQpC/ZZqjxuvF+uizcswDLZbKuxR4IK9AVSgpfiTH3TQ8
         ncKqUh0W5MVtUiiwDnveHs8y7gCSi3P3GtaPg6OP5M73sLaPEVk2rhHqcWP1SoSEtv3+
         Clag==
X-Gm-Message-State: APjAAAXpnyFsBvYKeJT+0powKMdUex9R92M6mFVtExIhxeaS28X+b7oi
        YuQUywK5c1VlLHvjTAiMnNNzD56A
X-Google-Smtp-Source: APXvYqw2yUn7MlFwqkVCv4TUok5Rt0Zj/0PknfWZarzwpDYIslIgN+yUMDoAx8uiw4nVGJ1Iosm2BA==
X-Received: by 2002:a50:aed8:: with SMTP id f24mr4387997edd.214.1557411753865;
        Thu, 09 May 2019 07:22:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 16sm339358ejv.64.2019.05.09.07.22.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 07:22:33 -0700 (PDT)
Date:   Thu, 09 May 2019 07:22:33 -0700 (PDT)
X-Google-Original-Date: Thu, 09 May 2019 14:22:21 GMT
Message-Id: <469d0c9a32ba5a3f797b5bb50f37d6ac7746385b.1557411749.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.112.v4.git.gitgitgadget@gmail.com>
References: <pull.112.v3.git.gitgitgadget@gmail.com>
        <pull.112.v4.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 03/11] commit-graph: collapse parameters into flags
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, avarab@gmail.com, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The write_commit_graph() and write_commit_graph_reachable() methods
currently take two boolean parameters: 'append' and 'report_progress'.
We will soon expand the possible options to send to these methods, so
instead of complicating the parameter list, first simplify it.

Collapse these parameters into a 'flags' parameter, and adjust the
callers to provide flags as necessary.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/commit-graph.c | 8 +++++---
 builtin/commit.c       | 2 +-
 builtin/gc.c           | 4 ++--
 commit-graph.c         | 9 +++++----
 commit-graph.h         | 8 +++++---
 5 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 2e86251f02..828b1a713f 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -142,6 +142,7 @@ static int graph_write(int argc, const char **argv)
 	struct string_list *commit_hex = NULL;
 	struct string_list lines;
 	int result;
+	int flags = COMMIT_GRAPH_PROGRESS;
 
 	static struct option builtin_commit_graph_write_options[] = {
 		OPT_STRING(0, "object-dir", &opts.obj_dir,
@@ -166,11 +167,13 @@ static int graph_write(int argc, const char **argv)
 		die(_("use at most one of --reachable, --stdin-commits, or --stdin-packs"));
 	if (!opts.obj_dir)
 		opts.obj_dir = get_object_directory();
+	if (opts.append)
+		flags |= COMMIT_GRAPH_APPEND;
 
 	read_replace_refs = 0;
 
 	if (opts.reachable)
-		return write_commit_graph_reachable(opts.obj_dir, opts.append, 1);
+		return write_commit_graph_reachable(opts.obj_dir, flags);
 
 	string_list_init(&lines, 0);
 	if (opts.stdin_packs || opts.stdin_commits) {
@@ -190,8 +193,7 @@ static int graph_write(int argc, const char **argv)
 	result = write_commit_graph(opts.obj_dir,
 				    pack_indexes,
 				    commit_hex,
-				    opts.append,
-				    1);
+				    flags);
 
 	UNLEAK(lines);
 	return result;
diff --git a/builtin/commit.c b/builtin/commit.c
index b9ea7222fa..b001ef565d 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1670,7 +1670,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		      "not exceeded, and then \"git reset HEAD\" to recover."));
 
 	if (git_env_bool(GIT_TEST_COMMIT_GRAPH, 0) &&
-	    write_commit_graph_reachable(get_object_directory(), 0, 0))
+	    write_commit_graph_reachable(get_object_directory(), 0))
 		return 1;
 
 	repo_rerere(the_repository, 0);
diff --git a/builtin/gc.c b/builtin/gc.c
index 3984addf73..df2573f124 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -665,8 +665,8 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	}
 
 	if (gc_write_commit_graph &&
-	    write_commit_graph_reachable(get_object_directory(), 0,
-					 !quiet && !daemonized))
+	    write_commit_graph_reachable(get_object_directory(),
+					 !quiet && !daemonized ? COMMIT_GRAPH_PROGRESS : 0))
 		return 1;
 
 	if (auto_gc && too_many_loose_objects())
diff --git a/commit-graph.c b/commit-graph.c
index ee487a364b..8bbd50658c 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -851,15 +851,14 @@ static int add_ref_to_list(const char *refname,
 	return 0;
 }
 
-int write_commit_graph_reachable(const char *obj_dir, int append,
-				 int report_progress)
+int write_commit_graph_reachable(const char *obj_dir, unsigned int flags)
 {
 	struct string_list list = STRING_LIST_INIT_DUP;
 	int result;
 
 	for_each_ref(add_ref_to_list, &list);
 	result = write_commit_graph(obj_dir, NULL, &list,
-				    append, report_progress);
+				    flags);
 
 	string_list_clear(&list, 0);
 	return result;
@@ -868,7 +867,7 @@ int write_commit_graph_reachable(const char *obj_dir, int append,
 int write_commit_graph(const char *obj_dir,
 		       struct string_list *pack_indexes,
 		       struct string_list *commit_hex,
-		       int append, int report_progress)
+		       unsigned int flags)
 {
 	struct packed_oid_list oids;
 	struct packed_commit_list commits;
@@ -887,6 +886,8 @@ int write_commit_graph(const char *obj_dir,
 	struct strbuf progress_title = STRBUF_INIT;
 	unsigned long approx_nr_objects;
 	int res = 0;
+	int append = flags & COMMIT_GRAPH_APPEND;
+	int report_progress = flags & COMMIT_GRAPH_PROGRESS;
 
 	if (!commit_graph_compatible(the_repository))
 		return 0;
diff --git a/commit-graph.h b/commit-graph.h
index d15670bf46..70f4caf0c7 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -65,12 +65,14 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
  */
 int generation_numbers_enabled(struct repository *r);
 
-int write_commit_graph_reachable(const char *obj_dir, int append,
-				  int report_progress);
+#define COMMIT_GRAPH_APPEND     (1 << 0)
+#define COMMIT_GRAPH_PROGRESS   (1 << 1)
+
+int write_commit_graph_reachable(const char *obj_dir, unsigned int flags);
 int write_commit_graph(const char *obj_dir,
 		       struct string_list *pack_indexes,
 		       struct string_list *commit_hex,
-		       int append, int report_progress);
+		       unsigned int flags);
 
 int verify_commit_graph(struct repository *r, struct commit_graph *g);
 
-- 
gitgitgadget

