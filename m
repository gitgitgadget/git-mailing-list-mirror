Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC4681F731
	for <e@80x24.org>; Wed, 31 Jul 2019 15:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbfGaPS4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 11:18:56 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50549 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728093AbfGaPSu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 11:18:50 -0400
Received: by mail-wm1-f68.google.com with SMTP id v15so61268378wml.0
        for <git@vger.kernel.org>; Wed, 31 Jul 2019 08:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GGKSaH3oRlOM8FzJB6pmcnmBGFy12SUqUZxXRnXhdCQ=;
        b=VMAlymT0x4o4ZXONs03NK2wqKB3pXIjm+xQ/ivflrGhPLNlqE55xssq29SFlyBx4tk
         Eb1L9paIadMQdTFhkGyYydJVzDrFqYLxs+pBArHOOO0owMciZ7XaNZNb3ZpM+y7tlpw6
         1Q703MCLGSCO1KoqeXDa2DEGhACAVaJf4Y6kUQX+a8IimHwv5gLIZgn8ixeyjcGQAxlU
         4LUheaVtCRpuKF4H29HnAk+rIP/nD0Y+o6Wn3ScmddhvatVV0BTclzydmodb4a2DhCbs
         UymWXp7XPIFROWavewUyxKmVr/PRYpgrNkmznqxBvIhGUgC3+AErQEpUghceXDxQp7UT
         TbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GGKSaH3oRlOM8FzJB6pmcnmBGFy12SUqUZxXRnXhdCQ=;
        b=IDLCOjt1Qi/FxuGJSJX0+7NsQ/IuD1TOmdCB9I/ayvpYkbLVHHB+u4X9nX8it40WQq
         Thyu4srF78402JPZ+SmSKwJmBJRWvwly1856O6XurdzZ8VEVfbqC5br8mejBNQaCZfn3
         foQSTBnYAyMQnt8CoKHhlsKig8i/vB45Fsjkmomj6L0PtFG4hGcNBphVj7mIvwzF7G80
         u74OR8ai4k8yTmvhxQumfG49MizlWsSps6LhsrRYqCeg/mdwdLmHRLp0txOscQvUfdKM
         feEy5+oFVfgLwPemW6RvPs35EyPtf5kszRc9WYYxuMehB10HUCmwnhxoIyvOBNLKICXd
         0T6A==
X-Gm-Message-State: APjAAAWpmgGbN9ClgN6Zon++rFK1K3GkPc5hZ7cXsVFgix8RXI57+ZsD
        u9wK/qYmG+L9J38nZIr9tKS1TPD3
X-Google-Smtp-Source: APXvYqyZg7LOi+Q+OcL4vqiECU5OGQgXNTKJFkOu/aHjHT4V2vYSh/PrVPrOV3wl+n+WyWniwKYDbQ==
X-Received: by 2002:a1c:107:: with SMTP id 7mr111692682wmb.84.1564586328793;
        Wed, 31 Jul 2019 08:18:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z1sm78590800wrv.90.2019.07.31.08.18.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 08:18:48 -0700 (PDT)
Date:   Wed, 31 Jul 2019 08:18:48 -0700 (PDT)
X-Google-Original-Date: Wed, 31 Jul 2019 15:18:34 GMT
Message-Id: <8f74bfbc534cc7a707462622ddf387c67c6de222.1564586316.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.294.v2.git.gitgitgadget@gmail.com>
References: <pull.294.git.gitgitgadget@gmail.com>
        <pull.294.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 14/16] t/lib-rebase: prepare for testing `git rebase
 --rebase-merges`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The format of the todo list is quite a bit different in the
`--rebase-merges` mode; Let's prepare the fake editor to handle those
todo lists properly, too.

The original idea was that we keep the original command unless
overridden, and because the original todo lists only had `pick` lines
anyway, we could be sloppy and "override" the command by the same
command (i.e. use the sed replacement pattern "pick" instead of "&").

This actually would not have worked with `fixup` and `squash` commands,
but it would appear that we never tried to use the fake editor with
`--autosquash`.

However, in the next commit we want to use the fake editor in
conjunction with `--rebase-merges`, so let's use the correct sed
replacement pattern.

Technically, it is not necessary to take care of the `fakesha` thing
(where we reuse the sed replacement pattern to craft a new todo
command), at least for now, as the only user of that thing overrides the
`action` anyway. Nevertheless, for completeness' sake, we do take care
of it.

Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/lib-rebase.sh | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index 7ea30e5006..6d87961e41 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -44,10 +44,10 @@ set_fake_editor () {
 	rm -f "$1"
 	echo 'rebase -i script before editing:'
 	cat "$1".tmp
-	action=pick
+	action=\&
 	for line in $FAKE_LINES; do
 		case $line in
-		pick|p|squash|s|fixup|f|edit|e|reword|r|drop|d)
+		pick|p|squash|s|fixup|f|edit|e|reword|r|drop|d|label|l|reset|r|merge|m)
 			action="$line";;
 		exec_*|x_*|break|b)
 			echo "$line" | sed 's/_/ /g' >> "$1";;
@@ -58,11 +58,12 @@ set_fake_editor () {
 		bad)
 			action="badcmd";;
 		fakesha)
+			test \& != "$action" || action=pick
 			echo "$action XXXXXXX False commit" >> "$1"
 			action=pick;;
 		*)
-			sed -n "${line}s/^pick/$action/p" < "$1".tmp >> "$1"
-			action=pick;;
+			sed -n "${line}s/^[a-z][a-z]*/$action/p" < "$1".tmp >> "$1"
+			action=\&;;
 		esac
 	done
 	echo 'rebase -i script after editing:'
-- 
gitgitgadget

