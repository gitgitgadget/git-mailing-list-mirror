Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D2421F462
	for <e@80x24.org>; Tue, 28 May 2019 23:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfE1XQQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 19:16:16 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:40716 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfE1XQQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 19:16:16 -0400
Received: from localhost.localdomain ([78.148.161.28])
        by smtp.talktalk.net with SMTP
        id VlKGhobj8gI7iVlKGhG094; Wed, 29 May 2019 00:16:13 +0100
X-Originating-IP: [78.148.161.28]
X-Spam: 0
X-OAuthority: v=2.3 cv=KYisTjQD c=1 sm=1 tr=0 a=ujKALdKAi7z8notBBWqKeA==:117
 a=ujKALdKAi7z8notBBWqKeA==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=xtxXYLxNAAAA:8 a=5rxgeBVgAAAA:8
 a=VwQbUJbxAAAA:8 a=ybZZDoGAAAAA:8 a=C1IWinBY3BfSAIsW6DsA:9
 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=Q3fd-xBHxKW7qr5Y:21 a=Z-3k34dXCFGoDqgf:21
 a=QEXdDO2ut3YA:10 a=4VQP6C9YnVEA:10 a=xts0dhWdiJbonKbuqhAr:22
 a=PwKx63F5tFurRwaNxrlG:22 a=AjGcO6oz07-iQ99wixmX:22 a=0RhZnL1DYvcuLYC8JZ5M:22
From:   Philip Oakley <philipoakley@iee.org>
To:     GitList <git@vger.kernel.org>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [RFC/PATCH v2] doc branch: provide examples for listing remote tracking branches
Date:   Wed, 29 May 2019 00:16:05 +0100
Message-Id: <20190528231605.10108-1-philipoakley@iee.org>
X-Mailer: git-send-email 2.22.0.rc1.windows.1.33.gc7da05f206
In-Reply-To: <2ea35ad4-4b33-0ece-4de4-b2e92a100d9a@iee.org>
References: <2ea35ad4-4b33-0ece-4de4-b2e92a100d9a@iee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfLrTAICn0wPH09AuvqVADRBrH0w5J2Y6Rte7IDelDgO1lG+ieeZSjdQbU7S2thYaDrTmEdEP0pX2qahPWvu0u86ztSym9Nu9BvtPDlLYoI6M13dsmuvz
 j8f6QGRdg3Wxs36w2n7WR8/yzUSg4GBBJsr3x6tU+d4a+qy6M3973wIU7ZeHnv6NcUMvTy7DP/PjA/WRuJLiVos1npKFrjUe1QiM5PbctHm/NTCzY6Wilg2c
 vjBhiaF8Gc6ktgcugp/10rJg5d3D1mt2r+tez3wk2dk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The availability of these pattern selections is not obvious from
the man pages, as per mail thread <87lfz3vcbt.fsf@evledraar.gmail.com>.

Provide examples.

Re-order the `git branch` synopsis to emphasise the `--list <pattern>`
pairing. Also expand and reposition the `all/remotes` options.

Split the over-long description into three parts so that the <pattern>
description can be seen.

Clarify that the `all/remotes` options require the --list if patterns
are to be used.

Add examples of listing remote tracking branches that match a pattern,
including `git for-each-ref` which has more options.

Improve the -a/-r warning message. The message confused this author
as the combined -a and -r options had not been given, though a pattern
had. Specifically guide the user that maybe they needed the --list
option to enable a remote branch pattern selection.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---

in response to 
<2ea35ad4-4b33-0ece-4de4-b2e92a100d9a@iee.org>
thread: https://public-inbox.org/git/?q=%3CCACsJy8CwY8gzeWa9kNRX3ecez1JGiQiaOknbAoU7S%2BhiXBoUGQ%40mail.gmail.com%3E

