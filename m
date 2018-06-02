Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66DC21F42D
	for <e@80x24.org>; Sat,  2 Jun 2018 04:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751451AbeFBEc5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 00:32:57 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33362 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751103AbeFBEcx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 00:32:53 -0400
Received: by mail-lf0-f68.google.com with SMTP id y20-v6so17611809lfy.0
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 21:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O2JI0rQ/gfm5sQ0GVbt4O+257qvJW5Vj0O2u3ajsRfE=;
        b=q1kmdTgHDelOkF2puDVx8Q3oKvnBKLa4Mur9yKVdP2NWTRG62BU+MqQEOtJDMMQz3T
         pxQYGd7BUamMq9uhr6dre3LvNFehxjmfeW5/iDbM5cBQr3fu8g9Vevypehy6NuGsjC6N
         ho5F2LWWX5yp/j+RJPn+2iPxhvZCU/RlnfBAnK0M/4s2m1X3Xi0+9RujhWXn6pvjHdjZ
         +CFeH+2UgYSwMNGLpdSW1/zm5UAjFAjhguRdWj13u/Mw8q90aSE8nqYgoRELLgQLsIyx
         xxm2YT5iIAO8uhq0NBfHdjL0Kc6OkHpTLLPFBVKbMe2NkqqpcSdUBLW3Yfs5GmZsDeMN
         os8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O2JI0rQ/gfm5sQ0GVbt4O+257qvJW5Vj0O2u3ajsRfE=;
        b=CvAszcUB/1N+tqAYd0j/1yk6+2DmLmDIlI3nazwFsmfGCjEnnmDIkdGW8VPSBmF7T6
         jT/e1YRFintDR6968gDpntUF9jSSN+0aY9aO+3oNH6acwnok1lps6o/NNKe1ZtSukZmI
         oFDG+h41ImWe8yp1qZxciCoaxoMrV67C+mINysvS95Bzg6FvpiV5F43B0NvX/CpBW+D5
         GpRYTO4O7m3ICnbObK/tap+weHgqZEB0qQLQWN+Xcw1FunV3YzMCoc+UkhS8uAfCZ5/7
         /on6vQwk8d6fvOiJGUWQvJ8nCGaVcDdW/lWiULeQEBId+NRXT7MXrJRQlpInJGE3lcfW
         dQPQ==
X-Gm-Message-State: ALKqPwdujUnMZFpzGSUp5rfqWzbki9Uxx+G5TOx2YC/+dtaNclyzWFv2
        hK3XrMhCVrLRWhbWHFEsQN0g3A==
X-Google-Smtp-Source: ADUXVKKthkGvCWLr2rq7pdLpdi1uMYMgArmPx9JlCtnpcc3/3+QLeUBLwNBVB/dcT+kVWFXGOtmgOg==
X-Received: by 2002:a19:ddc4:: with SMTP id w65-v6mr8574644lfi.85.1527913970371;
        Fri, 01 Jun 2018 21:32:50 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o11-v6sm644776lji.0.2018.06.01.21.32.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Jun 2018 21:32:49 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 02/22] archive-zip.c: mark more strings for translation
Date:   Sat,  2 Jun 2018 06:32:21 +0200
Message-Id: <20180602043241.9941-3-pclouds@gmail.com>
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

One 'P' is lower cased because we normally start an error message with
lowercase.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 archive-zip.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index 74f3fe9103..7ad46d8854 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -309,11 +309,11 @@ static int write_zip_entry(struct archiver_args *args,
 		if (is_utf8(path))
 			flags |= ZIP_UTF8;
 		else
-			warning("Path is not valid UTF-8: %s", path);
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
2.18.0.rc0.309.g77c7720784

