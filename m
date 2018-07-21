Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFD541F597
	for <e@80x24.org>; Sat, 21 Jul 2018 07:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbeGUIlt (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 04:41:49 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42329 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbeGUIls (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 04:41:48 -0400
Received: by mail-lj1-f193.google.com with SMTP id f1-v6so11240106ljc.9
        for <git@vger.kernel.org>; Sat, 21 Jul 2018 00:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4DPu2C1zDBoyL0mdnoTdZpF39JPJGkR97SAZK0gkArc=;
        b=VsjZiuMD6ytMjFN2pK5a5Oma27xdm4u6bSZUgBU+whfE17mu4BvNi58d1vPJCynjUI
         5SEKBfJmWi78/ZA/9J+YkgCJeDsNOk3XdTF7O3MXdbpxynx0EVWlfNcZ5KaM61nKp1LL
         fjRt46N+N+oBQEOIbJvjWHA+nWCqd7t84EiVrnVU9QdkcDkGwQCDNojtTc+dkDEcwqeM
         URxkYQ5Fo5eh9DT2ZTViaGP7QeBDiOolGalbKoOsbvYdL7xNWtL2AFmidhP7iTcOVzhT
         wg2tUU+DaGW5kiQDXdo/nBwAHhUDKnk+BZR6aVi/dkaJ2V/cjP8h8H36p8yn963GXoBc
         Hehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4DPu2C1zDBoyL0mdnoTdZpF39JPJGkR97SAZK0gkArc=;
        b=aO9LJeBpUOkmt5N5U8M9lj2VlkP3bFr0195KgVqrw4i7jtLnJZHDboGAcox3a/ftku
         JP4kfOrWAuN8yZedfl7J58CWxi16dEY6P7xogRj9t2/wQP8AZPjT6SolalrsJAAqOmxl
         hAUDcl3oPCGbxX8hsFzGQxgH+qhl61yRB1JssoI5KbevWA5ylFooGb4axLMtcWhd3dBi
         MQduPme17p9oHywzVI0yQET1Ezz92TS206ZpQv1JgfIsrwB8G3NnCA9i4i5MrDMgSvMH
         XCfui9OzBplAz7VHW3jQo8wn+ih+dMAbEKri/t7KaZdqaSZAZmm3fsUr/Kj1I0g3wf5p
         GnHA==
X-Gm-Message-State: AOUpUlEE95Lokc4JWRQKXu0C7ryTYRYxcIyfYlxd8hZ/KtLAWosgAom9
        f0xs9zGOLpZVVxisThAvoVkU12vO
X-Google-Smtp-Source: AAOMgpdcH7Qc+hinTYxURyj64YolYo8+PUgpAeOiG8qCQBePBJvk3FkU3ZlNehqug8VlzNn4R7MjCg==
X-Received: by 2002:a2e:88d0:: with SMTP id a16-v6mr3423673ljk.63.1532159398965;
        Sat, 21 Jul 2018 00:49:58 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id n3-v6sm759898lji.96.2018.07.21.00.49.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 00:49:58 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        stolee@gmail.com
Subject: [PATCH v3 03/23] archive-zip.c: mark more strings for translation
Date:   Sat, 21 Jul 2018 09:49:21 +0200
Message-Id: <20180721074941.14632-4-pclouds@gmail.com>
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
 archive-zip.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index 48d843489c..7ad46d8854 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -309,11 +309,11 @@ static int write_zip_entry(struct archiver_args *args,
 		if (is_utf8(path))
 			flags |= ZIP_UTF8;
 		else
-			warning("path is not valid UTF-8: %s", path);
+			warning(_("path is not valid UTF-8: %s"), path);
 	}
 
 	if (pathlen > 0xffff) {
-		return error("path too long (%d chars, SHA1: %s): %s",
+		return error(_("path too long (%d chars, SHA1: %s): %s"),
 				(int)pathlen, oid_to_hex(oid), path);
 	}
 
@@ -340,7 +340,7 @@ static int write_zip_entry(struct archiver_args *args,
 		    size > big_file_threshold) {
 			stream = open_istream(oid, &type, &size, NULL);
 			if (!stream)
-				return error("cannot stream blob %s",
+				return error(_("cannot stream blob %s"),
 					     oid_to_hex(oid));
 			flags |= ZIP_STREAM;
 			out = buffer = NULL;
@@ -348,7 +348,7 @@ static int write_zip_entry(struct archiver_args *args,
 			buffer = object_file_to_archive(args, path, oid, mode,
 							&type, &size);
 			if (!buffer)
-				return error("cannot read %s",
+				return error(_("cannot read %s"),
 					     oid_to_hex(oid));
 			crc = crc32(crc, buffer, size);
 			is_binary = entry_is_binary(path_without_prefix,
@@ -357,7 +357,7 @@ static int write_zip_entry(struct archiver_args *args,
 		}
 		compressed_size = (method == 0) ? size : 0;
 	} else {
-		return error("unsupported file mode: 0%o (SHA1: %s)", mode,
+		return error(_("unsupported file mode: 0%o (SHA1: %s)"), mode,
 				oid_to_hex(oid));
 	}
 
@@ -466,7 +466,7 @@ static int write_zip_entry(struct archiver_args *args,
 			zstream.avail_in = readlen;
 			result = git_deflate(&zstream, 0);
 			if (result != Z_OK)
-				die("deflate error (%d)", result);
+				die(_("deflate error (%d)"), result);
 			out_len = zstream.next_out - compressed;
 
 			if (out_len > 0) {
@@ -601,7 +601,7 @@ static void dos_time(timestamp_t *timestamp, int *dos_date, int *dos_time)
 	struct tm *t;
 
 	if (date_overflows(*timestamp))
-		die("timestamp too large for this system: %"PRItime,
+		die(_("timestamp too large for this system: %"PRItime),
 		    *timestamp);
 	time = (time_t)*timestamp;
 	t = localtime(&time);
-- 
2.18.0.656.gda699b98b3

