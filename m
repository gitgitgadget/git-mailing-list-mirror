Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3E7E1F404
	for <e@80x24.org>; Tue,  4 Sep 2018 21:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbeIEByU (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 21:54:20 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46405 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbeIEByT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 21:54:19 -0400
Received: by mail-pf1-f193.google.com with SMTP id u24-v6so2302266pfn.13
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 14:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=70J0y21jtzFomgqnjNbD3yGMrvwolbG5vVOCXOZ54oM=;
        b=E3l+YmZVVoNylLm1RkJ12479Aa5b/01sCrdDOgl/sZje+AozF739V//JaZuqtDN+8D
         dpGoByL107dCJjBe4lW5Wl1DuSOT2fnIPaBD/vZijDrIwW3aXQcUFphEDS07ww62VhE+
         4S+fVYKHQLagY1Uz/QOJie65Dzr23jKAKmVLXu6DbSjpmL9rqWwM2ltkFf7gX7l/MAlG
         9LKxdsT94zzy9d+8GweMp2PlWaBIoxetQu6IQn34iqdQ3wc5MIgwPMMvWBmkZgTzv7T7
         GS7Yc2PHULm0x7z/Gcd8g6w5qwxV1XhFhbhRmSYJL+dHe34vQINzIJJBodp/tTfb8X3S
         CpyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=70J0y21jtzFomgqnjNbD3yGMrvwolbG5vVOCXOZ54oM=;
        b=Ttcnn9NIJfI82dcVyNI0BxWIOuXNX1Im1VIUT0Pr6Wloc3nJlw/ymrYP4HXsZ4yfHl
         NmFDuV9+K+x+8kQnu+pZAVHNtB32o8D+LZ4rWjyLXWqKKiLBs5fEW2yG1c7DgPanaYlc
         +UGNhGzo2znSR5UZAf9p0PMZObK7m9l2anzRJddDzgb8LuyBs+32JV9KAH6oSDD7XVob
         bPf6XtMXfPZdvabqHSV4zV0m0PVphoXJzCIMwUU+HoMjEf8TIiweR+Dxxx1OoNGONdcV
         dPqZZrnNwReZP6xJ0ZjvPPYFXvtJcuMXIyjLPr1bMQ86cJVBtnAJPSQzFO56qbSfjSsG
         9H2Q==
X-Gm-Message-State: APzg51AHxhUlgs6HltV2hF6SssLpx/TWu3MbaC7aJ0hZ6BYCU51CT3me
        +xL2Mrky59KxtSHg0hOdaUuqltFW
X-Google-Smtp-Source: ANB0VdbE04o41k+VigXnjKi/a3K0fQbADfRqnI8lpyQwqdTuVseRw402T8CRXlTLIcLBBnouUwB7dg==
X-Received: by 2002:a63:d518:: with SMTP id c24-v6mr31806978pgg.357.1536096442432;
        Tue, 04 Sep 2018 14:27:22 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id f67-v6sm33369101pff.29.2018.09.04.14.27.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 14:27:21 -0700 (PDT)
Date:   Tue, 04 Sep 2018 14:27:21 -0700 (PDT)
X-Google-Original-Date: Tue, 04 Sep 2018 21:27:04 GMT
Message-Id: <e64190d8edbb1d085074e91acd64f0b7dfc97c86.1536096424.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.32.v2.git.gitgitgadget@gmail.com>
References: <20180808134830.19949-1-predatoramigo@gmail.com>
        <pull.32.v2.git.gitgitgadget@gmail.com>
From:   "Pratik Karki via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 11/11] builtin rebase: support `git rebase <upstream>
 <switch-to>`
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

This commit adds support for `switch-to` which is used to switch to the
target branch if needed. The equivalent codes found in shell script
`git-legacy-rebase.sh` is converted to builtin `rebase.c`.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 48 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index afc75fe731..e817956d96 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -79,6 +79,7 @@ struct rebase_options {
 	struct commit *onto;
 	const char *onto_name;
 	const char *revisions;
+	const char *switch_to;
 	int root;
 	struct commit *restrict_revision;
 	int dont_finish_rebase;
@@ -186,6 +187,8 @@ static int run_specific_rebase(struct rebase_options *opts)
 		opts->flags & REBASE_DIFFSTAT ? "t" : "");
 	add_var(&script_snippet, "force_rebase",
 		opts->flags & REBASE_FORCE ? "t" : "");
+	if (opts->switch_to)
+		add_var(&script_snippet, "switch_to", opts->switch_to);
 
 	switch (opts->type) {
 	case REBASE_AM:
@@ -564,9 +567,23 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	 * orig_head -- commit object name of tip of the branch before rebasing
 	 * head_name -- refs/heads/<that-branch> or NULL (detached HEAD)
 	 */
-	if (argc > 0)
-		 die("TODO: handle switch_to");
-	else {
+	if (argc == 1) {
+		/* Is it "rebase other branchname" or "rebase other commit"? */
+		branch_name = argv[0];
+		options.switch_to = argv[0];
+
+		/* Is it a local branch? */
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "refs/heads/%s", branch_name);
+		if (!read_ref(buf.buf, &options.orig_head))
+			options.head_name = xstrdup(buf.buf);
+		/* If not is it a valid ref (branch or commit)? */
+		else if (!get_oid(branch_name, &options.orig_head))
+			options.head_name = NULL;
+		else
+			die(_("fatal: no such branch/commit '%s'"),
+			    branch_name);
+	} else if (argc == 0) {
 		/* Do not need to switch branches, we are already on it. */
 		options.head_name =
 			xstrdup_or_null(resolve_ref_unsafe("HEAD", 0, NULL,
@@ -585,7 +602,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		}
 		if (get_oid("HEAD", &options.orig_head))
 			die(_("Could not resolve HEAD to a revision"));
-	}
+	} else
+		BUG("unexpected number of arguments left to parse");
 
 	if (read_index(the_repository->index) < 0)
 		die(_("could not read index"));
@@ -612,6 +630,28 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		int flag;
 
 		if (!(options.flags & REBASE_FORCE)) {
+			/* Lazily switch to the target branch if needed... */
+			if (options.switch_to) {
+				struct object_id oid;
+
+				if (get_oid(options.switch_to, &oid) < 0) {
+					ret = !!error(_("could not parse '%s'"),
+						      options.switch_to);
+					goto cleanup;
+				}
+
+				strbuf_reset(&buf);
+				strbuf_addf(&buf, "rebase: checkout %s",
+					    options.switch_to);
+				if (reset_head(&oid, "checkout",
+					       options.head_name, 0) < 0) {
+					ret = !!error(_("could not switch to "
+							"%s"),
+						      options.switch_to);
+					goto cleanup;
+				}
+			}
+
 			if (!(options.flags & REBASE_NO_QUIET))
 				; /* be quiet */
 			else if (!strcmp(branch_name, "HEAD") &&
-- 
gitgitgadget
