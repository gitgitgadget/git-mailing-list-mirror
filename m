Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FCF31F404
	for <e@80x24.org>; Mon, 13 Aug 2018 11:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729364AbeHMOPU (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 10:15:20 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:40320 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729288AbeHMOPT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 10:15:19 -0400
Received: by mail-pl0-f67.google.com with SMTP id s17-v6so6769917plp.7
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 04:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5srBFHW37HjMY6MLNoeDiinK+kcVL3edgKvqNyvp1GY=;
        b=P+YQI+znKHrJe68vMTITzaRXY5fjLexPRJCd5DPLsvG/bg7nju3wIrlRFHeKDmTKUq
         ryxhiXs7MJEmT19pLZE2YMhd2Hyf0UJhMHM/F/yxc07K9g/2HHWEh15wgvjYQk0XYc7+
         ATO82OCBUlB0yXELABR5/wg/bi89EzTyQggYsUNfTJmDgrax/GxWYYtiRk8vp0jiq5G6
         /Sywjh5eT//Qr8yU4hLlgGymaaBj3160dG0tuMzmUKhLphXEXkLl1Cf10LLp3iHR+ral
         ac63mPoYL+AtIdnWb/phWMjY7ADg6MKHJSXKS/BzP5ayAoFQuTRXFcqYmkl1+EDFhU72
         01aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5srBFHW37HjMY6MLNoeDiinK+kcVL3edgKvqNyvp1GY=;
        b=j5AMm/G7n03IpQYzfIip/LxqCYS+wpYEeoqCvZ7FBhuEjGZR6NwX7A7uW4FkH+oQ6o
         dXrO7x7EDA15eLmcv0G9gfymdVP9HiHTC9UIoi1QBxUBudaA4P6KnFBkE27lyRyhUu8e
         JmdDDrdPpAw2qi9OLXShHTFbtd4DQ2DBJguF4AvuwNyC7JNuNoJXncs1p52Zu8r5Cus/
         Ydo8a5CzwpGVHbCwoYVBxoSO8qiXIIfZZhPqxsjPCShEXMja77xyxJfIzZ9k0z0Yn518
         DZT35pomD2E6CSWpSLotT4UhgJYexFPy9O46jlYa1NOS15GBsvQvYb6Qye3haNUB8Bsm
         VifQ==
X-Gm-Message-State: AOUpUlE99wpbJEhJxz24BVzcIAgLxJYi19JaXgSsoawQUvkpmj/qtIah
        Jat27GU4DWvbePMmUmgCbBWHH39t
X-Google-Smtp-Source: AA+uWPw195aNHg8SB+8YbxoLStiMmsusTJBlGlnHiMyYhq+tbqj+dcYikBUZGoFdzdXsbk+npPDWjw==
X-Received: by 2002:a17:902:900a:: with SMTP id a10-v6mr16386316plp.143.1534160006757;
        Mon, 13 Aug 2018 04:33:26 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id 22-v6sm29419531pfl.126.2018.08.13.04.33.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 04:33:25 -0700 (PDT)
Date:   Mon, 13 Aug 2018 04:33:25 -0700 (PDT)
X-Google-Original-Date: Mon, 13 Aug 2018 11:32:52 GMT
Message-Id: <8c5543a0667fffe0cb0684427f726fdfb75b28d0.1534159977.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v6.git.gitgitgadget@gmail.com>
References: <pull.1.v5.git.gitgitgadget@gmail.com>
        <pull.1.v6.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 17/21] range-diff: populate the man page
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The bulk of this patch consists of a heavily butchered version of
tbdiff's README written by Thomas Rast and Thomas Gummerer, lifted from
https://github.com/trast/tbdiff.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-range-diff.txt | 229 +++++++++++++++++++++++++++++++
 1 file changed, 229 insertions(+)

diff --git a/Documentation/git-range-diff.txt b/Documentation/git-range-diff.txt
index 49f717db8..bebb47d42 100644
--- a/Documentation/git-range-diff.txt
+++ b/Documentation/git-range-diff.txt
@@ -5,6 +5,235 @@ NAME
 ----
 git-range-diff - Compare two commit ranges (e.g. two versions of a branch)
 
