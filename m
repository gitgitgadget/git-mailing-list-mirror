Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E485B1F453
	for <e@80x24.org>; Sun, 28 Oct 2018 06:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbeJ1Pf4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Oct 2018 11:35:56 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36492 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbeJ1Pf4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Oct 2018 11:35:56 -0400
Received: by mail-lf1-f65.google.com with SMTP id h192so3748226lfg.3
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 23:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DiUkPgJkFW162qMzjcoH+DG1Fjj6dK6Xd3a/lHF4m1E=;
        b=ZyjxP6WpDMZD5ZjV5VrPsbcBqd3wYP4iTo8ccRSmb4O3LyWmFNs5hEud6MPK8CldbF
         TlOliRRNfhQbLklISu5k6qESktsGjYXflR76DCGyHKldg4LHGYV5janWs75jLaYbOM/B
         kPpsHYQTHRumT6HPZWuXOuude5QRnaU5M6htQXgpGcfQuYXgvnuneQ31ZN87bbdOlnvF
         5pohXwCHx1MPHr4a2hnAb3NKR3vkSKFr1FhLT7AMu3tIwunAlyHwvh0PyNRkeN6ep0DK
         DPT9BeMl8l9Dr1qz/mgfCYcReOx1A+DDWiMcmsSOVMKg+pTRy5tBLirStuV2X/G9yx+h
         ErxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DiUkPgJkFW162qMzjcoH+DG1Fjj6dK6Xd3a/lHF4m1E=;
        b=Ll+u62L/CP6gV9zmCbF7Uyspmcb29P95STvqkVaJe018rF9OXMmJhg7kF5tHMuuwga
         mSDqaY2Qvgqigay6eYd5xP3qEcRRHpzbrMyP+XV3SGWGaf62JaLh4YwhfEWKeAim3xys
         Q2QFyMq2tX2pQujtT+thLNHn9nKZUGWiz3XDediOqLvGfeukxAoiFVAh5o+0Q+IZD6L8
         veskN5z/wxmrXGXrzNtG9WXmseYGO0RSatahBps9Xp6KPBVZ3zhWXtJ0kSR9zJ10swBB
         uYpP97Oje3kyCJg3Tkc43ZsB2h9dEn6FxZv+MBPJyB4zW5fk/EzxUUugm5TnYK3z1ev6
         LEpw==
X-Gm-Message-State: AGRZ1gKjrqqGahtL15SZ11Cckz0cA5cBa3medPS+SAdiQj+LfLozSf2q
        z2krg8pFIursOHdqbg37/5vcvbjt
X-Google-Smtp-Source: AJdET5eGTjS7rwXhP+exk+de5ViYWgkIJ+vZ7BbCF93NGGHoT+YnKIAilR2869MODxIOZWs8S858hQ==
X-Received: by 2002:ac2:4257:: with SMTP id m23-v6mr5572064lfl.6.1540709531951;
        Sat, 27 Oct 2018 23:52:11 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id v23-v6sm148847ljd.70.2018.10.27.23.52.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 23:52:11 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 09/12] repack: mark more strings for translation
Date:   Sun, 28 Oct 2018 07:51:54 +0100
Message-Id: <20181028065157.26727-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181028065157.26727-1-pclouds@gmail.com>
References: <20181028065157.26727-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
+			die_errno(("unable to create '%s'"), promisor_name);
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
2.19.1.647.g708186aaf9

