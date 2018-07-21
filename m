Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A14C1F597
	for <e@80x24.org>; Sat, 21 Jul 2018 07:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbeGUIlz (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 04:41:55 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45294 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727483AbeGUIly (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 04:41:54 -0400
Received: by mail-lj1-f196.google.com with SMTP id q5-v6so12876317ljh.12
        for <git@vger.kernel.org>; Sat, 21 Jul 2018 00:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m6PLi7qLQePAEbAp+hk8BnQMLS/MMhh5us8u+yBMhNI=;
        b=dJR1/EMpGBOCYFpH4Z7N43bdAl6vfx+kJktKFVhSfQTYp6cbiirpOwG/WS7mkx/baZ
         mZnVBpwmVxMou1g/00R1y4+WXSJug8iu7dVKEPoDtHzzU91ALOPlTYlTzo4zx5BvlmtP
         Ha7lOKLvP8XbGTHiQs5s+F0h8d9l98P52CJZFif1t+6/vMJqw95ymgcCrZU+DxOIgk6W
         IxTPPceDx95W4aJR1+PuV+M/o+8PdOZRhRc1mrL/nfoI/mPdcOWQ5/VMV2L/mmEmK4ar
         NpS0vZe/7x4+OcgrSZTVoXKhxqcGK63xk3GaZLy64worEcchQbqaetVKiheWXd7rGVau
         ToVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m6PLi7qLQePAEbAp+hk8BnQMLS/MMhh5us8u+yBMhNI=;
        b=mK81PRPUr6u+HmCAxVNSe+9hmEnwUif8NWNmcnMHckOwQVV7xwduDf+lmVKrufxxRM
         29htfPoiXAZ6Q5CdebZjD97FQ0gOujryEicvy5jXl8yLF8yZ84SPzDkcRTGkYOo8qemk
         2rq00L26F3MDERTecVe0WHxsT9upGlhUTMwDJPxEjrlzsEsehnk7iKfgbPOdzfOg/0Y8
         PiHJNZjutzfwxelfpGDhCzXsFY2+iUHANVZI2ZrXtgB3+McBI1qwQ1OqH0Iv7D20G5Et
         lopJXmYnsGx/GBXtlFrYd7GxXC8kbFweH3chP8ZExvPQ8s3ctdSxQgfX6WNuKZnuRlqR
         lw9A==
X-Gm-Message-State: AOUpUlExyNIVOV7Ym7RJUIzHgVmT/njpgyP/+BPR4p8+v7iBMqmQn/S0
        K5fnFNRZ0S/vXZPVC7qQOlI=
X-Google-Smtp-Source: AAOMgpei12NTnN24w4YV4I1mzrXbwFiKEJTCIjlTwGHCqsQtIjNwgygduuFjbLiuWPRj5qsZH1GpvQ==
X-Received: by 2002:a2e:4d9d:: with SMTP id c29-v6mr3451382ljd.132.1532159404283;
        Sat, 21 Jul 2018 00:50:04 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id n3-v6sm759898lji.96.2018.07.21.00.50.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 00:50:03 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        stolee@gmail.com
Subject: [PATCH v3 08/23] commit-graph.c: mark more strings for translation
Date:   Sat, 21 Jul 2018 09:49:26 +0200
Message-Id: <20180721074941.14632-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.656.gda699b98b3
In-Reply-To: <20180721074941.14632-1-pclouds@gmail.com>
References: <20180718161101.19765-1-pclouds@gmail.com>
 <20180721074941.14632-1-pclouds@gmail.com>
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
index b63a1fc85e..c8d521923c 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -77,28 +77,28 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
 
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
@@ -122,7 +122,7 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
 		chunk_lookup += GRAPH_CHUNKLOOKUP_WIDTH;
 
 		if (chunk_offset > graph_size - GIT_MAX_RAWSZ) {
-			error("improper chunk offset %08x%08x", (uint32_t)(chunk_offset >> 32),
+			error(_("improper chunk offset %08x%08x"), (uint32_t)(chunk_offset >> 32),
 			      (uint32_t)chunk_offset);
 			goto cleanup_fail;
 		}
@@ -158,7 +158,7 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
 		}
 
 		if (chunk_repeated) {
-			error("chunk id %08x appears multiple times", chunk_id);
+			error(_("chunk id %08x appears multiple times"), chunk_id);
 			goto cleanup_fail;
 		}
 
@@ -244,7 +244,7 @@ static struct commit_list **insert_parent_or_die(struct commit_graph *g,
 	hashcpy(oid.hash, g->chunk_oid_lookup + g->hash_len * pos);
 	c = lookup_commit(&oid);
 	if (!c)
-		die("could not find commit %s", oid_to_hex(&oid));
+		die(_("could not find commit %s"), oid_to_hex(&oid));
 	c->graph_pos = pos;
 	return &commit_list_insert(c, pptr)->next;
 }
@@ -537,7 +537,7 @@ static int add_packed_commits(const struct object_id *oid,
 
 	oi.typep = &type;
 	if (packed_object_info(the_repository, pack, offset, &oi) < 0)
-		die("unable to get type of object %s", oid_to_hex(oid));
+		die(_("unable to get type of object %s"), oid_to_hex(oid));
 
 	if (type != OBJ_COMMIT)
 		return 0;
@@ -683,9 +683,9 @@ void write_commit_graph(const char *obj_dir,
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
2.18.0.656.gda699b98b3

