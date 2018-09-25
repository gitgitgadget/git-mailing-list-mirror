Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6219A1F453
	for <e@80x24.org>; Tue, 25 Sep 2018 22:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbeIZEoX (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 00:44:23 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43915 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbeIZEoW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 00:44:22 -0400
Received: by mail-ed1-f65.google.com with SMTP id u23so170493edx.10
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 15:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=mHW+rqM9iU4nNbUMXDMETiMjpGcp8iIDZwNZOPvm18M=;
        b=JrX7wzWZQp8dHHMkrS0nELN3XzfRReB0q8OjC3ya2QetGgwIPrTHtJVHOavhzxqHs9
         M8NJDPVQHPvuXF6AohWk2fJZnv0AegFodxvJk/QD3ryVjoenvOoJSMA3eaS3fIrlHqtS
         xdvmSl7hCBZqDfasEB++GvedcGEyHJa8YrEtZDvXFXZgexo1V/iIXxsB5OJbsZd4PbPo
         YQOOyo1H2WpzDdydwY9mY2IeU4dxqOg7QEZSybrC3t6XGXQNgVNY1nsjjThxuTTwFfrc
         YFAT9a9VdGyC4U4NDP9sJTsWJg4e2nQyMvjO0YR1GNiGr8UTgeZPn2z1wh2vkRqMgtW2
         E16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mHW+rqM9iU4nNbUMXDMETiMjpGcp8iIDZwNZOPvm18M=;
        b=hLV39jJ4qEx2by36ANVvcJfQxDdn5JoWcDHAzslmyNv6QqiaWu52U+Dif30MfEG4p6
         xB2JmecuClQVAWQxAw29BCX4xPVRn0HtBS4WL0zMjsQaS5izlo8KSrlsEAjwtRXcaeqd
         Sdt8MfS8emBocH1oBpJC+5Va1hVBgN2OPAM9Qzoad7OMlht/x8jWz2wJQzupwpVMbt/g
         BDGVWS8CSV/82kKPZaTGhkn7uZsYn2laBlGEEHYomF4vCgT50HBI7iTYGzfSNYDXfIoR
         wwWaJbJij0dNeWMUFJuZRgbAs1SU+Fdi6X8Dui2lSE9lFauBxxHCgKiY6mUDOnaSSQrt
         mqPw==
X-Gm-Message-State: ABuFfoh/Nxn3L5UsViti2qIPaFXAatZ9zSF6GV5PiH5V0UyVDfdkcB/h
        weOGaKViyzUJgcbnooaHu3HteYxg
X-Google-Smtp-Source: ACcGV60d5K79a0pyK83b+Y43fXRIuLmUHy05rvwYucUcsbWxui6BTE4K0DRTFNei9fiMd8Wr+SKElw==
X-Received: by 2002:a50:d2d4:: with SMTP id q20-v6mr2773244edg.212.1537914876401;
        Tue, 25 Sep 2018 15:34:36 -0700 (PDT)
Received: from localhost.localdomain ([92.55.154.13])
        by smtp.gmail.com with ESMTPSA id o37-v6sm33553edo.71.2018.09.25.15.34.35
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 15:34:35 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH v9 13/21] stash: mention options in `show` synopsis.
Date:   Wed, 26 Sep 2018 01:33:29 +0300
Message-Id: <f4df1a271333bcf82c5ea1c5d9604ceb1c0374f8.1537913094.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.23.g1fb9f40d88.dirty
In-Reply-To: <cover.1537913094.git.ungureanupaulsebastian@gmail.com>
References: <cover.1537913094.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mention in the usage text and in the documentation, that `show`
accepts any option known to `git diff`.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 Documentation/git-stash.txt | 4 ++--
 builtin/stash--helper.c     | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 7ef8c47911..e31ea7d303 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git stash' list [<options>]
-'git stash' show [<stash>]
+'git stash' show [<options>] [<stash>]
 'git stash' drop [-q|--quiet] [<stash>]
 'git stash' ( pop | apply ) [--index] [-q|--quiet] [<stash>]
 'git stash' branch <branchname> [<stash>]
@@ -106,7 +106,7 @@ stash@{1}: On master: 9cc0589... Add git-stash
 The command takes options applicable to the 'git log'
 command to control what is shown and how. See linkgit:git-log[1].
 
-show [<stash>]::
+show [<options>] [<stash>]::
 
 	Show the changes recorded in the stash entry as a diff between the
 	stashed contents and the commit back when the stash entry was first
diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index 1bc838ee6b..1f02f5f2e9 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -15,7 +15,7 @@
 
 static const char * const git_stash_helper_usage[] = {
 	N_("git stash--helper list [<options>]"),
-	N_("git stash--helper show [<stash>]"),
+	N_("git stash--helper show [<options>] [<stash>]"),
 	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
 	N_("git stash--helper ( pop | apply ) [--index] [-q|--quiet] [<stash>]"),
 	N_("git stash--helper branch <branchname> [<stash>]"),
@@ -29,7 +29,7 @@ static const char * const git_stash_helper_list_usage[] = {
 };
 
 static const char * const git_stash_helper_show_usage[] = {
-	N_("git stash--helper show [<stash>]"),
+	N_("git stash--helper show [<options>] [<stash>]"),
 	NULL
 };
 
-- 
2.19.0.rc0.23.g1fb9f40d88

