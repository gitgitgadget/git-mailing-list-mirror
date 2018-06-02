Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6344B1F42D
	for <e@80x24.org>; Sat,  2 Jun 2018 04:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751551AbeFBEdO (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 00:33:14 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:46233 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751103AbeFBEc7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 00:32:59 -0400
Received: by mail-lf0-f67.google.com with SMTP id j13-v6so13160556lfb.13
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 21:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pMNo7QJj4mxXP7dOXANJA57Rm9QT/prnEIaU3TExtxw=;
        b=szmUhHUEbH4bYVmX47+gs/zqADAwTZte1OXLN5YMFd87KPdYHM/qYe/iwjZEO3N7hH
         Alm1cwmHRJ9uORwbAWF0iFIYEijtteMIAiA402E3ZrEiofzavLWREi69t3AkdiXVaYqJ
         dKxh7kOHjVt4l45tjdWMFHpl3ALCwp59Fl6yx6HlylVQ7zFS57C9DqMvF0PwAR2hSAx/
         8KH63LU6r7/UwrZ7dMsTPTh1gDgN9sNWEEseaQspDhyRA3UooMOxTeRvUcejkbB17m2y
         Qp5EQRr8q42ZKKq3I+nn1jJRaUezNt8s+r0KAYphnltDkLAbTapZ/QJwJ1SpzPKZPeaG
         JFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pMNo7QJj4mxXP7dOXANJA57Rm9QT/prnEIaU3TExtxw=;
        b=hvn3dTQ6RFGQCma0SqaLRrWCiEV+M0RTExn2Z0XIs5K+zDYGZHO3sYKgrRezj25yRY
         Netzafa8wenLlY07FTfjZw3+JvhOCYZ1VH6u95S65GAUh7/LlWv2VXk0bUZV8onOhqTy
         ONyFEFUceY94i2aegiQZnSbBi7ZRKlxWCfeywDgXTfPIp/wiSeSX9X2BqsYyAHp7jy6s
         uf3h6fsIOFLpJNZ0cUM41chtZlVxx2MkRViuiJ2NvnNbzzCOuziYp5n9olhBL/1RVEQO
         4+UUWdkzvuAfCDrzSQtf5dsfdgmxs1OC0Bm9cXKXNxQyA+QFFZwWi7x9Cc03WHcgoaeJ
         PpPA==
X-Gm-Message-State: APt69E0dwSjvf/cljtk/1b0QNsvFZJjpVr3L4Yc8ZahOS+I0StHacdVz
        64VCD7fJDQByaFmsI1ILfjgVxw==
X-Google-Smtp-Source: ADUXVKKPWtflauaEdlL0hPzTOtHatJIVkwNl4iXFlAcjQhEtqA5wfImjuQjFjzK0s5fkIOXu7IjCiQ==
X-Received: by 2002:a2e:1d59:: with SMTP id d86-v6mr461777ljd.104.1527913976892;
        Fri, 01 Jun 2018 21:32:56 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o11-v6sm644776lji.0.2018.06.01.21.32.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Jun 2018 21:32:55 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 07/22] commit-graph.c: mark more strings for translation
Date:   Sat,  2 Jun 2018 06:32:26 +0200
Message-Id: <20180602043241.9941-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.309.g77c7720784
In-Reply-To: <20180602043241.9941-1-pclouds@gmail.com>
References: <20180602043241.9941-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 commit-graph.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 4c6127088f..5a300535b2 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -76,28 +76,28 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
 
 	if (graph_size < GRAPH_MIN_SIZE) {
 		close(fd);
-		die("graph file %s is too small", graph_file);
+		die(_("graph file %s is too small"), graph_file);
 	}
 	graph_map = xmmap(NULL, graph_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	data = (const unsigned char *)graph_map;
 
 	graph_signature = get_be32(data);
 	if (graph_signature != GRAPH_SIGNATURE) {
-		error("graph signature %X does not match signature %X",
+		error(_("graph signature %X does not match signature %X"),
 		      graph_signature, GRAPH_SIGNATURE);
 		goto cleanup_fail;
 	}
 
 	graph_version = *(unsigned char*)(data + 4);
 	if (graph_version != GRAPH_VERSION) {
-		error("graph version %X does not match version %X",
+		error(_("graph version %X does not match version %X"),
 		      graph_version, GRAPH_VERSION);
 		goto cleanup_fail;
 	}
 
 	hash_version = *(unsigned char*)(data + 5);
 	if (hash_version != GRAPH_OID_VERSION) {
-		error("hash version %X does not match version %X",
+		error(_("hash version %X does not match version %X"),
 		      hash_version, GRAPH_OID_VERSION);
 		goto cleanup_fail;
 	}
@@ -121,7 +121,7 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
 		chunk_lookup += GRAPH_CHUNKLOOKUP_WIDTH;
 
 		if (chunk_offset > graph_size - GIT_MAX_RAWSZ) {
-			error("improper chunk offset %08x%08x", (uint32_t)(chunk_offset >> 32),
+			error(_("improper chunk offset %08x%08x"), (uint32_t)(chunk_offset >> 32),
 			      (uint32_t)chunk_offset);
 			goto cleanup_fail;
 		}
@@ -157,7 +157,7 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
 		}
 
 		if (chunk_repeated) {
-			error("chunk id %08x appears multiple times", chunk_id);
+			error(_("chunk id %08x appears multiple times"), chunk_id);
 			goto cleanup_fail;
 		}
 
@@ -243,7 +243,7 @@ static struct commit_list **insert_parent_or_die(struct commit_graph *g,
 	hashcpy(oid.hash, g->chunk_oid_lookup + g->hash_len * pos);
 	c = lookup_commit(&oid);
 	if (!c)
-		die("could not find commit %s", oid_to_hex(&oid));
+		die(_("could not find commit %s"), oid_to_hex(&oid));
 	c->graph_pos = pos;
 	return &commit_list_insert(c, pptr)->next;
 }
@@ -516,7 +516,7 @@ static int add_packed_commits(const struct object_id *oid,
 
 	oi.typep = &type;
 	if (packed_object_info(the_repository, pack, offset, &oi) < 0)
-		die("unable to get type of object %s", oid_to_hex(oid));
+		die(_("unable to get type of object %s"), oid_to_hex(oid));
 
 	if (type != OBJ_COMMIT)
 		return 0;
@@ -624,9 +624,9 @@ void write_commit_graph(const char *obj_dir,
 			strbuf_addstr(&packname, pack_indexes[i]);
 			p = add_packed_git(packname.buf, packname.len, 1);
 			if (!p)
-				die("error adding pack %s", packname.buf);
+				die(_("error adding pack %s"), packname.buf);
 			if (open_pack_index(p))
-				die("error opening index for %s", packname.buf);
+				die(_("error opening index for %s"), packname.buf);
 			for_each_object_in_pack(p, add_packed_commits, &oids);
 			close_pack(p);
 		}
-- 
2.18.0.rc0.309.g77c7720784

