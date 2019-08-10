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
	by dcvr.yhbt.net (Postfix) with ESMTP id 947F21F731
	for <e@80x24.org>; Sat, 10 Aug 2019 05:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbfHJF7S (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Aug 2019 01:59:18 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51839 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfHJF7S (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Aug 2019 01:59:18 -0400
Received: by mail-wm1-f67.google.com with SMTP id 207so7599799wma.1
        for <git@vger.kernel.org>; Fri, 09 Aug 2019 22:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MFqtLNdPhiTIcx4ndsPMLLuHPgaNTQTXV8Z2svZB/R0=;
        b=XboGeADGG7/M0WmljfTs4TOocdXBMAPF8KfwuowWuYlf/NrhgOIzme/hfESSb4ohi6
         s06E7iNVz90woFzHwZKOqWO+yr6AO2WL0Vs3CvnmsSe9MldNQAdC/7iko3BQWpzyEjY7
         ErBiHD2N6fmu+nXjafM+YKDLM/ZfUaOsOne2q0SV799wPj/EY4L4zLmN2g4KiDVfGxlV
         GCUMDFV+fvp/FDA3ObSt0kWBR1Mrbs2i34vsTNsFn0C5BDfCCzGkHV6HfzK00+c3LbUd
         7ZVam9zQVyN845ssU91BDAjjyInWZLsdOu2gCjRDy5cK4OM5RI284yzUmt52ZfUC9Zz1
         0D9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MFqtLNdPhiTIcx4ndsPMLLuHPgaNTQTXV8Z2svZB/R0=;
        b=SXmoQNRHxqgeBso0pOEYt98BJ8LIl1V29ZA/5gBhC0GBSezkyty+lxJTS9E61mCIqH
         iMnZqu+mlivjVkpkp7/+Aj/Cgutk39R8SpJdLK9X0X2xJQEOxn/Rft4I6JpdSDc6NHuE
         OoCG/IJbxCtQ2kAW++mPV0eRff/KA3k+03QmsBrOjX4hil/G4lBNPmWV/WeQGCgc6PoQ
         SCgjM+UZuVtBUXfBtp2LmTmeyheBnT+SM01c7vmvlqL+6ghms4VaYaYTYr+4WwNrR88R
         ZXKL5dhgb0B93A2bpYcf0sy+TREpu8ml3fFSIC2FXwqttOn5rnd9G3krzvQEImzUvCgn
         HoBw==
X-Gm-Message-State: APjAAAVY37U5dRcfbcbLssWqOvx9vW1jo/NvuEZc5QN3PDM5B11SLlty
        9uTuc6FaJCJSFwhO3ZBZLPkTuWid
X-Google-Smtp-Source: APXvYqyp4zHsbg08DJqN2kiePMol0CwCCKWYNwWHabsHlFqeypgI+z9sdlXuC0xUZbI5GspPKP9vMA==
X-Received: by 2002:a1c:4b0b:: with SMTP id y11mr15575319wma.25.1565416754917;
        Fri, 09 Aug 2019 22:59:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x20sm7019364wmc.1.2019.08.09.22.59.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 22:59:14 -0700 (PDT)
Date:   Fri, 09 Aug 2019 22:59:14 -0700 (PDT)
X-Google-Original-Date: Sat, 10 Aug 2019 05:59:12 GMT
Message-Id: <76831150995dd3e7847825192b22114a6d4906d1.1565416752.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.309.git.gitgitgadget@gmail.com>
References: <pull.309.git.gitgitgadget@gmail.com>
From:   "Mark Rushakoff via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] doc: fix repeated words
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Mark Rushakoff <mark.rushakoff@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Mark Rushakoff <mark.rushakoff@gmail.com>

Inspired by 21416f0a07 ("restore: fix typo in docs", 2019-08-03), I ran
"git grep -E '(\b[a-zA-Z]+) \1\b' -- Documentation/" to find other cases
where words were duplicated, e.g. "the the", and in most cases removed
one of the repeated words.

There were many false positives by this grep command, including
deliberate repeated words like "really really" or valid uses of "that
that" which I left alone, of course.

I also did not correct any of the legitimate, accidentally repeated
words in old RelNotes.

Signed-off-by: Mark Rushakoff <mark.rushakoff@gmail.com>
---
 Documentation/config/color.txt                       | 2 +-
 Documentation/config/stash.txt                       | 2 +-
 Documentation/git-fast-export.txt                    | 2 +-
 Documentation/git-fast-import.txt                    | 2 +-
 Documentation/git-pack-objects.txt                   | 2 +-
 Documentation/git-push.txt                           | 2 +-
 Documentation/git-repack.txt                         | 2 +-
 Documentation/technical/hash-function-transition.txt | 2 +-
 Documentation/technical/protocol-v2.txt              | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/config/color.txt b/Documentation/config/color.txt
index 8375596c44..d5daacb13a 100644
--- a/Documentation/config/color.txt
+++ b/Documentation/config/color.txt
@@ -14,7 +14,7 @@ color.blame.highlightRecent::
 +
 This setting should be set to a comma-separated list of color and date settings,
 starting and ending with a color, the dates should be set from oldest to newest.
-The metadata will be colored given the colors if the the line was introduced
+The metadata will be colored given the colors if the line was introduced
 before the given timestamp, overwriting older timestamped colors.
 +
 Instead of an absolute timestamp relative timestamps work as well, e.g.
diff --git a/Documentation/config/stash.txt b/Documentation/config/stash.txt
index 7710758efb..abc7ef4a3a 100644
--- a/Documentation/config/stash.txt
+++ b/Documentation/config/stash.txt
@@ -4,7 +4,7 @@ stash.useBuiltin::
        the built-in rewrite of it in C.
 +
 The C rewrite is first included with Git version 2.22 (and Git for Windows
-version 2.19). This option serves an an escape hatch to re-enable the
+version 2.19). This option serves as an escape hatch to re-enable the
 legacy version in case any bugs are found in the rewrite. This option and
 the shell script version of linkgit:git-stash[1] will be removed in some
 future release.
diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index 11427acdde..cc940eb9ad 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -116,7 +116,7 @@ marks the same across runs.
 	and will make master{tilde}4 no longer have master{tilde}5 as
 	a parent (though both the old master{tilde}4 and new
 	master{tilde}4 will have all the same files).  Use
-	--reference-excluded-parents to instead have the the stream
+	--reference-excluded-parents to instead have the stream
 	refer to commits in the excluded range of history by their
 	sha1sum.  Note that the resulting stream can only be used by a
 	repository which already contains the necessary parent
diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 7baf9e47b5..fad327aecc 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -425,7 +425,7 @@ the same commit, as `filedeleteall` wipes the branch clean (see below).
 
 The `LF` after the command is optional (it used to be required).  Note
 that for reasons of backward compatibility, if the commit ends with a
-`data` command (i.e. it has has no `from`, `merge`, `filemodify`,
+`data` command (i.e. it has no `from`, `merge`, `filemodify`,
 `filedelete`, `filecopy`, `filerename`, `filedeleteall` or
 `notemodify` commands) then two `LF` commands may appear at the end of
 the command instead of just one.
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index e45f3e680d..fecdf2600c 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -131,7 +131,7 @@ depth is 4095.
 --keep-pack=<pack-name>::
 	This flag causes an object already in the given pack to be
 	ignored, even if it would have otherwise been
-	packed. `<pack-name>` is the the pack file name without
+	packed. `<pack-name>` is the pack file name without
 	leading directory (e.g. `pack-123.pack`). The option could be
 	specified multiple times to keep multiple packs.
 
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 6a8a0d958b..3b8053447e 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -75,7 +75,7 @@ without any `<refspec>` on the command line.  Otherwise, missing
 +
 If <dst> doesn't start with `refs/` (e.g. `refs/heads/master`) we will
 try to infer where in `refs/*` on the destination <repository> it
-belongs based on the the type of <src> being pushed and whether <dst>
+belongs based on the type of <src> being pushed and whether <dst>
 is ambiguous.
 +
 --
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index aa0cc8bd44..92f146d27d 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -142,7 +142,7 @@ depth is 4095.
 
 --keep-pack=<pack-name>::
 	Exclude the given pack from repacking. This is the equivalent
-	of having `.keep` file on the pack. `<pack-name>` is the the
+	of having `.keep` file on the pack. `<pack-name>` is the
 	pack file name without leading directory (e.g. `pack-123.pack`).
 	The option could be specified multiple times to keep multiple
 	packs.
diff --git a/Documentation/technical/hash-function-transition.txt b/Documentation/technical/hash-function-transition.txt
index bc2ace2a6e..2ae8fa470a 100644
--- a/Documentation/technical/hash-function-transition.txt
+++ b/Documentation/technical/hash-function-transition.txt
@@ -456,7 +456,7 @@ packfile marked as UNREACHABLE_GARBAGE (using the PSRC field; see
 below). To avoid the race when writing new objects referring to an
 about-to-be-deleted object, code paths that write new objects will
 need to copy any objects from UNREACHABLE_GARBAGE packs that they
-refer to to new, non-UNREACHABLE_GARBAGE packs (or loose objects).
+refer to new, non-UNREACHABLE_GARBAGE packs (or loose objects).
 UNREACHABLE_GARBAGE are then safe to delete if their creation time (as
 indicated by the file's mtime) is long enough ago.
 
diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index 03264c7d9a..40f91f6b1e 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -141,7 +141,7 @@ Capabilities
 ------------
 
 There are two different types of capabilities: normal capabilities,
-which can be used to to convey information or alter the behavior of a
+which can be used to convey information or alter the behavior of a
 request, and commands, which are the core actions that a client wants to
 perform (fetch, push, etc).
 
-- 
gitgitgadget
