Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8D7D1F453
	for <e@80x24.org>; Mon, 22 Oct 2018 22:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbeJWGfa (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 02:35:30 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37300 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbeJWGf2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 02:35:28 -0400
Received: by mail-pf1-f195.google.com with SMTP id j23-v6so20599327pfi.4
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 15:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=LgbnoWrkL0H8/Bvb4Ipy1eimRE0NR0TmP7GPA3S36dQ=;
        b=St3vLX5oWG7oTLIiYOfE4gC9vtMsAB/pYkdgqsd+9wBQIoEjfVRhtNvxUOGp6Ggj2h
         GJmSgWXk2XsBvqfXAJQHFJFoRb0m0R6PvHu37zPQwQZztKVucShdSEvYJ6g/5oIJnHV7
         r3N+/aZj9rJ6opGgaqv3GEeQLdevpA3ik6K79MUKrMYg7p5nlAnTUk5E22xRVf7fs2aK
         UHFkqGrRUsyHQAT6UDIU+jwJstOSXPPksvfwwrzfb7f10q9k8jfIbSJme8tvKRoZ96hE
         NVa6v1K/l2NPm5jn0gncG8jnfBvtUVbKYRw/Mc5F69J7WKOcVdYHpI27VTbx0APOu537
         dNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LgbnoWrkL0H8/Bvb4Ipy1eimRE0NR0TmP7GPA3S36dQ=;
        b=PMQO+w68uutfzBiTiqBpeTl5hhhv5EdrPW5BptZK1hOhdlU7fwMHH1LkVH0zRWgdkn
         9GJ2CuOaKT3GtnNooeBMAZy3fvqhFl/XHGdVR+6ri/cuF0aqi3tYraespsyb2RBa1aiT
         qLPjJJtTKq7oGaYle44NMxyLjc/j1IzzD170s/UZQdMjJ5PVhpI/j9eusa3qMt+YbWL7
         u5MEnqVqbqL5a5Qrp+Wnsrr0Wb7Ir0/OB+zYLX9urFBkueUEjP2E5qmK/SAfg3wzl1Ye
         7X3NGR5OOHTXp/TiRFq+7Okzy07qwQU05LcYaKk+cCosiI1vpclbnyV0IY4jTDHLKDYN
         UkPg==
X-Gm-Message-State: ABuFfohX1NZzbTcY0EWtM4l1fURR7ZW254ycqzt6IxrsXHPdtk1PUORu
        Bh7aubOiajqeOjn1oxQv5e7EWMAI
X-Google-Smtp-Source: ACcGV61n1Uy2ugJ8bywBwKzWikaDW+dJWyD8yQmKjR/+BIZEq/Ulk+0ff3Vqispl7am14vRrHX63Dg==
X-Received: by 2002:a63:cb51:: with SMTP id m17-v6mr43138459pgi.105.1540246504640;
        Mon, 22 Oct 2018 15:15:04 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id k132-v6sm2718381pga.28.2018.10.22.15.15.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 15:15:03 -0700 (PDT)
Date:   Mon, 22 Oct 2018 15:15:03 -0700 (PDT)
X-Google-Original-Date: Mon, 22 Oct 2018 22:14:57 GMT
Message-Id: <86107a6d0a044e3338e6f70313917066d200a1f4.1540246499.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.52.v2.git.gitgitgadget@gmail.com>
References: <pull.52.git.gitgitgadget@gmail.com>
        <pull.52.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 2/3] rebase (autostash): store the full OID in
 <state-dir>/autostash
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     SZEDER Gabor <szeder.dev@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

It was reported by Gábor Szeder and analyzed by Alban Gruin that the
built-in rebase stores only abbreviated stash hashes in the `autostash`
file.

This is problematic e.g. in t5520-pull.sh, where the abbreviated hash is
so short that it sometimes consists only of digits, which are
subsequently mistaken ("DWIMmed") for numbers by `git stash apply`.

Let's align the behavior of the built-in rebase with the scripted rebase
and store the full stash hash instead. That makes it a lot less likely
that it consists only of digits.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index d21504d9f..418624837 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1375,7 +1375,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			if (safe_create_leading_directories_const(autostash))
 				die(_("Could not create directory for '%s'"),
 				    options.state_dir);
-			write_file(autostash, "%s", buf.buf);
+			write_file(autostash, "%s", oid_to_hex(&oid));
 			printf(_("Created autostash: %s\n"), buf.buf);
 			if (reset_head(&head->object.oid, "reset --hard",
 				       NULL, 0, NULL, NULL) < 0)
-- 
gitgitgadget

