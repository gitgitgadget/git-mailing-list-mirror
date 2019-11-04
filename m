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
	by dcvr.yhbt.net (Postfix) with ESMTP id A21831F454
	for <e@80x24.org>; Mon,  4 Nov 2019 19:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbfKDT05 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 14:26:57 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:52653 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728174AbfKDT05 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 14:26:57 -0500
Received: by mail-wm1-f54.google.com with SMTP id c17so10654855wmk.2
        for <git@vger.kernel.org>; Mon, 04 Nov 2019 11:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=waBZ4um6LSwy/tUPCWFwxpxLDxnjJ6c/VuxOBpvmTfQ=;
        b=te0oSUE3GefME5PNruJlU4V7HnxCsfgAIZ4M8ySLNbcaWoRoj1ntmXsUwLM+WbdXRL
         UDqL2sB3huI9U7DNnc34GP591MJKefi+JbfFGRE0TTgczlme5x5yvMgEf1WhEgUArEOV
         /KikZJHn7O+pcEGaBKBj734xWitSkD7XZXyX4rIqpdhcUsfQV50ZwkJ7/WpmfOqen+w0
         ZJQU+hVO6jVayT7x5wl9J9BEiuVtM4/ThTTwT7GLDJK/fpILMQZkjE6yh2Ho2+Rs+VvY
         D3DhPWThOpFgdroRlnIHGQpCX7/H5JASIm2BiCpI+5egNw8cyp9walK74HYwTz8GUD6N
         S3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=waBZ4um6LSwy/tUPCWFwxpxLDxnjJ6c/VuxOBpvmTfQ=;
        b=e6ZtAb9/W0v9Euih6OnMscWQlyl52snUHr4xfg7A0E358j5LuZsrMIcL6Y9i7uq9Ct
         l1XhUKCWPQ34ngrJV4IWlgWUgDhmjHYgHr1rvitQyZv5Mi+U/ENHGcvILGFBPPRdJ5Y5
         2Ue1hI5ZfWyxhzJmyDJk/Iib03kplU1/TpS3gBZ+dOH68Jn9RArrjqAAOATXBmfr6sb/
         LE4wr/RXrMkuLxG/7r40wLg4dL9ewXPbArVCjVTr8bTQvDHEwyfrAvCXls+9XIsFSKxZ
         aCg9hw/aElaxtM+aNRxrjkhwtO66Bwb/JwTTCrGjjjjGdQL60VSEpffEql4LVPPsZsnP
         njmA==
X-Gm-Message-State: APjAAAVL2eqq97OlCtAnoqvquJBfV9wqznfz+3w+FFUgawm2fhRuCfuR
        N85nQjUBQFvyyJzcU/erQ0nLIblt
X-Google-Smtp-Source: APXvYqyTKjFH75fu7xdu6q9j0sdCKkh2hRC4JQAWx90PlcI/U1cUxQbDd4zG9nEg06YyDhtX656aug==
X-Received: by 2002:a1c:7d47:: with SMTP id y68mr574907wmc.157.1572895607791;
        Mon, 04 Nov 2019 11:26:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a206sm25308447wmf.15.2019.11.04.11.26.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 11:26:47 -0800 (PST)
Message-Id: <1740ac7a291cfc81418c2d437201c3373487fa26.1572895605.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.445.git.1572895605.gitgitgadget@gmail.com>
References: <pull.445.git.1572895605.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 Nov 2019 19:26:42 +0000
Subject: [PATCH 2/5] doc: reset: unify <pathspec> description
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
 Documentation/git-reset.txt | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 97e0544d9e..b0ea6e0ce5 100644
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
@@ -19,27 +19,33 @@ In the third form, set the current branch head (`HEAD`) to `<commit>`,
 optionally modifying index and working tree to match.
 The `<tree-ish>`/`<commit>` defaults to `HEAD` in all forms.
 
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
+For more details about the <pathspec> syntax, see the 'pathspec' entry
+in linkgit:gitglossary[7].
 +
-After running `git reset <paths>` to update the index entry, you can
+This means that `git reset <pathspec>` is the opposite of `git add
+<pathspec>`. This command is equivalent to
+`git restore [--source=<tree-ish>] --staged <pathspec>...`.
++
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
 +
+For more details about the <pathspec> syntax, see the 'pathspec' entry
+in linkgit:gitglossary[7].
++
 This means that `git reset -p` is the opposite of `git add -p`, i.e.
 you can use it to selectively reset hunks. See the ``Interactive Mode''
 section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
-- 
gitgitgadget