to: Git Mailing List <git@vger.kernel.org>
cc: Duy Nguyen <pclouds@gmail.com>
cc: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
cc: Junio C Hamano <gitster@pobox.com>


 Documentation/git-branch.txt | 32 ++++++++++++++++++++++++++------
 builtin/branch.c             |  3 ++-
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 3bd83a7cbd..c57f6a15c6 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -8,12 +8,14 @@ git-branch - List, create, or delete branches
 SYNOPSIS
 --------
 [verse]
-'git branch' [--color[=<when>] | --no-color] [-r | -a]
-	[--list] [-v [--abbrev=<length> | --no-abbrev]]
+'git branch' [--color[=<when>] | --no-color]
+	[-v [--abbrev=<length> | --no-abbrev]]
 	[--column[=<options>] | --no-column] [--sort=<key>]
 	[(--merged | --no-merged) [<commit>]]
 	[--contains [<commit]] [--no-contains [<commit>]]
-	[--points-at <object>] [--format=<format>] [<pattern>...]
+	[--points-at <object>] [--format=<format>]
+	[(-r | --remotes) | (-a | --all)]
+	[--list] [<pattern>...]
 'git branch' [--track | --no-track] [-f] <branchname> [<start-point>]
 'git branch' (--set-upstream-to=<upstream> | -u <upstream>) [<branchname>]
 'git branch' --unset-upstream [<branchname>]
@@ -28,11 +30,15 @@ DESCRIPTION
 If `--list` is given, or if there are no non-option arguments, existing
 branches are listed; the current branch will be highlighted with an
 asterisk.  Option `-r` causes the remote-tracking branches to be listed,
-and option `-a` shows both local and remote branches. If a `<pattern>`
+and option `-a` shows both local and remote branches.
+
+If a `<pattern>`
 is given, it is used as a shell wildcard to restrict the output to
 matching branches. If multiple patterns are given, a branch is shown if
-it matches any of the patterns.  Note that when providing a
-`<pattern>`, you must use `--list`; otherwise the command is interpreted
+it matches any of the patterns.
+
+Note that when providing a
+`<pattern>`, you must use `--list`; otherwise the command may be interpreted
 as branch creation.
 
 With `--contains`, shows only the branches that contain the named commit
@@ -149,10 +155,12 @@ This option is only applicable in non-verbose mode.
 -r::
 --remotes::
 	List or delete (if used with -d) the remote-tracking branches.
+	Combine with `--list` to match the optional pattern(s).
 
 -a::
 --all::
 	List both remote-tracking branches and local branches.
+	Combine with `--list` to match optional pattern(s).
 
 -l::
 --list::
@@ -314,6 +322,18 @@ $ git branch -D test                                    <2>
 <2> Delete the "test" branch even if the "master" branch (or whichever branch
     is currently checked out) does not have all commits from the test branch.
 
+Listing branches from a specific remote::
++
+------------
+$ git branch -r -l '<remote>/<pattern>'                 <1>
+$ git for-each-ref 'refs/remotes/<remote>/<pattern>'    <2>
+------------
++
+<1> Using `-a` would conflate <remote> with any local branches you happen to
+    have been prefixed with the same <remote> pattern.
+<2> `for-each-ref` can take a wide range of options. See linkgit:git-for-each-ref[1]
+
+Patterns will normally need quoting.
 
 NOTES
 -----
diff --git a/builtin/branch.c b/builtin/branch.c
index 1be727209b..30906d4526 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -810,7 +810,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		strbuf_release(&buf);
 	} else if (argc > 0 && argc <= 2) {
 		if (filter.kind != FILTER_REFS_BRANCHES)
-			die(_("-a and -r options to 'git branch' do not make sense with a branch name"));
+			die(_("The -a, and -r, options to 'git branch' do not take a branch name.\n"
+				  "Did you mean to use: -a|-r --list <pattern>?"));
 
 		if (track == BRANCH_TRACK_OVERRIDE)
 			die(_("the '--set-upstream' option is no longer supported. Please use '--track' or '--set-upstream-to' instead."));
-- 
2.22.0.rc1.windows.1.33.gc7da05f206

