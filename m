Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 494D41F453
	for <e@80x24.org>; Sat, 10 Nov 2018 05:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbeKJPbL (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Nov 2018 10:31:11 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43203 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728580AbeKJPbL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Nov 2018 10:31:11 -0500
Received: by mail-lj1-f195.google.com with SMTP id g26-v6so3358080lja.10
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 21:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hYW3y1PO9bwBHwuS+k14a0KhW20aEjE784WpvdNXVFQ=;
        b=TqyQMnyrQVubvR+CnZzlrWJeSTjQyLQW2BpLytsa7ai9AFaxCbows21hd63n2kU9HQ
         i4B3sen5OLLrDJbUZoxehkWov4GYswd6Lerg+pB+DppMMYLn8SY2mMlfkeAHT8KHKFaf
         a0jaWTUDo9CzbTGyj2xe2ydSifYvMkC/siJyXgJ59lM6ENPTeVovV72O8cikQA4avlnj
         6QCkzsvxnJ8LLL9SQkcJq/X2uJJ/7sXUeSWHtVVpxV/bwqc7CstYKCFJ9OgpUqYbqaep
         ihlaabocRMSV/Qbnsx8xzhfAPQC3dt2uyAoz+qFx9XtnlZE6AewlLmfLw3hDeCQ9RcsZ
         0OjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hYW3y1PO9bwBHwuS+k14a0KhW20aEjE784WpvdNXVFQ=;
        b=i7iKWMEZuxsOhoh9B2dCQmUQKbQEY7dvF6lWob3gWKAoxF0/0hBNoujjYA6oakglO/
         v8nur64qoRr2gq2nvqiYDHdJym3hD3zV3wea1PZTpkCblWIzl5EDp6lY3VvGnZL8m+V5
         0FSV2UN/Ew8jxPsWSaDC6GKZqLo/JEypav8S2DAVpFDQ61p9NvkdltzH+S8wWj18oYlM
         ePdWs7+nz8hZ/mjTVShFd3Q/P5Q3NrCViNZAaHSprnB0RyQlV4aBYA1n5IqGXazftOWs
         XpeiC7pPl1YHi98R6tJKRTmyQYZn5AbH6iSIOG/MLuaIbFDOllwy3jBAfp13OmtsuVHm
         3a+A==
X-Gm-Message-State: AGRZ1gIhUnhJ9NUkPJcUJjoPOq+3rOmREHmmZ0V/4hRBdd4JBgJvVClc
        ICklq+K7xvpo8GSMY5gHCN4=
X-Google-Smtp-Source: AJdET5cY4KMQ018hM2lop8MsL3OkADb2goXW9XfaxDA9pJe0Nhb9UKarTwBvEvnbzcgvMIao7TDF6g==
X-Received: by 2002:a2e:9e53:: with SMTP id g19-v6mr8009979ljk.39.1541826994512;
        Fri, 09 Nov 2018 21:16:34 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g66sm1769663lfe.42.2018.11.09.21.16.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 21:16:33 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, szeder.dev@gmail.com
Subject: [PATCH v3 11/16] repack: mark more strings for translation
Date:   Sat, 10 Nov 2018 06:16:10 +0100
Message-Id: <20181110051615.8641-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1231.g84aef82467
In-Reply-To: <20181110051615.8641-1-pclouds@gmail.com>
References: <20181105192059.20303-1-pclouds@gmail.com>
 <20181110051615.8641-1-pclouds@gmail.com>
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
index c6a7943d5c..721f947218 100644
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
2.19.1.1231.g84aef82467

