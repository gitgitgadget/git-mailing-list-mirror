Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EAAD1F453
	for <e@80x24.org>; Wed,  3 Oct 2018 17:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbeJDABg (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 20:01:36 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42744 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbeJDABf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 20:01:35 -0400
Received: by mail-pf1-f196.google.com with SMTP id f26-v6so1839032pfn.9
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 10:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=WVnK0rhBNYFPstiMUpc7/jclqVtaqXJ6+ZH/tv+tlBc=;
        b=lwCktzkfKi2st5rcOkimtmDqmtANbCYzZ5bWg+lBKjhLOl8JCA4EHSgtNod4kMF8d1
         2eNzyKaa44Q60iZy/qHi6Z9XTUTta+LF0loIW9w5RHHA1C6yp26hHQUmGNE/iQau7N72
         Mfboek5N6CJ/OoAEKJ1Ulb9LnzAZoERav/C/Dcy2u6/LPTZdSW3jX7OlWdqKbrG+ZPHG
         rXAp4yA030bDTP4Wo11K2WxyKjm/I2UG/+oKjq7GGyKBdh2M/OjshQFsbmaTLwf8G7Hd
         r04Ewk4ADLaEObG4JVskYAWY6m7yuWdjsTNe2kslauuOn21HdaTWNzc8G6n1MkFPaiBh
         hSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WVnK0rhBNYFPstiMUpc7/jclqVtaqXJ6+ZH/tv+tlBc=;
        b=UI+W59Tnl8qAv005A9Zx0Q3a6DP6OJP2Mz2rRnabS7S6CQ03EcZ0cL8004w3WGJY2P
         ecyG+sIOfT52xRKB/UPDllqo7XtUC2Kcl9DZsowB5cLVcWN875BvTsbUdyh7Q/ZwVKzw
         x3ZLVI97XDzEYPfN7ec5WJTlnD6J4StuvhDYQKXr/crTEz92+c1iqLTMRMG5hN1xGbYW
         F5UKW+xuaJEqyzhol7n2fsd3Ise1+hEJiVpHbom2xpMDL5r04SdGt4PYkT/3W7bvjdJA
         pXEpGIJdwlvdaXs06T38i6p6+/5+ZN1AFmsKev9+xit6+b4IlxRXfr+Ib8al34wqfSQS
         OLcw==
X-Gm-Message-State: ABuFfohgCRHW6wGRFS74s4LTTfQm55MQ3GdlVLf4FsjA005vcClMr7Y6
        d/QT0obtjqysekJLf4ScxOoYbvA4
X-Google-Smtp-Source: ACcGV60Z0wx/5qv9/Ku6lyclhHCFui5KinYKipzOJWSceeWPNxMi1EF15EV1IV9l0cA2wxEmSmXJ+Q==
X-Received: by 2002:a65:6143:: with SMTP id o3-v6mr2254207pgv.52.1538586738332;
        Wed, 03 Oct 2018 10:12:18 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id p24-v6sm2012836pgm.70.2018.10.03.10.12.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 10:12:17 -0700 (PDT)
Date:   Wed, 03 Oct 2018 10:12:17 -0700 (PDT)
X-Google-Original-Date: Wed, 03 Oct 2018 17:12:11 GMT
Message-Id: <13032d847533cfecbd9a912312cab4f256e46b30.1538586732.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.42.v2.git.gitgitgadget@gmail.com>
References: <pull.42.git.gitgitgadget@gmail.com>
        <pull.42.v2.git.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Martin=20=C3=85gren?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Subject: [PATCH v2 2/3] builtin/commit-graph.c: UNLEAK variables
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>

`graph_verify()`, `graph_read()` and `graph_write()` do the hard work of
`cmd_commit_graph()`. As soon as these return, so does
`cmd_commit_graph()`.

`strbuf_getline()` may allocate memory in the strbuf, yet return EOF.
We need to release the strbuf or UNLEAK it. Go for the latter since we
are close to returning from `graph_write()`.

`graph_write()` also fails to free the strings in the string list. They
have been added to the list with `strdup_strings` set to 0. We could
flip `strdup_strings` before clearing the list, which is our usual hack
in situations like this. But since we are about to exit, let's just
UNLEAK the whole string list instead.

UNLEAK `graph` in `graph_verify`. While at it, and for consistency,
UNLEAK in `graph_read()` as well, and remove an unnecessary UNLEAK just
before dying.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/commit-graph.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index bc0fa9ba52..66f12eb009 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -64,6 +64,7 @@ static int graph_verify(int argc, const char **argv)
 	if (!graph)
 		return 0;
 
+	UNLEAK(graph);
 	return verify_commit_graph(the_repository, graph);
 }
 
@@ -89,10 +90,8 @@ static int graph_read(int argc, const char **argv)
 	graph_name = get_commit_graph_filename(opts.obj_dir);
 	graph = load_commit_graph_one(graph_name);
 
-	if (!graph) {
-		UNLEAK(graph_name);
+	if (!graph)
 		die("graph file %s does not exist", graph_name);
-	}
 
 	FREE_AND_NULL(graph_name);
 
@@ -115,7 +114,7 @@ static int graph_read(int argc, const char **argv)
 		printf(" large_edges");
 	printf("\n");
 
-	free_commit_graph(graph);
+	UNLEAK(graph);
 
 	return 0;
 }
@@ -166,6 +165,8 @@ static int graph_write(int argc, const char **argv)
 			pack_indexes = &lines;
 		if (opts.stdin_commits)
 			commit_hex = &lines;
+
+		UNLEAK(buf);
 	}
 
 	write_commit_graph(opts.obj_dir,
@@ -174,7 +175,7 @@ static int graph_write(int argc, const char **argv)
 			   opts.append,
 			   1);
 
-	string_list_clear(&lines, 0);
+	UNLEAK(lines);
 	return 0;
 }
 
-- 
gitgitgadget

