Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55F671F454
	for <e@80x24.org>; Wed,  6 Nov 2019 15:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731968AbfKFPv1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 10:51:27 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:38679 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfKFPvX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 10:51:23 -0500
Received: by mail-wr1-f52.google.com with SMTP id j15so5776633wrw.5
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 07:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=a7nAOz6S7qxezayNEsjR5/tbUnbYmHKlKuiGEH+fF+0=;
        b=snDjVsGxPTiYOtEHhmrBnFwlAJ+7+ccAuZez7bVls4CrAkxUozJgFtAq7GfbLgefWg
         kkc7x39qgIK4QBwMsoGmU87vrU5/yYnrZpKE7sSF+8XMCaTzlBnwzix5URJoZbM/z2PT
         9N5N/41cv1VqKbVxeEDGVUsgnS9xrtAgpkjxqPX5FoexjlW2UnB77LGW0uiKgOMNe94i
         fwMyysJnHiLmIVRCM1Rc4r85rdfcCEqrB7SPiUPtcgdUg2BapRWnxHzj9xseHchCaMpP
         6y4ZdVl1COF8yOBLLtIcTdGYztj0a3n625nuNBtQL3xnfGKW18kNh5oh0uRnJQeVfRV8
         gT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=a7nAOz6S7qxezayNEsjR5/tbUnbYmHKlKuiGEH+fF+0=;
        b=MT3eCSncS7mEwbMqfrf6/JuBlJYIt563MQVj4Rd0iVOxnf1Ym7qI4w9WWWXm0QtDcM
         pbz+0roCpZztANIF7PQvzQij/vf5bd6JtATGRpPXYjWzCYM9FSB09PobqYAtmOCSj+U3
         dLeu/inoK3OmvhAPOhnCV/l2OH6leX8HUEi6BfOKo9Kb87ADaJLvckEtEs0kE8usw5VC
         cJqG/tMcWhI/CF79dmU0z8n3qaSGCkZG5ilP2XlWvW+lhSa9R5edR8B75PZvvRPmHwP1
         2JbHPCeREkMDzr8Q8hG/pIu4iI+li0BDLMry7KWqGPnd+2mwI3S6Fgwj3Wm5MnWSKB04
         ogCQ==
X-Gm-Message-State: APjAAAX4wuSoANCb5sZzUfcQ9W6a5nnXcRuisE1CTr70EzVvQwzhDq8z
        4vm8IAySVjiCYHpu29m1Pzx43cHx
X-Google-Smtp-Source: APXvYqyjzL1AZc7HhcIpX72niPMsRnOKEXxYtiuXAf1pDWZCc1wz52wArt/5vpZ8Le0+2UmP2FhnmA==
X-Received: by 2002:adf:f744:: with SMTP id z4mr3348924wrp.205.1573055481999;
        Wed, 06 Nov 2019 07:51:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g5sm3103878wma.43.2019.11.06.07.51.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 07:51:21 -0800 (PST)
Message-Id: <f961a5155a5ec1590652ce7b5a549eead71930e1.1573055478.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.445.v2.git.1573055478.gitgitgadget@gmail.com>
References: <pull.445.git.1572895605.gitgitgadget@gmail.com>
        <pull.445.v2.git.1573055478.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 06 Nov 2019 15:51:15 +0000
Subject: [PATCH v2 3/6] doc: reset: unify <pathspec> description
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

Synchronize it to `git add`, which has a pretty good description.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 Documentation/git-reset.txt | 20 +++++++++++---------
 builtin/reset.c             |  4 ++--
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 97e0544d9e..f2ccb1426c 100644
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
@@ -18,24 +18,26 @@ In the first and second form, copy entries from `<tree-ish>` to the index.
 In the third form, set the current branch head (`HEAD`) to `<commit>`,
 optionally modifying index and working tree to match.
 The `<tree-ish>`/`<commit>` defaults to `HEAD` in all forms.
+The <pathspec> is used to limit the paths affected by the operation
+(see the entry for 'pathspec' in linkgit:gitglossary[7] for more details).
 
-'git reset' [-q] [<tree-ish>] [--] <paths>...::
-	This form resets the index entries for all `<paths>` to their
+'git reset' [-q] [<tree-ish>] [--] <pathspec>...::
+	This form resets the index entries for all `<pathspec>` to their
 	state at `<tree-ish>`.  (It does not affect the working tree or
 	the current branch.)
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

