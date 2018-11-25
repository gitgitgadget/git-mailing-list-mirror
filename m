Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19C861F97E
	for <e@80x24.org>; Sun, 25 Nov 2018 11:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbeKYV54 (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Nov 2018 16:57:56 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35683 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbeKYV54 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Nov 2018 16:57:56 -0500
Received: by mail-pg1-f193.google.com with SMTP id s198so4836838pgs.2
        for <git@vger.kernel.org>; Sun, 25 Nov 2018 03:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=sqeG4n4uvzBIA11khEuqHQiSaOWodWQxW6OxwPnpJMc=;
        b=ODTJiLM2cnMvf1n0IiWVlxBsyI3QDgeloqhA+o1xNglZh5fh8m3Svu28jMs0EZ7217
         7U1SKyUNHIUOABecQKJJiX8WrU0uy50YpFMzHIjO5S5pwoQFe26AvcBQ59+lWNqN9XOA
         3ZHg7IpQkwoQXX4ReETcV4KB/gA2GdgwTM6BD283KAQOX1tfkmA2neA1rAk/XwZXEHK0
         cGqBx/rYpB0oL7HcPmnx7At4l8Me6sn+baNvJYpBZieGTApjo40MOaXUCJwZTTGYYvf6
         YdU/PeLDfXS7bknnXWiOPb2EjuzRIj50da+HEMRgBblPsf2mziHHWGo4GW67U968b636
         gTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sqeG4n4uvzBIA11khEuqHQiSaOWodWQxW6OxwPnpJMc=;
        b=YIbH8QGnja0V17WPDHVVLGFofejdN53BTIxiSCjzeCTxSHU6dlEmweoFA+fbBdBJc0
         GeinZT6KnKVSwyqI7OnyERUN73u0AiZsRl4u/BdEjYYg3oICuxudXiZMR1Bx1bXHUZlK
         kAXAkyMtYvhJWxIDabm7FfJLKFGgpkNXMBUmCLpgBdPmLyYK/Oax6ttzu6ssZFCPGYxy
         ZTy7W9yU+2aNbTeRpTKmMZt2YQklyzqnMUTo+2zg6tN0HUf8f0g9sGd7660Y1sJVN2UW
         lQxllITu6Fv9PJYh7Fm6CUVO29DMPt3vPnWp9VtOlS6f4NWGucc48OWiLSWx38bhy4EU
         +KQQ==
X-Gm-Message-State: AGRZ1gL+mz6D5gSy5/CeQfgWXpRh1/K4HaUVtsmFFUhFps1xNy0Sslvi
        hhVHbex+7IKu8AFqVrPZXApvMVfF
X-Google-Smtp-Source: AJdET5c/NREzOxo4HWqwgkKJ6FReuxho/VHBsFE2i/u45d2CYj4jpnRqB0pxAchi2oUnvVNnxMyWEQ==
X-Received: by 2002:a62:6204:: with SMTP id w4mr23461381pfb.5.1543144025814;
        Sun, 25 Nov 2018 03:07:05 -0800 (PST)
Received: from localhost.localdomain ([136.179.21.64])
        by smtp.gmail.com with ESMTPSA id h15sm21154301pgl.43.2018.11.25.03.07.05
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 25 Nov 2018 03:07:05 -0800 (PST)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Subject: [RFC PATCH 2/7] t0301: remove trailing / for dir creation
Date:   Sun, 25 Nov 2018 03:06:45 -0800
Message-Id: <fdf6f2ec6296cf48f5e5ac5edc5fe93adca77f32.1543143503.git.carenas@gmail.com>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <cover.1543143503.git.carenas@gmail.com>
References: <cover.1543143503.git.carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

the semantics of how mkdir -p should work, specially when using -m are
not standard and in this case NetBSD will assume that the permision
should not be changed, breaking the test

-p is technically not needed either, but will be cleared in a future
patch eventhough it could be considered an alternative fix

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 t/t0301-credential-cache.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t0301-credential-cache.sh b/t/t0301-credential-cache.sh
index fd92533acf..9529c612af 100755
--- a/t/t0301-credential-cache.sh
+++ b/t/t0301-credential-cache.sh
@@ -77,9 +77,9 @@ test_expect_success "use custom XDG_CACHE_HOME even if xdg socket exists" '
 test_expect_success 'use user socket if user directory exists' '
 	test_when_finished "
 		git credential-cache exit &&
-		rmdir \"\$HOME/.git-credential-cache/\"
+		rmdir \"\$HOME/.git-credential-cache\"
 	" &&
-	mkdir -p -m 700 "$HOME/.git-credential-cache/" &&
+	mkdir -p -m 700 "$HOME/.git-credential-cache" &&
 	check approve cache <<-\EOF &&
 	protocol=https
 	host=example.com
@@ -92,10 +92,10 @@ test_expect_success 'use user socket if user directory exists' '
 test_expect_success SYMLINKS 'use user socket if user directory is a symlink to a directory' '
 	test_when_finished "
 		git credential-cache exit &&
-		rmdir \"\$HOME/dir/\" &&
+		rmdir \"\$HOME/dir\" &&
 		rm \"\$HOME/.git-credential-cache\"
 	" &&
-	mkdir -p -m 700 "$HOME/dir/" &&
+	mkdir -p -m 700 "$HOME/dir" &&
 	ln -s "$HOME/dir" "$HOME/.git-credential-cache" &&
 	check approve cache <<-\EOF &&
 	protocol=https
-- 
2.20.0.rc1

