Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19DFE1F403
	for <e@80x24.org>; Sun,  3 Jun 2018 16:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751303AbeFCQew (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 12:34:52 -0400
Received: from mail-lf0-f46.google.com ([209.85.215.46]:34555 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbeFCQep (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 12:34:45 -0400
Received: by mail-lf0-f46.google.com with SMTP id o9-v6so21558778lfk.1
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 09:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XnuOqa9VfDtodrttorSpv9QRkyyjTm71R5Yc58SjEpM=;
        b=QwuqOWGanTNREtEr0yABZh578uzwWtqKP682fjmNKSu2VhOMebLVe6OiWop6Ftottc
         dxw3z6Rj8Tuhmvq+7t0g1ZhXaIODLp9mSR+xlbuCVwu7RpGliLwjGGee4Pw83yp7sF/9
         IKINwuDyTJ33TReuYy3z/xW2icK19Jj57tejFVFlK1/d106S4EipYLn+p9EJ4R/L3x/X
         RzaBt59O0CO52XXaDCnQFioaLLZcH8f1JGBYHFu+z60RfrwrI8QRXn1T3yNOHJ93l5kc
         DPBB6nUbpmk8WNDWYhcodLz6Dg6tBIb5/EDfmIDrC4NbLGpVoYXhUxsy/CsArriYilHE
         GeWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XnuOqa9VfDtodrttorSpv9QRkyyjTm71R5Yc58SjEpM=;
        b=qxAfA/hloddvEA71eo/ynZ0nqgTWdEbaE3gM06G4DiCp0KyrjXzud+fVjt7ZbX7emV
         jXOeUsWxSG9fN/1fAk8sOLNXGgesILjm9tFMVOsIZ9VVthDjADSgqev2HjUL00looVMf
         BkOiDctyYsAbWRqRXUt1VrNInoMgb30qumlv+88NW4Y/U284Q06Bnr6FfXcsX3yr2Wx+
         Z24yMKfV51PpXFb+X2Rr+YRfObWvFIVzc4T1Nx2hXUTxIaK1Hj9VSVe4jL0A+X9pxQ9I
         dxjpjqG3nc4biYTARTbR9DOntFT5JM8AuF+WRLRT3umTONAkJn8YIJ/YnLQwExKSTZOm
         7fqA==
X-Gm-Message-State: APt69E17GzCIgMGLaitMY7OCrX9F9bBwB0iWXAHoS37dnv4g3wb0Fv9p
        ZA+0JO8K/bePu6lftCBaPIs=
X-Google-Smtp-Source: ADUXVKIS7M/H6Ty/LJsiqz0QOO1KEkpX4wvpK+S9ohCPIt3KulUlo7J17jHgSP2gzJ1CwW4zyQqfzA==
X-Received: by 2002:a2e:8605:: with SMTP id a5-v6mr1577284lji.43.1528043683995;
        Sun, 03 Jun 2018 09:34:43 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id v79-v6sm4726895lfd.32.2018.06.03.09.34.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Jun 2018 09:34:43 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 02/23] archive-tar.c: mark more strings for translation
Date:   Sun,  3 Jun 2018 18:33:59 +0200
Message-Id: <20180603163420.13702-3-pclouds@gmail.com>
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
 archive-tar.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index b6f58ddf38..68e72d9176 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -121,7 +121,7 @@ static int stream_blocked(const struct object_id *oid)
 
 	st = open_istream(oid, &type, &sz, NULL);
 	if (!st)
-		return error("cannot stream blob %s", oid_to_hex(oid));
+		return error(_("cannot stream blob %s"), oid_to_hex(oid));
 	for (;;) {
 		readlen = read_istream(st, buf, sizeof(buf));
 		if (readlen <= 0)
@@ -256,7 +256,7 @@ static int write_tar_entry(struct archiver_args *args,
 		*header.typeflag = TYPEFLAG_REG;
 		mode = (mode | ((mode & 0100) ? 0777 : 0666)) & ~tar_umask;
 	} else {
-		return error("unsupported file mode: 0%o (SHA1: %s)",
+		return error(_("unsupported file mode: 0%o (SHA1: %s)"),
 			     mode, oid_to_hex(oid));
 	}
 	if (pathlen > sizeof(header.name)) {
@@ -283,7 +283,7 @@ static int write_tar_entry(struct archiver_args *args,
 		enum object_type type;
 		buffer = object_file_to_archive(args, path, oid, old_mode, &type, &size);
 		if (!buffer)
-			return error("cannot read %s", oid_to_hex(oid));
+			return error(_("cannot read %s"), oid_to_hex(oid));
 	} else {
 		buffer = NULL;
 		size = 0;
@@ -454,17 +454,17 @@ static int write_tar_filter_archive(const struct archiver *ar,
 	filter.in = -1;
 
 	if (start_command(&filter) < 0)
-		die_errno("unable to start '%s' filter", argv[0]);
+		die_errno(_("unable to start '%s' filter"), argv[0]);
 	close(1);
 	if (dup2(filter.in, 1) < 0)
-		die_errno("unable to redirect descriptor");
+		die_errno(_("unable to redirect descriptor"));
 	close(filter.in);
 
 	r = write_tar_archive(ar, args);
 
 	close(1);
 	if (finish_command(&filter) != 0)
-		die("'%s' filter reported error", argv[0]);
+		die(_("'%s' filter reported error"), argv[0]);
 
 	strbuf_release(&cmd);
 	return r;
-- 
2.18.0.rc0.333.g22e6ee6cdf

