Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B56391F404
	for <e@80x24.org>; Thu, 30 Aug 2018 21:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbeHaBqC (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 21:46:02 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55494 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727662AbeHaBqC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 21:46:02 -0400
Received: by mail-wm0-f65.google.com with SMTP id f21-v6so3334703wmc.5
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 14:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UDSSeZTe6sxINSFMBiGUn1b5HK4LZazZ2nVI5QfuLW4=;
        b=jlTLS6yniNsxC71HSgk0eqOqfJw2JTZKgKZlviTYY5f2dxGEAwqY5jBJNrSFAixHm+
         +xeMkBq6udIXZ0v9Xc9uGGhoLSqEj2HJmlOLaYnidqU9mK3NaB/n79cvr4c5CdMqkNmg
         F1U0cKirCArRavAx6ihjaArCRPtpQ4rxb2rvr3xphKWRs1rvO9OUEECHXzNKxHk/44CG
         9gqKbAHpasxdBxUQ7JiEdXrhaCzxasTj6vClcxk67OyYd/dvikUUDUfM/1SKxC5sdJfX
         sX0mNYRjfs9NB1pV5RQ0ygP/AgHOwraBaXV+fwhtAAXYxOKpHpXK68qPaUaF0iJOogO6
         nMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UDSSeZTe6sxINSFMBiGUn1b5HK4LZazZ2nVI5QfuLW4=;
        b=V+ty9PG2KzsvQlPpPyrLFhrp0OUBispF4Ku3VEiHGI5YAx/Qa7CyEscxNkDEGIggVV
         iibWd7SpjvAG+WC9OQQ4zhPEt1ZwTypEQMZxCL3gJEmkHA9FEmmWSvbXTw7ZZyyTcZNu
         kFZ9o2f3mbStPp4QlKLsWUk2WLwE+n5Z6UJDLbpucQhkvqgkoEViUMDy+c1t5YcIcjWe
         uBtHOyS782aGW8gXjBgll7DiF5INVQPQwtP9x9v4Efvv10csWkYeHpIXRFyRV+gGx57H
         sp8dHKYHxFYoyV24RCBo2slqhjorXwJbkLQPrkt5fAlZoVHGeuubu9vgqN3PGMilvMYY
         2UGg==
X-Gm-Message-State: APzg51DNoWrY/jVME7S6GJeeMHurtGK71UpCcPuVa5a/mN7geY7NaC4j
        n2+9pixxQKslgqmUKyqioYwM94Z6
X-Google-Smtp-Source: ANB0VdaU5CytKClTc9r74QiHf7bzSfGBOqA+ELfuoVdOGcKNh2H4d/T5Fry44EnG483OcHCPskO0+g==
X-Received: by 2002:a1c:9215:: with SMTP id u21-v6mr2928816wmd.106.1535665309027;
        Thu, 30 Aug 2018 14:41:49 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com ([188.24.241.57])
        by smtp.gmail.com with ESMTPSA id x24-v6sm14445951wrd.13.2018.08.30.14.41.48
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 14:41:48 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC][PATCH v8 12/20] stash: mention options in `show` synopsis.
Date:   Fri, 31 Aug 2018 00:40:42 +0300
Message-Id: <fff86f1761070b2e48591527408220fec42506d8.1535665109.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.22.gc26283d74e
In-Reply-To: <cover.1535665109.git.ungureanupaulsebastian@gmail.com>
References: <cover.1535665109.git.ungureanupaulsebastian@gmail.com>
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
index 1dba7e6853..02b593e0cd 100644
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
2.19.0.rc0.22.gc26283d74e

