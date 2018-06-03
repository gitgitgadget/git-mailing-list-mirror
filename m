Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 070081F403
	for <e@80x24.org>; Sun,  3 Jun 2018 16:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751477AbeFCQft (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 12:35:49 -0400
Received: from mail-lf0-f53.google.com ([209.85.215.53]:34570 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751057AbeFCQev (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 12:34:51 -0400
Received: by mail-lf0-f53.google.com with SMTP id o9-v6so21559027lfk.1
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 09:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hlMfvvKdDJPUYi6MdoUMy2oTk+rfIebDwc5HHHAnbto=;
        b=a1pC5PdiSp8RL90QX4x+VXt5sCeWw3qhkLtLXN1+ROY/q77ufXxAjFxUdT/NfnvrXO
         pzLtql4iQeRmgZTzl/4F1uXQzF49mUWNw9C3iMsF717Nmr2HFYAk85Phm7F4Za8AKjDP
         738qW1FwsXhO30zSYkzEeEe3TCOjcBFsgwSLwDuCv2eX4eEwPLQYmmEDeZlj7XDEngby
         Es4hbh4OcYvlIWVeg4ypvUKhAKpxkqV36w9vb40xwZT7pRIht9su2a3/xcBtPN53a0cm
         4FLAdiQbjL6fbKE1dFIjQv17w5Y3iV2Jf6b1FOIC7BYORoVvIVHIcgqtRGqxDJJreiHg
         zx3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hlMfvvKdDJPUYi6MdoUMy2oTk+rfIebDwc5HHHAnbto=;
        b=i9RbDMffT+YhNAXnjvfdaUZiEhexYUpgW68HfG8QROpqnmRRasCZcuAB73LNi92Jcl
         Y5qpIV4VGlCX35lZ23eYu7nEi3y9FtbaeRGbSvFNInjsES3Iww/zCQnTa260vz8ee8iG
         fFgENMFDYjOV2gxKAScrE5JNvQm2F8pPVOBimD7d1rY/ZR06H7VAXF3hFlSJrg7v0rAe
         A5fQuRpptGvShcY5Vg4/dGQMVmeiYqOCLyV9l8Z0HJ0VBTMXR3sAg0S291QI5IlVTDCo
         MpRp3uV3kEk62CxPsrQGYJwdbwIkw4ppIA3gmu/wNfdzrnXyDLOIjk/76zUNvOotSR5F
         jU+A==
X-Gm-Message-State: ALKqPwdnmtZ96N9Rd7V+TDlayc4tbvTMuV4YkaeKEwLWB+mnDRabrED8
        M63TK/gpKLCHX2XgNxpY3M4=
X-Google-Smtp-Source: ADUXVKJld8pUMAUANMRx34ik0UlE6WIPB8VYrlG16DMD8UOSgy+g6Nl91H8C20kbj1ov18Jv3iisAg==
X-Received: by 2002:a2e:8246:: with SMTP id j6-v6mr12954543ljh.72.1528043690404;
        Sun, 03 Jun 2018 09:34:50 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id v79-v6sm4726895lfd.32.2018.06.03.09.34.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Jun 2018 09:34:49 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 08/23] commit-graph.c: mark more strings for translation
Date:   Sun,  3 Jun 2018 18:34:05 +0200
Message-Id: <20180603163420.13702-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180603163420.13702-1-pclouds@gmail.com>
References: <20180602043241.9941-1-pclouds@gmail.com>
 <20180603163420.13702-1-pclouds@gmail.com>
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
2.18.0.rc0.333.g22e6ee6cdf

