Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AED11F597
	for <e@80x24.org>; Sat, 21 Jul 2018 07:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbeGUIlt (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 04:41:49 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:42275 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727274AbeGUIls (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 04:41:48 -0400
Received: by mail-lj1-f172.google.com with SMTP id f1-v6so11240088ljc.9
        for <git@vger.kernel.org>; Sat, 21 Jul 2018 00:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bIvSFUhwCEhj+WA9EDY7iznboXsaKTrC3ZD8AzySxww=;
        b=eqpUajuukZvFvmuABM9IJXhWyrC4QLIF6FWTDPohl8iW9UwWaWDizb4O+K1tY+rfp9
         ywNt5TWc8grcWlDFpdofQSsi/s841so35maxTdR9/O+ZspJA0Z9FbJhvDe5cOhCaqyQU
         0lRAE+CXZtSmNyOhVNcUtc/koYOMZYid34lRKw3wh9xRiDBoYcX2kAi5ABYRdkOKLGLl
         mu5n3F3id3SObp2GswPWGWAGEWNC71ABBRnZh0/d3sjz3SLQmsfIB1PUeGnc7BYuFTX3
         ex1Ht/8xOy3iqV55hXbRGboqwkCY9/L5uC6/ySPWgR0N/GjX5AU/PB83s4gkqpJiKRZ0
         HlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bIvSFUhwCEhj+WA9EDY7iznboXsaKTrC3ZD8AzySxww=;
        b=pzIirh16lHd5gIdJw+ahAW/FbWaRijJySH+lTpKPLq0wF/YiTIKbR8b8lVv+nVhYTr
         lj2F6cxvFQPMUjB6UD+NtewlUgWRTH1gr2O52bUgI4XwA24AL8uMRA0v94Sd8S5/sJwe
         GGuBhsOKq8vu/Radst0vExgQ1NKRbSrjLhIj7+dPscrIFzk5Zlz2zw9C22zYtGQ1M5Zq
         5x2my0PpRAFM2VIe847d2jMoqL9nbHW0HDpYn44WEK4PUMGL3wy4sdVkZN1vvDBOPhvd
         5Nk9zRM8M85+bdEX9eqg27qTmr2zMOyYaUX5hG23IIjHkE5Pkh1MQ9fjXTUrnaGRcVT6
         s3uQ==
X-Gm-Message-State: AOUpUlHYBzo67FFhCPckjsg1ry0u6TlZIrJzMDv/RnS+LpY5JEHarTgw
        tHMIdjsNdHeE4+sej5DTglu8NsUv
X-Google-Smtp-Source: AAOMgpdKSeUFjFz3R28+vntdcOAh+E8Vzc2FjO7z0BzLEoGAfKcSBchPX20PMouNbM5ep06RFCGulA==
X-Received: by 2002:a2e:89c5:: with SMTP id c5-v6mr3851609ljk.19.1532159397882;
        Sat, 21 Jul 2018 00:49:57 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id n3-v6sm759898lji.96.2018.07.21.00.49.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 00:49:57 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        stolee@gmail.com
Subject: [PATCH v3 02/23] archive-tar.c: mark more strings for translation
Date:   Sat, 21 Jul 2018 09:49:20 +0200
Message-Id: <20180721074941.14632-3-pclouds@gmail.com>
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
2.18.0.656.gda699b98b3

