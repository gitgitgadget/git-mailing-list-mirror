Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 935FC1F42D
	for <e@80x24.org>; Sat,  2 Jun 2018 04:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751431AbeFBEcz (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 00:32:55 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:45588 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750821AbeFBEcw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 00:32:52 -0400
Received: by mail-lf0-f68.google.com with SMTP id n3-v6so17613723lfe.12
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 21:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v1c4Cn84dlYXLOnwEtXQ10FiP5hLdULLBLVeheeceCY=;
        b=kbsoU3bfRaSW3vZwp8pl7RNtEjk26ZhrQPxr6y3HhpHcanvdOv3PMTY2pcIl6J2tTN
         VDeviwL/CFF//DAVJt39i9EBSstBu4uC4w3+wiIINYzSeJp5QIweO/x0Cqo1ySuaklRP
         AJFGmlipU/9kfXGzDl/a/7Fuk7VDTUww7/+z9q0sHgU4trmjiMIgJuQh2qmE458PRmP5
         caDsvzRhJiPu1dIwDsJP//qeSWmE0A5gmFawCKkkc5byrqel1vy5uJfALZcEZj3s9qWq
         b0n9N0uRhmiHrcWKrUDvvQmayxSJbURNrGXmODxtg8YskuZZRRVHIxamhqGyv9Y8gdMN
         zLYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v1c4Cn84dlYXLOnwEtXQ10FiP5hLdULLBLVeheeceCY=;
        b=T3MKIwfL2g4ziq0WuclIhWpp1isQaV5dClNHHbYn2Tx9KMcHvGflvoYz+SNEuI+/kI
         Db4eCWDK7auJaMeJq8qmdZwzA14ZoA/etszr5DCFAFFXcX0v0CT5D6ZJ9NnZCsSon+r2
         ruXR4kWx038xURmk1ygv2d4pNDs8pdd1Iol7GP76VYaXQAw9NbswthIktoXJmfJw/lvu
         nzscIPXFtxm1P8UsiqfYLQzpxdoE1p3K/+/EsIQjRUUSPTpLG2gdp4l1+VEYKNsruWw1
         bISZyS4iFtsMUtOmrydAebh5eBA05rNl6156UdtMK6ZK7+n20geRmINz5i1h5MXuFzwX
         3STQ==
X-Gm-Message-State: ALKqPwfhmC4M+jAYmtaOoBd8yQo0CJMco4w6NGGwIDrSO8n6SBN96Qam
        z3nhxU2aI3c5wL7STKQjbpok+A==
X-Google-Smtp-Source: ADUXVKK6TA1Uwo+ii4JMIJzohQ3dpDN/wi4QMQs0Q72oST7XLQMaXXXtU23N/vy73+ckTvKUKuz9UA==
X-Received: by 2002:a19:f03:: with SMTP id e3-v6mr8522030lfi.145.1527913969335;
        Fri, 01 Jun 2018 21:32:49 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o11-v6sm644776lji.0.2018.06.01.21.32.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Jun 2018 21:32:48 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 01/22] archive-tar.c: mark more strings for translation
Date:   Sat,  2 Jun 2018 06:32:20 +0200
Message-Id: <20180602043241.9941-2-pclouds@gmail.com>
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
2.18.0.rc0.309.g77c7720784