+SYNOPSIS
+--------
+[verse]
+'git range-diff' [--color=[<when>]] [--no-color] [<diff-options>]
+	[--dual-color] [--creation-factor=<factor>]
+	( <range1> <range2> | <rev1>...<rev2> | <base> <rev1> <rev2> )
+
+DESCRIPTION
+-----------
+
+This command shows the differences between two versions of a patch
+series, or more generally, two commit ranges (ignoring merge commits).
+
+To that end, it first finds pairs of commits from both commit ranges
+that correspond with each other. Two commits are said to correspond when
+the diff between their patches (i.e. the author information, the commit
+message and the commit diff) is reasonably small compared to the
+patches' size. See ``Algorithm`` below for details.
+
+Finally, the list of matching commits is shown in the order of the
+second commit range, with unmatched commits being inserted just after
+all of their ancestors have been shown.
+
+
+OPTIONS
+-------
+--dual-color::
+	When the commit diffs differ, recreate the original diffs'
+	coloring, and add outer -/+ diff markers with the *background*
+	being red/green to make it easier to see e.g. when there was a
+	change in what exact lines were added.
+
+--creation-factor=<percent>::
+	Set the creation/deletion cost fudge factor to `<percent>`.
+	Defaults to 60. Try a larger value if `git range-diff` erroneously
+	considers a large change a total rewrite (deletion of one commit
+	and addition of another), and a smaller one in the reverse case.
+	See the ``Algorithm`` section below for an explanation why this is
+	needed.
+
+<range1> <range2>::
+	Compare the commits specified by the two ranges, where
+	`<range1>` is considered an older version of `<range2>`.
+
+<rev1>...<rev2>::
+	Equivalent to passing `<rev2>..<rev1>` and `<rev1>..<rev2>`.
+
+<base> <rev1> <rev2>::
+	Equivalent to passing `<base>..<rev1>` and `<base>..<rev2>`.
+	Note that `<base>` does not need to be the exact branch point
+	of the branches. Example: after rebasing a branch `my-topic`,
+	`git range-diff my-topic@{u} my-topic@{1} my-topic` would
+	show the differences introduced by the rebase.
+
+`git range-diff` also accepts the regular diff options (see
+linkgit:git-diff[1]), most notably the `--color=[<when>]` and
+`--no-color` options. These options are used when generating the "diff
+between patches", i.e. to compare the author, commit message and diff of
+corresponding old/new commits. There is currently no means to tweak the
+diff options passed to `git log` when generating those patches.
+
+
+CONFIGURATION
+-------------
+This command uses the `diff.color.*` and `pager.range-diff` settings
+(the latter is on by default).
+See linkgit:git-config[1].
+
+
+EXAMPLES
+--------
+
+When a rebase required merge conflicts to be resolved, compare the changes
+introduced by the rebase directly afterwards using:
+
+------------
+$ git range-diff @{u} @{1} @
+------------
+
+
+A typical output of `git range-diff` would look like this:
+
+------------
+-:  ------- > 1:  0ddba11 Prepare for the inevitable!
+1:  c0debee = 2:  cab005e Add a helpful message at the start
+2:  f00dbal ! 3:  decafe1 Describe a bug
+    @@ -1,3 +1,3 @@
+     Author: A U Thor <author@example.com>
+
+    -TODO: Describe a bug
+    +Describe a bug
+    @@ -324,5 +324,6
+      This is expected.
+
+    -+What is unexpected is that it will also crash.
+    ++Unexpectedly, it also crashes. This is a bug, and the jury is
+    ++still out there how to fix it best. See ticket #314 for details.
+
+      Contact
+3:  bedead < -:  ------- TO-UNDO
+------------
+
+In this example, there are 3 old and 3 new commits, where the developer
+removed the 3rd, added a new one before the first two, and modified the
+commit message of the 2nd commit as well its diff.
+
+When the output goes to a terminal, it is color-coded by default, just
+like regular `git diff`'s output. In addition, the first line (adding a
+commit) is green, the last line (deleting a commit) is red, the second
+line (with a perfect match) is yellow like the commit header of `git
+show`'s output, and the third line colors the old commit red, the new
+one green and the rest like `git show`'s commit header.
+
+The color-coded diff is actually a bit hard to read, though, as it
+colors the entire lines red or green. The line that added "What is
+unexpected" in the old commit, for example, is completely red, even if
+the intent of the old commit was to add something.
+
+To help with that, use the `--dual-color` mode. In this mode, the diff
+of diffs will retain the original diff colors, and prefix the lines with
+-/+ markers that have their *background* red or green, to make it more
+obvious that they describe how the diff itself changed.
+
+
+Algorithm
+---------
+
+The general idea is this: we generate a cost matrix between the commits
+in both commit ranges, then solve the least-cost assignment.
+
+The cost matrix is populated thusly: for each pair of commits, both
+diffs are generated and the "diff of diffs" is generated, with 3 context
+lines, then the number of lines in that diff is used as cost.
+
+To avoid false positives (e.g. when a patch has been removed, and an
+unrelated patch has been added between two iterations of the same patch
+series), the cost matrix is extended to allow for that, by adding
+fixed-cost entries for wholesale deletes/adds.
+
+Example: Let commits `1--2` be the first iteration of a patch series and
+`A--C` the second iteration. Let's assume that `A` is a cherry-pick of
+`2,` and `C` is a cherry-pick of `1` but with a small modification (say,
+a fixed typo). Visualize the commits as a bipartite graph:
+
+------------
+    1            A
+
+    2            B
+
+		 C
+------------
+
+We are looking for a "best" explanation of the new series in terms of
+the old one. We can represent an "explanation" as an edge in the graph:
+
+
+------------
+    1            A
+	       /
+    2 --------'  B
+
+		 C
+------------
+
+This explanation comes for "free" because there was no change. Similarly
+`C` could be explained using `1`, but that comes at some cost c>0
+because of the modification:
+
+------------
+    1 ----.      A
+	  |    /
+    2 ----+---'  B
+	  |
+	  `----- C
+	  c>0
+------------
+
+In mathematical terms, what we are looking for is some sort of a minimum
+cost bipartite matching; `1` is matched to `C` at some cost, etc. The
+underlying graph is in fact a complete bipartite graph; the cost we
+associate with every edge is the size of the diff between the two
+commits' patches. To explain also new commits, we introduce dummy nodes
+on both sides:
+
+------------
+    1 ----.      A
+	  |    /
+    2 ----+---'  B
+	  |
+    o     `----- C
+	  c>0
+    o            o
+
+    o            o
+------------
+
+The cost of an edge `o--C` is the size of `C`'s diff, modified by a
+fudge factor that should be smaller than 100%. The cost of an edge
+`o--o` is free. The fudge factor is necessary because even if `1` and
+`C` have nothing in common, they may still share a few empty lines and
+such, possibly making the assignment `1--C`, `o--o` slightly cheaper
+than `1--o`, `o--C` even if `1` and `C` have nothing in common. With the
+fudge factor we require a much larger common part to consider patches as
+corresponding.
+
+The overall time needed to compute this algorithm is the time needed to
+compute n+m commit diffs and then n*m diffs of patches, plus the time
+needed to compute the least-cost assigment between n and m diffs. Git
+uses an implementation of the Jonker-Volgenant algorithm to solve the
+assignment problem, which has cubic runtime complexity. The matching
+found in this case will look like this:
+
+------------
+    1 ----.      A
+	  |    /
+    2 ----+---'  B
+       .--+-----'
+    o -'  `----- C
+	  c>0
+    o ---------- o
+
+    o ---------- o
+------------
+
+
+SEE ALSO
+--------
+linkgit:git-log[1]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
gitgitgadget

