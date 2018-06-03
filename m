Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98D1A1F403
	for <e@80x24.org>; Sun,  3 Jun 2018 16:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751309AbeFCQey (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 12:34:54 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:45344 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750996AbeFCQeq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 12:34:46 -0400
Received: by mail-lf0-f67.google.com with SMTP id n3-v6so21570862lfe.12
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 09:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wDuw794kHdTMr9mdM2hpWMq8lA52sz/Svc2hunjp/6U=;
        b=Ox6wDuUP2K+ezU5R5TDlwBMAB4HVf2kIHTtVUnDQKt8rvlignPYoY8lOL2F4+nGoJT
         pptWYkfe6EBVShdm2/xUqbUFkG3uqWEbPtmto9pdvFnZaeds7Xk0TkgyH9OlI7TjcAyM
         CqY7M5fYsF74hGb3msD/QSP+ANutyPF+wKJUYR7dBcJs0VwNoVqTYNH44g5zibj1Kg4y
         XRgIxOE/n4gNBe67S9lKgJuASoQowC8yal91nGq3TeBnTXVqXBBgXeD2k0i0g7G/7f1s
         vV+ADdXlo4UMSV8oOtllOo159gYZI8HjSOfnhNP65nsvkN9zQ8dEyJJtgJFd7fkAx8om
         uDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wDuw794kHdTMr9mdM2hpWMq8lA52sz/Svc2hunjp/6U=;
        b=I4J47vPVxohbCCfjqqzEZY9mq+SjMW7OuNBOAgDyWIEQWhiUujE5N90yJpyfe+Z4F9
         x11R0jw5rpraxhPXK+iJXsnYGWr69uR28MCo+5tOg37JL0GSDiPhY1QWdkyR5Cc38Y5y
         csQ9S2nKGZ4+t60Ogji2zL9EMUwgJg/3oa1pqgMhWuWoyHBRIUt0JHR6h91R+ei2EPUS
         C/y2D8wb5cEJudFJMQey8sURBkqDcXuVlikqdq4X0chJ8QyzzaF7t/2628HuyJsaKkn9
         0wGzNi2/tlMfIKll8GyYRwDzhq+bEjnTcEQNZaq6AceMFtl93/Y/GMz8wxqjpSiksdfb
         /xQg==
X-Gm-Message-State: ALKqPwfT7AYLP+gUJTlaFadKHFxdB/P3g3zh4VOaJgSwVj+HsbnEUS8N
        01WAaJWrPKUlC/0558qcRi/bGQ==
X-Google-Smtp-Source: ADUXVKI3yzCCuxy9F2tYERlKbuytWTXkVVj9zWye+Gs5u7Bboi6eDz415TA+HM8K/H4DMqe77nuXQA==
X-Received: by 2002:a2e:9187:: with SMTP id f7-v6mr9901386ljg.98.1528043685030;
        Sun, 03 Jun 2018 09:34:45 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id v79-v6sm4726895lfd.32.2018.06.03.09.34.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Jun 2018 09:34:44 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 03/23] archive-zip.c: mark more strings for translation
Date:   Sun,  3 Jun 2018 18:34:00 +0200
Message-Id: <20180603163420.13702-4-pclouds@gmail.com>
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
2.18.0.rc0.333.g22e6ee6cdf

