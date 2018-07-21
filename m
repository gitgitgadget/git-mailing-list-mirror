Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0E6F1F597
	for <e@80x24.org>; Sat, 21 Jul 2018 07:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbeGUIl7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 04:41:59 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:39424 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727483AbeGUIl7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 04:41:59 -0400
Received: by mail-lf1-f43.google.com with SMTP id a134-v6so3239886lfe.6
        for <git@vger.kernel.org>; Sat, 21 Jul 2018 00:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uZEOoQwmYt49HBmx2kz96deCilbvXo3jrYuV8AH1gUg=;
        b=qqJ3n2Ok3PW2Qpf8kqs0UhS817NwoeGCMw0UG7fDbqXlpCvGhOYpwoeqONbRYXlt82
         pISL3lNwJzGKx70EZMMqV3ejcHYz6a49KARv1fc2DTnelK77OEM2HP+V2InLll63tUMO
         4ESQUSm3Gzk5ZT5pg7q1SvLIoPgTuepZi/N5AdM0JKNYNzt/0kOyCJBoPUghp1aHVZI1
         4CwCgbPEyL4Kj1taxkiv6tQH01v1MWj1qJyJljod3RR5954lDmJzF8GX0aGEI4C/nMU1
         UT2gLdGa/Oh2nKYCvPEB8pacjIko6ZoIy0HHnvyZNCltIcurH2VrPmodKMQdpPCg/VBV
         7nAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uZEOoQwmYt49HBmx2kz96deCilbvXo3jrYuV8AH1gUg=;
        b=VxQ3mlKEVmEeHYiwrqxrPpcl4cPTV67RVtuE4Dz+HQXxcPP0gN1qPBpokXXvhwykOa
         iE1uQ+9DHJ9Di0kOWPPeMffPdfo6IUjU5MEl+j+eN68lwWE5ipoda/ZyOwVXWB9OmDpU
         HUf3zaaVLNkecxoM/fJWkOLkAtdvsIms5xZyK9zDySc3oEyqAanNsrULGG04QHRdseJ5
         yC1u2lHl3B1s8UgDbEGovQ4P083cpiRUgg/4kobURCmxMovKMXWWIXm0+Zi78l69OJSK
         f270CqHrCWzumA5phR/ThHdLa4AU07qmZYq+0c/O2TeaID5H6n2zgqOo8tU8TjkTlsQu
         dqHg==
X-Gm-Message-State: AOUpUlH4Q19s7AMS8ZPpuWMaoHwVXdzCYdQ7x/lhNDay5+c/Z8bdubim
        dAAq5zmlu0lIysic6p4T084=
X-Google-Smtp-Source: AAOMgpcC5eL9JzyXFgYwVYfunWdm87doDs3ZQyHYw8To7Tz2ajYoGXEdvyukCAVXa5wvrA2SXyMShQ==
X-Received: by 2002:a19:a04c:: with SMTP id j73-v6mr3180379lfe.123.1532159409520;
        Sat, 21 Jul 2018 00:50:09 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id n3-v6sm759898lji.96.2018.07.21.00.50.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 00:50:08 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        stolee@gmail.com
Subject: [PATCH v3 13/23] environment.c: mark more strings for translation
Date:   Sat, 21 Jul 2018 09:49:31 +0200
Message-Id: <20180721074941.14632-14-pclouds@gmail.com>
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
 environment.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/environment.c b/environment.c
index 2a6de2330b..d129c4adc5 100644
--- a/environment.c
+++ b/environment.c
@@ -147,7 +147,7 @@ static char *expand_namespace(const char *raw_namespace)
 			strbuf_addf(&buf, "refs/namespaces/%s", (*c)->buf);
 	strbuf_list_free(components);
 	if (check_refname_format(buf.buf, 0))
-		die("bad git namespace path \"%s\"", raw_namespace);
+		die(_("bad git namespace path \"%s\""), raw_namespace);
 	strbuf_addch(&buf, '/');
 	return strbuf_detach(&buf, NULL);
 }
@@ -329,7 +329,7 @@ char *get_graft_file(void)
 static void set_git_dir_1(const char *path)
 {
 	if (setenv(GIT_DIR_ENVIRONMENT, path, 1))
-		die("could not set GIT_DIR to '%s'", path);
+		die(_("could not set GIT_DIR to '%s'"), path);
 	setup_git_env(path);
 }
 
-- 
2.18.0.656.gda699b98b3

