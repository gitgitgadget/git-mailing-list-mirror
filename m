Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 904091F453
	for <e@80x24.org>; Mon,  5 Nov 2018 19:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388037AbeKFEmb (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 23:42:31 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40962 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387990AbeKFEmb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 23:42:31 -0500
Received: by mail-lj1-f194.google.com with SMTP id z80-v6so9123659ljb.8
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 11:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QlZM0hK7FziQTrnRvmWcSgkF7G4bKgeqc5djkZBi2IQ=;
        b=PhckTKPHatMMUWIAND5TvgdwShepYMSOCutUOCwRi1OoNGe8hwmvzl9Al8UV1G8E75
         f58gEeZXA/gJgb4o2H3WImS4x7OCGebQB1Ws+VWYAoWAQp4Pyxa9bDdX48CMpdziC22g
         gu8ytMzfS/TTLVbpJ8mzQks+bQ1q8jD/2PbUvJjS+Ia1jFDfBDm10Dz6Vj5N1BdWegZA
         G8Lm/4fv4ooHMoF0QEEPLyUNBtgOBM8rS+e0hq7N084b6d7eKlKh10pCQtD96Me/f+er
         Nd5XXqHqNFQ0hX0hd5ta1L0DKswUg52g1YmQX1dRzdSlKTOKjbZ2bLNhWqCzJGzUrqwb
         J+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QlZM0hK7FziQTrnRvmWcSgkF7G4bKgeqc5djkZBi2IQ=;
        b=D+3PooMFv7oKblsNLLtjAeVeT3x+w/IyifnOSTEkt7oL8Uj3RwN1L0/B+S7IT7wTwK
         xGVRa3dcczHjw0SAeiKNY6NQIHtRJHmu5YT54AAGBbyWb5r11cbi7VulChOKwqcJtfzk
         cZyDwcf+8f+Vq4EjGZu3TTjYt+HdxpY9vcDQ1w5F8kEjiupIF4dHvvQNjZffbEV8N9UD
         Pm9LImA6R/yY97yNSwZz2M94jhvl+NipMbqtWQBQ4/xGuGkMgSIqQALAMUke50AJmYab
         7e7CGlcm7IfG7gYM5AJ2tjG4KrTFFPxX5tRmv32yuPcICf0EhyeEdS+4rLa3dJAmcoXM
         VCSw==
X-Gm-Message-State: AGRZ1gIpafXNnC+hX63FbS4NxUfsWYDLWymZmTmVW0H9XyR/K8Cozy8f
        gyssrew2rdIxG2JwQaGPQbqX9qon
X-Google-Smtp-Source: AJdET5fgdFpnRVL8vGgxSc3JsVzh3p7MHXI19p6WAjEWJ+x0TOaeNNHbu1U/G4cGbB5rCcYgQLnsxA==
X-Received: by 2002:a2e:710a:: with SMTP id m10-v6mr11379555ljc.66.1541445680567;
        Mon, 05 Nov 2018 11:21:20 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id x5-v6sm3591056lfe.58.2018.11.05.11.21.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 11:21:19 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 11/16] repack: mark more strings for translation
Date:   Mon,  5 Nov 2018 20:20:54 +0100
Message-Id: <20181105192059.20303-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1005.gac84295441
In-Reply-To: <20181105192059.20303-1-pclouds@gmail.com>
References: <20181028065157.26727-1-pclouds@gmail.com>
 <20181105192059.20303-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Two strings are slightly updated to be consistent with the rest: die()
starts with lowercase.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/repack.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index c6a7943d5c..0af20fa0fc 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -197,7 +197,7 @@ static int write_oid(const struct object_id *oid, struct packed_git *pack,
 
 	if (cmd->in == -1) {
 		if (start_command(cmd))
-			die("Could not start pack-objects to repack promisor objects");
+			die(_("could not start pack-objects to repack promisor objects"));
 	}
 
 	xwrite(cmd->in, oid_to_hex(oid), GIT_SHA1_HEXSZ);
@@ -236,7 +236,7 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
 		char *promisor_name;
 		int fd;
 		if (line.len != 40)
-			die("repack: Expecting 40 character sha1 lines only from pack-objects.");
+			die(_("repack: Expecting 40 character sha1 lines only from pack-objects."));
 		string_list_append(names, line.buf);
 
 		/*
@@ -247,13 +247,13 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
 					  line.buf);
 		fd = open(promisor_name, O_CREAT|O_EXCL|O_WRONLY, 0600);
 		if (fd < 0)
-			die_errno("unable to create '%s'", promisor_name);
+			die_errno(_("unable to create '%s'"), promisor_name);
 		close(fd);
 		free(promisor_name);
 	}
 	fclose(out);
 	if (finish_command(&cmd))
-		die("Could not finish pack-objects to repack promisor objects");
+		die(_("could not finish pack-objects to repack promisor objects"));
 }
 
 #define ALL_INTO_ONE 1
@@ -408,7 +408,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	out = xfdopen(cmd.out, "r");
 	while (strbuf_getline_lf(&line, out) != EOF) {
 		if (line.len != 40)
-			die("repack: Expecting 40 character sha1 lines only from pack-objects.");
+			die(_("repack: Expecting 40 character sha1 lines only from pack-objects"));
 		string_list_append(&names, line.buf);
 	}
 	fclose(out);
@@ -417,7 +417,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		return ret;
 
 	if (!names.nr && !po_args.quiet)
-		printf("Nothing new to pack.\n");
+		printf_ln(_("Nothing new to pack."));
 
 	/*
 	 * Ok we have prepared all new packfiles.
@@ -477,13 +477,13 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		if (rollback_failure.nr) {
 			int i;
 			fprintf(stderr,
-				"WARNING: Some packs in use have been renamed by\n"
-				"WARNING: prefixing old- to their name, in order to\n"
-				"WARNING: replace them with the new version of the\n"
-				"WARNING: file.  But the operation failed, and the\n"
-				"WARNING: attempt to rename them back to their\n"
-				"WARNING: original names also failed.\n"
-				"WARNING: Please rename them in %s manually:\n", packdir);
+				_("WARNING: Some packs in use have been renamed by\n"
+				  "WARNING: prefixing old- to their name, in order to\n"
+				  "WARNING: replace them with the new version of the\n"
+				  "WARNING: file.  But the operation failed, and the\n"
+				  "WARNING: attempt to rename them back to their\n"
+				  "WARNING: original names also failed.\n"
+				  "WARNING: Please rename them in %s manually:\n"), packdir);
 			for (i = 0; i < rollback_failure.nr; i++)
 				fprintf(stderr, "WARNING:   old-%s -> %s\n",
 					rollback_failure.items[i].string,
-- 
2.19.1.1005.gac84295441

