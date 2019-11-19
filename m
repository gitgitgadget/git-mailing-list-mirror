Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D78C1F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 16:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbfKSQtC (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Nov 2019 11:49:02 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:53576 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728387AbfKSQtB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 11:49:01 -0500
Received: by mail-wm1-f54.google.com with SMTP id u18so3966170wmc.3
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 08:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/uK7BgEr7oMW5g58dt51M2VtdlmyVxFS9orGRLslvD0=;
        b=h4/sfycvl6thCdM8GHBst2wuTExThGYpJqMC7TUV2IlQmZLLOIUAY2Pn2SVqBrkK3Y
         92NlSvGaH0syQ5BlQFm5o2OzTVgZKS4T18cCBqIo2kG6/xnf/ZnIgtFBs0+CdxdgVymd
         osMaO/UGteepSlfjCdFBC0aCmhvNqrQ2WqkwgJ7xK+w1uaOmx97eu7M2dtcftpg3idfz
         qCGXc+7Dg84U3uzUAZzOA100OSm6Tz5qknjUIiuXUiGd/0P7LttGNTZTCj0UgAztOYqi
         VnxzXOtnjIklO6/TGTxnmweuVx7a5stM9AzlvgK2bTk4kVFXcdgjIq+ulO+mjpqr4XXq
         H+8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/uK7BgEr7oMW5g58dt51M2VtdlmyVxFS9orGRLslvD0=;
        b=fnGRn6DQC3VqpHhRMLq1rgUByyVkYzV0A/lLUmGWduK9FmH/qEW1j5FWa6uuo69W+S
         YDZeeA3f+Dy+w0LRy/3dXf7boiUuNVTQTmoq6Fx1zgkCWOOboflGtSwnFrQhweHsLxOH
         Z/1vW4OpPIVIo6mMMpRNQGEf+QDNXQxWbQlff7v543kFsL7wuXQbl+Y8VGT7JUSZh3ip
         iVpJ87SjZmNmtihiBFqkniZ17dyciEP36kK0xD2ADgODsM8KIBnS4nbM19DIG4sJRzir
         sqa752yIRrY/SM0Yzt6ACDctFVQTGX8Cq+oMmddUvceXTPJSve7hmNu08EESfHiU4Qq+
         RHdw==
X-Gm-Message-State: APjAAAXzPIx54DhJsUbmw3mB4iC5T0eBd9hMgOSxBhCltMbE2dkshZz4
        OuS91JxDAmw2wgVDdw7pGLKRTCfgU1o=
X-Google-Smtp-Source: APXvYqwhNfC/mMbrndQKFW7dS38WOVZquJysWJZW46sIZbMB40FYuk77fKVSXoT40e0QZgsbwNJCZw==
X-Received: by 2002:a1c:2155:: with SMTP id h82mr6667706wmh.94.1574182139047;
        Tue, 19 Nov 2019 08:48:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n65sm3811164wmf.28.2019.11.19.08.48.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Nov 2019 08:48:58 -0800 (PST)
Message-Id: <d9f32e523caafa0ab6f9536d764d221fb090015c.1574182135.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.445.v3.git.1574182135.gitgitgadget@gmail.com>
References: <pull.445.v2.git.1573055478.gitgitgadget@gmail.com>
        <pull.445.v3.git.1574182135.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Nov 2019 16:48:52 +0000
Subject: [PATCH v3 3/6] doc: reset: synchronize <pathspec> description
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

`git add` shows an example of good writing, follow it.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 Documentation/git-reset.txt | 29 ++++++++++++++++++-----------
 builtin/reset.c             |  4 ++--
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 97e0544d9e..d517a43e73 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -8,8 +8,8 @@ git-reset - Reset current HEAD to the specified state
 SYNOPSIS
 --------
 [verse]
-'git reset' [-q] [<tree-ish>] [--] <paths>...
-'git reset' (--patch | -p) [<tree-ish>] [--] [<paths>...]
+'git reset' [-q] [<tree-ish>] [--] <pathspec>...
+'git reset' (--patch | -p) [<tree-ish>] [--] [<pathspec>...]
 'git reset' [--soft | --mixed [-N] | --hard | --merge | --keep] [-q] [<commit>]
 
 DESCRIPTION
@@ -19,23 +19,23 @@ In the third form, set the current branch head (`HEAD`) to `<commit>`,
 optionally modifying index and working tree to match.
 The `<tree-ish>`/`<commit>` defaults to `HEAD` in all forms.
 
-'git reset' [-q] [<tree-ish>] [--] <paths>...::
-	This form resets the index entries for all `<paths>` to their
-	state at `<tree-ish>`.  (It does not affect the working tree or
-	the current branch.)
+'git reset' [-q] [<tree-ish>] [--] <pathspec>...::
+	This form resets the index entries for all paths that match the
+	`<pathspec>` to their state at `<tree-ish>`.  (It does not affect
+	the working tree or the current branch.)
 +
-This means that `git reset <paths>` is the opposite of `git add
-<paths>`. This command is equivalent to
-`git restore [--source=<tree-ish>] --staged <paths>...`.
+This means that `git reset <pathspec>` is the opposite of `git add
+<pathspec>`. This command is equivalent to
+`git restore [--source=<tree-ish>] --staged <pathspec>...`.
 +
-After running `git reset <paths>` to update the index entry, you can
+After running `git reset <pathspec>` to update the index entry, you can
 use linkgit:git-restore[1] to check the contents out of the index to
 the working tree. Alternatively, using linkgit:git-restore[1]
 and specifying a commit with `--source`, you
 can copy the contents of a path out of a commit to the index and to the
 working tree in one go.
 
-'git reset' (--patch | -p) [<tree-ish>] [--] [<paths>...]::
+'git reset' (--patch | -p) [<tree-ish>] [--] [<pathspec>...]::
 	Interactively select hunks in the difference between the index
 	and `<tree-ish>` (defaults to `HEAD`).  The chosen hunks are applied
 	in reverse to the index.
@@ -101,6 +101,13 @@ OPTIONS
 	`reset.quiet` config option. `--quiet` and `--no-quiet` will
 	override the default behavior.
 
+\--::
+	Do not interpret any more arguments as options.
+
+<pathspec>...::
+	Limits the paths affected by the operation.
++
+For more details, see the 'pathspec' entry in linkgit:gitglossary[7].
 
 EXAMPLES
 --------
diff --git a/builtin/reset.c b/builtin/reset.c
index fdd572168b..9291c0fd72 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -30,8 +30,8 @@
 
 static const char * const git_reset_usage[] = {
 	N_("git reset [--mixed | --soft | --hard | --merge | --keep] [-q] [<commit>]"),
-	N_("git reset [-q] [<tree-ish>] [--] <paths>..."),
-	N_("git reset --patch [<tree-ish>] [--] [<paths>...]"),
+	N_("git reset [-q] [<tree-ish>] [--] <pathspec>..."),
+	N_("git reset --patch [<tree-ish>] [--] [<pathspec>...]"),
 	NULL
 };
 
-- 
gitgitgadget

