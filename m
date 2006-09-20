From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Fix trivial typos and inconsistencies in hooks documentation
Date: Wed, 20 Sep 2006 12:15:39 +0200
Message-ID: <20060920101539.GA26173@diku.dk>
References: <200609200739.48732.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 12:16:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPz7N-00031B-Sy
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 12:15:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbWITKPq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 06:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbWITKPq
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 06:15:46 -0400
Received: from [130.225.96.91] ([130.225.96.91]:10122 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1750989AbWITKPp (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Sep 2006 06:15:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id C2BCA7700AA;
	Wed, 20 Sep 2006 12:15:41 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 18880-08; Wed, 20 Sep 2006 12:15:40 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 2A9D477009E;
	Wed, 20 Sep 2006 12:15:40 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 251A06DFD1E; Wed, 20 Sep 2006 12:13:49 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 0E90062A34; Wed, 20 Sep 2006 12:15:40 +0200 (CEST)
To: Alan Chandler <alan@chandlerfamily.org.uk>
Content-Disposition: inline
In-Reply-To: <200609200739.48732.alan@chandlerfamily.org.uk>
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27335>

Pointed out by Alan Chandler.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 Documentation/hooks.txt |   56 ++++++++++++++++++++++++-----------------------
 1 files changed, 28 insertions(+), 28 deletions(-)

Alan Chandler <alan@chandlerfamily.org.uk> wrote Wed, Sep 20, 2006:
> I don't have the source of git on my machine as I am just working from the 
> debian packages, so I don't have a patch.  However there is a trivial type on 
> the hooks.html documentation that I gues comes from the Documentation 
> directory
> 
> The first sentence for both "update" and "post-update" hooks has an 
> extra "is", marked in capitals below
> 
> "This hook is invoked by git-receive-pack on the remote repository, which IS 
> happens when a git push is done on a local repository."

I fixed those and a few AsciiDoc markup problems, and tried to generally
make it more consistent in its markup.

diff --git a/Documentation/hooks.txt b/Documentation/hooks.txt
index 898b4aa..517f49b 100644
--- a/Documentation/hooks.txt
+++ b/Documentation/hooks.txt
@@ -5,8 +5,7 @@ Hooks are little scripts you can place i
 directory to trigger action at certain points.  When
 `git-init-db` is run, a handful example hooks are copied in the
 `hooks` directory of the new repository, but by default they are
-all disabled.  To enable a hook, make it executable with `chmod
-+x`.
+all disabled.  To enable a hook, make it executable with `chmod +x`.
 
 This document describes the currently defined hooks.
 
@@ -16,16 +15,16 @@ applypatch-msg
 This hook is invoked by `git-applypatch` script, which is
 typically invoked by `git-applymbox`.  It takes a single
 parameter, the name of the file that holds the proposed commit
-log message.  Exiting with non-zero status causes the
-'git-applypatch' to abort before applying the patch.
+log message.  Exiting with non-zero status causes
+`git-applypatch` to abort before applying the patch.
 
 The hook is allowed to edit the message file in place, and can
 be used to normalize the message into some project standard
 format (if the project has one). It can also be used to refuse
 the commit after inspecting the message file.
 
-The default applypatch-msg hook, when enabled, runs the
-commit-msg hook, if the latter is enabled.
+The default 'applypatch-msg' hook, when enabled, runs the
+'commit-msg' hook, if the latter is enabled.
 
 pre-applypatch
 --------------
@@ -39,8 +38,8 @@ after application of the patch not commi
 It can be used to inspect the current working tree and refuse to
 make a commit if it does not pass certain test.
 
-The default pre-applypatch hook, when enabled, runs the
-pre-commit hook, if the latter is enabled.
+The default 'pre-applypatch' hook, when enabled, runs the
+'pre-commit' hook, if the latter is enabled.
 
 post-applypatch
 ---------------
@@ -61,9 +60,9 @@ invoked before obtaining the proposed co
 making a commit.  Exiting with non-zero status from this script
 causes the `git-commit` to abort.
 
-The default pre-commit hook, when enabled, catches introduction
+The default 'pre-commit' hook, when enabled, catches introduction
 of lines with trailing whitespaces and aborts the commit when
-a such line is found.
+such a line is found.
 
 commit-msg
 ----------
@@ -79,8 +78,8 @@ be used to normalize the message into so
 format (if the project has one). It can also be used to refuse
 the commit after inspecting the message file.
 
-The default commit-msg hook, when enabled, detects duplicate
-Signed-off-by: lines, and aborts the commit when one is found.
+The default 'commit-msg' hook, when enabled, detects duplicate
+"Signed-off-by" lines, and aborts the commit if one is found.
 
 post-commit
 -----------
@@ -91,23 +90,24 @@ parameter, and is invoked after a commit
 This hook is meant primarily for notification, and cannot affect
 the outcome of `git-commit`.
 
-The default post-commit hook, when enabled, demonstrates how to
+The default 'post-commit' hook, when enabled, demonstrates how to
 send out a commit notification e-mail.
 
 update
 ------
 
 This hook is invoked by `git-receive-pack` on the remote repository,
-which is happens when a `git push` is done on a local repository.
+which happens when a `git push` is done on a local repository.
 Just before updating the ref on the remote repository, the update hook
 is invoked.  Its exit status determines the success or failure of
 the ref update.
 
 The hook executes once for each ref to be updated, and takes
 three parameters:
-    - the name of the ref being updated,
-    - the old object name stored in the ref,
-    - and the new objectname to be stored in the ref.
+
+ - the name of the ref being updated,
+ - the old object name stored in the ref,
+ - and the new objectname to be stored in the ref.
 
 A zero exit from the update hook allows the ref to be updated.
 Exiting with a non-zero status prevents `git-receive-pack`
@@ -126,16 +126,16 @@ Another use suggested on the mailing lis
 implement access control which is finer grained than the one
 based on filesystem group.
 
-The standard output of this hook is sent to /dev/null; if you
-want to report something to the git-send-pack on the other end,
-you can redirect your output to your stderr.
+The standard output of this hook is sent to `/dev/null`; if you
+want to report something to the `git-send-pack` on the other end,
+you can redirect your output to your `stderr`.
 
 
 post-update
 -----------
 
 This hook is invoked by `git-receive-pack` on the remote repository,
-which is happens when a `git push` is done on a local repository.
+which happens when a `git push` is done on a local repository.
 It executes on the remote repository once after all the refs have
 been updated.
 
@@ -145,16 +145,16 @@ name of ref that was actually updated.
 This hook is meant primarily for notification, and cannot affect
 the outcome of `git-receive-pack`.
 
-The post-update hook can tell what are the heads that were pushed,
+The 'post-update' hook can tell what are the heads that were pushed,
 but it does not know what their original and updated values are,
 so it is a poor place to do log old..new.
 
-The default post-update hook, when enabled, runs
+When enabled, the default 'post-update' hook runs
 `git-update-server-info` to keep the information used by dumb
-transports (e.g., http) up-to-date.  If you are publishing
-a git repository that is accessible via http, you should
+transports (e.g., HTTP) up-to-date.  If you are publishing
+a git repository that is accessible via HTTP, you should
 probably enable this hook.
 
-The standard output of this hook is sent to /dev/null; if you
-want to report something to the git-send-pack on the other end,
-you can redirect your output to your stderr.
+The standard output of this hook is sent to `/dev/null`; if you
+want to report something to the `git-send-pack` on the other end,
+you can redirect your output to your `stderr`.
-- 
1.4.2.1.gca4e

-- 
Jonas Fonseca
