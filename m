Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B48C31F517
	for <e@80x24.org>; Tue,  5 Jun 2018 15:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752104AbeFEPnv (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 11:43:51 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:44923 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751864AbeFEPnt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 11:43:49 -0400
Received: by mail-lf0-f68.google.com with SMTP id 36-v6so4305091lfr.11
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 08:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L/2BQM1FKIBjodlNSVRAke+U2HyaX9rVQDXnjip3ICQ=;
        b=QLDuZoHvjM28csVlfLHNNQ/umKj+9Kn8uMEeszbAhTZe9RXc0vPv0nPG2YqypNHW6t
         f4ae/xlFXqKF9h+WZqjFHZOw4tWpkkm9kw2m19FVa+hVPGjsi4jd7kO7BBQ25Jd6sjw0
         ioi+oYCaZFLPhSmVhO3/T1hiHgcNu/OTltwviKLsg2nlVhwRfKraUvUYU5Xp5Ufs6k/K
         08LAfzZt97y66PmkH/cdVMT6npRSYIlihJJXDGJAIghB1bBS4L6v/37uvVVrxkAHX6Ig
         /lw/Pfq537JxkXl/UESgKYxyy0HBYtlvaCWxrjsUHBumK1r4XkAFo+wcvzKwW10FQl7s
         3uSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L/2BQM1FKIBjodlNSVRAke+U2HyaX9rVQDXnjip3ICQ=;
        b=krGg6mtgVhfSSb7HrsSQ6BgwTjiAvz3yR07jC/NtbsU1e+EKlVr2M2Em9def3WrGJT
         Es/8lG+zv/4i0JoieuZNxUWW3+isDM6Lc3fyHsuZWMT7SncLLQzh6eOea0WiZ1SoisC7
         Zwy3cxHsvXs+/eTsQIM6VLvPKPERUL5DOtDb27qSVrWceIiUgRSm2h3BB8aHRr88dJlg
         szoc1862m1RyzNR2J7rfc03CQCFDrmGIeyMQpbAhxlCd85WQ/1ACPl+PjBQaoni4KpSi
         XhWVvFde27BqXkE1Ifk49yeaWErziOcP3UkSo1u7mnI8SgG4oSiQSNqRcXyLBb5go9f4
         s1KA==
X-Gm-Message-State: APt69E3lNwmLs+jytisKh9PCddy+TtsyVRgY37o6afJXoMAY2zGUJIIq
        Hh5VA/h6e9mtQFVJ1Y6UjZdp1w==
X-Google-Smtp-Source: ADUXVKI/Ih4gZ+tn5h/1CemrWLcLU5JkcdO7Dhrl+MxriqZDKTgp9gZGLxBildvwChxtu2UmLLkoNw==
X-Received: by 2002:a19:6a0f:: with SMTP id u15-v6mr2035567lfu.81.1528213427059;
        Tue, 05 Jun 2018 08:43:47 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o9-v6sm5161054lfk.2.2018.06.05.08.43.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jun 2018 08:43:46 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 5/6] unpack-trees: avoid the_index in verify_absent()
Date:   Tue,  5 Jun 2018 17:43:33 +0200
Message-Id: <20180605154334.22613-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180605154334.22613-1-pclouds@gmail.com>
References: <20180601161153.15192-1-pclouds@gmail.com>
 <20180605154334.22613-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Both functions that are updated in this commit are called by
verify_absent(), which is part of the "unpack-trees" operation that is
supposed to work on any index file specified by the caller. Thanks to
Brandon [1] [2], an implicit dependency on the_index is exposed. This
commit fixes it.

In both functions, it makes sense to use src_index to check for
exclusion because it's almost unchanged and should give us the same
outcome as if running the exclude check before the unpack.

It's "almost unchanged" because we do invalidate cache-tree and
untracked cache in the source index. But this should not affect how
exclude machinery uses the index: to see if a file is tracked, and to
read a blob from the index instead of worktree if it's marked
skip-worktree (i.e. it's not available in worktree)

[1] a0bba65b10 (dir: convert is_excluded to take an index - 2017-05-05
[2] 2c1eb10454 (dir: convert read_directory to take an index - 2017-05-05)

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 unpack-trees.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 5268de7af5..3ace82ca27 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1651,7 +1651,7 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
 	memset(&d, 0, sizeof(d));
 	if (o->dir)
 		d.exclude_per_dir = o->dir->exclude_per_dir;
-	i = read_directory(&d, &the_index, pathbuf, namelen+1, NULL);
+	i = read_directory(&d, o->src_index, pathbuf, namelen+1, NULL);
 	if (i)
 		return o->gently ? -1 :
 			add_rejected_path(o, ERROR_NOT_UPTODATE_DIR, ce->name);
@@ -1693,7 +1693,7 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
 		return 0;
 
 	if (o->dir &&
-	    is_excluded(o->dir, &the_index, name, &dtype))
+	    is_excluded(o->dir, o->src_index, name, &dtype))
 		/*
 		 * ce->name is explicitly excluded, so it is Ok to
 		 * overwrite it.
-- 
2.18.0.rc0.333.g22e6ee6cdf

