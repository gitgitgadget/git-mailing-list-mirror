Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3417F1F453
	for <e@80x24.org>; Wed,  3 Oct 2018 17:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbeJDABe (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 20:01:34 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39469 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbeJDABd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 20:01:33 -0400
Received: by mail-pl1-f193.google.com with SMTP id w14-v6so3781762plp.6
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 10:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=pFzp3t3ScLKQyR0iJgAovX+Jm5j9rNvFghhamcCOXDw=;
        b=TzNIcxFDSMZBMYBShqoRLHj2O5J5++vJA/EjRGjfgsuyl57IkYu4L0fATmUhY4SdIh
         rVVIS94UInQNV2hMU/hA/gWXqivYyOxyzHi75wBZIMfteWpGXbjfMx0pAEEtSkGSB288
         iYnyI/i9GGfMvth/78lBvyjy29BR8Mn7jIEywkSTHaKw+hvQy1wDcW3aQIBtJOa30+Rp
         t/IHuS5ihcfIO+iToviZg07KyX1J1RSdm7YGvgLFAmJ3AYx/2SXZ3IOeFFqiekELQyqN
         vSQgqcaEtcMOgp77vmJDHkvqkPXqsrsx5KH+ENFAV1QVsdYZaRalgq0XlDfH/cpI3PVM
         n5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pFzp3t3ScLKQyR0iJgAovX+Jm5j9rNvFghhamcCOXDw=;
        b=GARxMUfX0J3sdle2R3kXcQ2ckUObD1FcRxuIYkFKZdjZyNKhLdwxoao+POOMrrBvzK
         0fOJ8CdvNnHATf+c/F7mK3V8uhhfSoc9VbiaaYAO83TuQ381lsbcvjha58Lf/DE58aBY
         Qgyk1hMYKyxn+pnhSsoAT+ZnSH/MbEXuziTwrQTx2tloDmCpsMN3xQlpX2aBUcE6CMm0
         3Pqu1I3FhZcz5QmAQxACZUjAVBJEI42ZS5T5dz0LiGyQgL92nUjUNSikqHjMBGDk5Jtu
         ByXdt6pKaJXO1111dKJhzm0hbcF8ffaFsXIlqTaP46e6AlSqAcPWZs+GgkO1LSlM1klW
         TUeA==
X-Gm-Message-State: ABuFfoiYAIWeMMFR/riKxNuDtmStpFMgC4tVCp0wziu8BzM415cRM6vE
        /u+P5TLLIzUov/I9PvzPytpO7oNx
X-Google-Smtp-Source: ACcGV63cRAStcq5vOQMASmyt50mMxT7v/KZlcKIXUqNHUI3Fa6L6jRqUCF0vK73SDPH5r5RuU0seyA==
X-Received: by 2002:a17:902:7e0f:: with SMTP id b15-v6mr2593552plm.246.1538586736709;
        Wed, 03 Oct 2018 10:12:16 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id y185-v6sm2669240pgd.8.2018.10.03.10.12.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 10:12:15 -0700 (PDT)
Date:   Wed, 03 Oct 2018 10:12:15 -0700 (PDT)
X-Google-Original-Date: Wed, 03 Oct 2018 17:12:10 GMT
Message-Id: <ba65680b3d0e50ad8be415e10c1e6b63c58d8b13.1538586732.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.42.v2.git.gitgitgadget@gmail.com>
References: <pull.42.git.gitgitgadget@gmail.com>
        <pull.42.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/3] commit-graph: clean up leaked memory during write
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The write_commit_graph() method in commit-graph.c leaks some lits
and strings during execution. In addition, a list of strings is
leaked in write_commit_graph_reachable(). Clean these up so our
memory checking is cleaner.

Further, if we use a list of pack-files to find the commits, we
can leak the packed_git structs after scanning them for commits.

Running the following commands demonstrates the leak before and
the fix after:

* valgrind --leak-check=full ./git commit-graph write --reachable
* valgrind --leak-check=full ./git commit-graph write --stdin-packs

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 2a24eb8b5a..ceca6026b0 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -693,11 +693,12 @@ static int add_ref_to_list(const char *refname,
 void write_commit_graph_reachable(const char *obj_dir, int append,
 				  int report_progress)
 {
-	struct string_list list;
+	struct string_list list = STRING_LIST_INIT_DUP;
 
-	string_list_init(&list, 1);
 	for_each_ref(add_ref_to_list, &list);
 	write_commit_graph(obj_dir, NULL, &list, append, report_progress);
+
+	string_list_clear(&list, 0);
 }
 
 void write_commit_graph(const char *obj_dir,
@@ -764,6 +765,7 @@ void write_commit_graph(const char *obj_dir,
 				die(_("error opening index for %s"), packname.buf);
 			for_each_object_in_pack(p, add_packed_commits, &oids, 0);
 			close_pack(p);
+			free(p);
 		}
 		stop_progress(&oids.progress);
 		strbuf_release(&packname);
@@ -846,9 +848,11 @@ void write_commit_graph(const char *obj_dir,
 	compute_generation_numbers(&commits, report_progress);
 
 	graph_name = get_commit_graph_filename(obj_dir);
-	if (safe_create_leading_directories(graph_name))
+	if (safe_create_leading_directories(graph_name)) {
+		UNLEAK(graph_name);
 		die_errno(_("unable to create leading directories of %s"),
 			  graph_name);
+	}
 
 	hold_lock_file_for_update(&lk, graph_name, LOCK_DIE_ON_ERROR);
 	f = hashfd(lk.tempfile->fd, lk.tempfile->filename.buf);
@@ -893,9 +897,9 @@ void write_commit_graph(const char *obj_dir,
 	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
 	commit_lock_file(&lk);
 
+	free(graph_name);
+	free(commits.list);
 	free(oids.list);
-	oids.alloc = 0;
-	oids.nr = 0;
 }
 
 #define VERIFY_COMMIT_GRAPH_ERROR_HASH 2
-- 
gitgitgadget

