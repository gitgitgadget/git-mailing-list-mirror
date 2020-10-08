Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F86C433DF
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 20:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 114A22222C
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 20:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730298AbgJHUYn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 16:24:43 -0400
Received: from smtp6-g21.free.fr ([212.27.42.6]:9400 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729474AbgJHUYm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 16:24:42 -0400
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:d1:f360:889b:81bb:28ab:56e7])
        by smtp6-g21.free.fr (Postfix) with ESMTP id A067778036C;
        Thu,  8 Oct 2020 22:24:08 +0200 (CEST)
From:   =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH 3/4] doc: git-remote fix ups
Date:   Thu,  8 Oct 2020 22:23:56 +0200
Message-Id: <20201008202357.15490-3-jn.avila@free.fr>
X-Mailer: git-send-email 2.28.0.rc0
In-Reply-To: <20201008202357.15490-1-jn.avila@free.fr>
References: <20201008202357.15490-1-jn.avila@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-remote.txt | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 9659abbf8e..ea73386c81 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git remote' [-v | --verbose]
-'git remote add' [-t <branch>] [-m <master>] [-f] [--[no-]tags] [--mirror=<fetch|push>] <name> <url>
+'git remote add' [-t <branch>] [-m <master>] [-f] [--[no-]tags] [--mirror=(fetch|push)] <name> <url>
 'git remote rename' <old> <new>
 'git remote remove' <name>
 'git remote set-head' <name> (-a | --auto | -d | --delete | <branch>)
@@ -35,7 +35,7 @@ OPTIONS
 -v::
 --verbose::
 	Be a little more verbose and show remote url after name.
-	NOTE: This must be placed between `remote` and `subcommand`.
+	NOTE: This must be placed between `remote` and subcommand.
 
 
 COMMANDS
@@ -46,7 +46,7 @@ subcommands are available to perform operations on the remotes.
 
 'add'::
 
-Adds a remote named <name> for the repository at
+Add a remote named <name> for the repository at
 <url>.  The command `git fetch <name>` can then be used to create and
 update remote-tracking branches <name>/<branch>.
 +
@@ -109,13 +109,13 @@ With `-d` or `--delete`, the symbolic ref `refs/remotes/<name>/HEAD` is deleted.
 +
 With `-a` or `--auto`, the remote is queried to determine its `HEAD`, then the
 symbolic-ref `refs/remotes/<name>/HEAD` is set to the same branch. e.g., if the remote
-`HEAD` is pointed at `next`, "`git remote set-head origin -a`" will set
+`HEAD` is pointed at `next`, `git remote set-head origin -a` will set
 the symbolic-ref `refs/remotes/origin/HEAD` to `refs/remotes/origin/next`. This will
 only work if `refs/remotes/origin/next` already exists; if not it must be
 fetched first.
 +
-Use `<branch>` to set the symbolic-ref `refs/remotes/<name>/HEAD` explicitly. e.g., "git
-remote set-head origin master" will set the symbolic-ref `refs/remotes/origin/HEAD` to
+Use `<branch>` to set the symbolic-ref `refs/remotes/<name>/HEAD` explicitly. e.g., `git
+remote set-head origin master` will set the symbolic-ref `refs/remotes/origin/HEAD` to
 `refs/remotes/origin/master`. This will only work if
 `refs/remotes/origin/master` already exists; if not it must be fetched first.
 +
@@ -127,7 +127,7 @@ This can be used to track a subset of the available remote branches
 after the initial setup for a remote.
 +
 The named branches will be interpreted as if specified with the
-`-t` option on the 'git remote add' command line.
+`-t` option on the `git remote add` command line.
 +
 With `--add`, instead of replacing the list of currently tracked
 branches, adds to that list.
@@ -181,16 +181,16 @@ fetch --prune <name>`, except that no new references will be fetched.
 See the PRUNING section of linkgit:git-fetch[1] for what it'll prune
 depending on various configuration.
 +
-With `--dry-run` option, report what branches will be pruned, but do not
+With `--dry-run` option, report what branches would be pruned, but do not
 actually prune them.
 
 'update'::
 
 Fetch updates for remotes or remote groups in the repository as defined by
-remotes.<group>.  If neither group nor remote is specified on the command line,
+`remotes.<group>`. If neither group nor remote is specified on the command line,
 the configuration parameter remotes.default will be used; if
 remotes.default is not defined, all remotes which do not have the
-configuration parameter remote.<name>.skipDefaultUpdate set to true will
+configuration parameter `remote.<name>.skipDefaultUpdate` set to true will
 be updated.  (See linkgit:git-config[1]).
 +
 With `--prune` option, run pruning against all the remotes that are updated.
-- 
2.28.0.rc0

