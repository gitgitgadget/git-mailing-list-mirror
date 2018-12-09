Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SUBJ_ALL_CAPS shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BA4820A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 10:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbeLIKpd (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 05:45:33 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42154 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbeLIKp2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 05:45:28 -0500
Received: by mail-lf1-f65.google.com with SMTP id l10so5951400lfh.9
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 02:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=andBgDMggrgXPXCXjU4PgkxXM9Zc+927DDw4jAVj+eY=;
        b=qVD26vjK6X4lDMZ2jQ6gg+O8Zx+QsjdUs/meK1kKMpF+8APe4o7n6sci2+9uxg/SzR
         /2VZj3KlQVO4Tm8sqqeZ8sO3/WpgchCQbZ3aUme9j02e8nnUGEhyDsbI706qmXi9/kwX
         AIWsoAVyDhf/248yEJwcC4q88qaorgVhMwV+1tpyJ7z90xlHFicxn9yMhxEb0hJKNk6f
         OYocyZGs+jkEyeOCg2ZURZkPYmLZlJKVOnFwC1P0n9aRpvup0jPldAkT4T2HrQyof8yL
         IIr2QI0GjN4Na2wsGn6Uo5smq1TBvyfT/gc5vRpu83ZDQa0mcQ3HpWfK/dzC2nj1gSdJ
         SIRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=andBgDMggrgXPXCXjU4PgkxXM9Zc+927DDw4jAVj+eY=;
        b=YzueZTWWTpXjZz9guMhWjlPEKPdS2Ea5+lslN3Os3fb7hfT+/OGXPZpAUj0TH0YfHA
         cyxVjs/xLIvhcj3ueeveOE+mQlLKGtGdxH2rA8UT0Sz7lHACUebAu4r5UnHDt+KvmaLY
         TPxxyCfIse8+KAYSIejCMhwJh4/dL2qVYlbyBaGT+Nj+s6yNjQbcXB75Gr0Odm4EKwIk
         F42gS3e1ZAJINPoGE93QSPee3RYblAoqdDCxQcnC0yRDMJqW0V/zA1BC4Vd0IpRd7tC8
         K84ZXfq9nH43ObWXEzF3a3Afqy4X8++RyQ+EW6AoAdK9X0PIsvtHA/DO5ZYTUYEPhzCs
         aXGw==
X-Gm-Message-State: AA+aEWatMuOd3a+oXOPH3CrrL2JaMm743fiRt3b1OwWortI64lpHQPKt
        gqW1ootUPvdRJF+Fr6quYoh4lyHR
X-Google-Smtp-Source: AFSGD/WKRPvMR1KG9AL/39rKQm6RVb4LxpJGuxH89rczGU7XHM3XKAcsJ9gJMh6PHKn1gmCtXdAO4A==
X-Received: by 2002:a19:2c92:: with SMTP id s140mr4470031lfs.42.1544352326880;
        Sun, 09 Dec 2018 02:45:26 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id s3-v6sm1564938lje.73.2018.12.09.02.45.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 02:45:26 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 24/24] FIXME
Date:   Sun,  9 Dec 2018 11:44:19 +0100
Message-Id: <20181209104419.12639-25-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.rc2.486.g9832c05c3d
In-Reply-To: <20181209104419.12639-1-pclouds@gmail.com>
References: <20181209104419.12639-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-backup-log.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/git-backup-log.txt b/Documentation/git-backup-log.txt
index 98998156c1..fe03726337 100644
--- a/Documentation/git-backup-log.txt
+++ b/Documentation/git-backup-log.txt
@@ -41,6 +41,8 @@ following commands will save backups:
   `--hard` or linkgit:git-am[1] and linkgit:git-rebase[1] with
   `--skip` or `--abort` will make a backup before overwriting non
   up-to-date files.
+- FIXME perhaps `git checkout <paths>` only makes backups on
+  "precious" paths only?
 
 Backups are split in three groups, changes related in the index, in
 working directory or in $GIT_DIR. These can be selected with `--id`
-- 
2.20.0.rc2.486.g9832c05c3d

