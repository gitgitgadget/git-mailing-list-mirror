Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA2ED1F404
	for <e@80x24.org>; Sun, 18 Mar 2018 23:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754425AbeCRXtQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Mar 2018 19:49:16 -0400
Received: from mail.netzguerilla.net ([217.11.57.120]:40787 "EHLO
        mail.netzguerilla.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754155AbeCRXtP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Mar 2018 19:49:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.netzguerilla.net (Postfix) with ESMTP id C0027100018
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 00:49:13 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netzguerilla.net
Received: from mail.netzguerilla.net ([IPv6:2a00:1828:2000:612::25])
        by localhost (sal.netzguerilla.net [IPv6:::1]) (amavisd-new, port 10024)
        with ESMTP id 6pbEIRHJa2G5 for <git@vger.kernel.org>;
        Mon, 19 Mar 2018 00:49:12 +0100 (CET)
Received: from [IPv6:2003:dd:ff29:a301:c880:36a1:dffe:f121] (p200300DDFF29A301C88036A1DFFEF121.dip0.t-ipconnect.de [IPv6:2003:dd:ff29:a301:c880:36a1:dffe:f121])
        by mail.netzguerilla.net (Postfix) with ESMTPSA id 1581C100013
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 00:49:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=projektwerkstatt.de;
        s=fckp; t=1521416952;
        bh=kzTdy62HHDkm8EJiPGtkGVx4yUyBUQMVTlPjj7MdJ50=;
        h=From:Subject:To:References:Date:In-Reply-To:From;
        b=YLVdBuwhGa/s37O/8ay3XF/NRIkw9x5aa3RHHRU4ep/QIJcBwvZHG0fbqtTQE1vo9
         NxRpFny7ATo8JcN0Ms1uK+YGiVFIlD2aZ63WOdQ69+m80EnGnr6PrKj3tAIm+CMfco
         DThBc6sS69VU0Ff2p0/9b2mUalFMBO7ui0vp1g9BN7hIyiiXBVudqrmVulpXBvCh49
         pOwfRDt1BWpWkme5P4Z/H/xtCRKaBjSQZUkW/0y0qRB/cGAAm/E5lud7J/E3b1V/7c
         /EdiUkwJErpGRTG3iSzTByBXEi7VZmbrwr2E4lVYNeGjY6E0WQEFItYCpULKN/ZxtB
         NC+kmp9Icg5BA==
From:   kalle <kalle@projektwerkstatt.de>
Subject: Fwd: user-manual: patch proposals and questions
To:     git@vger.kernel.org
References: <3166da20-14f8-50bf-3913-03b18673203d@projektwerkstatt.de>
Message-ID: <16afd6f7-110f-18c0-f7f4-9cadf0b69db9@projektwerkstatt.de>
Date:   Mon, 19 Mar 2018 00:49:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <3166da20-14f8-50bf-3913-03b18673203d@projektwerkstatt.de>
Content-Type: multipart/mixed;
 boundary="------------9D32A6589AE877F06A20288A"
Content-Language: de-DE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------9D32A6589AE877F06A20288A
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit


hello,

1.I wonder, why the "user-manual" is so hidden on the (official?) site
git-scm.com [it is accessible at git-scm.com/docs/user-manual ,but is
not viewable in /docs ]

2.I did not receive an answer to my mail. Maybe it could have to do with
a possible stopped maintainment of the 'user-manual'

3.it would be for non-graphics-users to have the Git-Pro-book in
text-format.

thanks,
kalle

-------- Weitergeleitete Nachricht --------
Betreff: user-manual: patch proposals and questions
Datum: Tue, 6 Mar 2018 00:08:55 +0100
Von: kalle <kalle@projektwerkstatt.de>
An: git@vger.kernel.org

The patches are attached.
Further some questions:

-see the explanations of the branch command, ca. line 280: wouldn't it
be better to use other words than 'references'?
-sentence "it shows all commits reachable from the parent commit": it
seems wrong to me. The last commit is also shown.
- chapter "Browsing revisions": it seems counterintuitive to me to have
two different logics for the meaning of "branch1..branch2" and
"branch1...branch2", according to whether it's the argument of `git log'
or `git diff'
-section "Check whether two branches point at the same history": 'git
diff origin..master' -> shouldn't it be rather 'git diff
branch1..branch2'? … or rewrite the example with branch1=origin and
branch2=master.

greetings,
kalle



--------------9D32A6589AE877F06A20288A
Content-Type: text/x-patch;
 name="0002-3-small-formulation-changes-in-Documentation-user-ma.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0002-3-small-formulation-changes-in-Documentation-user-ma.pa";
 filename*1="tch"

From 19061a0dd4363edbf8757a5e9eee8ace210f4029 Mon Sep 17 00:00:00 2001
From: kalledaballe <kalle@projektwerkstatt.de>
Date: Fri, 9 Feb 2018 20:46:52 +0100
Subject: [PATCH 2/5] 3 small formulation changes in
 Documentation/user-manual.txt

---
 Documentation/user-manual.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index eff7890..e3efc26 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -322,7 +322,7 @@ do so (now or later) by using -b with the checkout command again. Example:
 HEAD is now at 427abfa Linux v2.6.17
 ------------------------------------------------
 
-The HEAD then refers to the SHA-1 of the commit instead of to a branch,
+If you haven't created a new branch yet, the HEAD then refers to the SHA-1 of the commit instead of to a branch,
 and git branch shows that you are no longer on a branch:
 
 ------------------------------------------------
@@ -370,7 +370,7 @@ be updated by `git fetch` (hence `git pull`) and `git push`. See
 <<Updating-a-repository-With-git-fetch>> for details.
 
 You might want to build on one of these remote-tracking branches
-on a branch of your own, just as you would for a tag:
+a branch of your own, just as you would for a tag:
 
 ------------------------------------------------
 $ git checkout -b my-todo-copy origin/todo
@@ -404,7 +404,7 @@ they may also be packed together in a single file; see
 linkgit:git-pack-refs[1]).
 
 As another useful shortcut, the "HEAD" of a repository can be referred
-to just using the name of that repository.  So, for example, "origin"
+to by just using the name of that repository.  So, for example, "origin"
 is usually a shortcut for the HEAD branch in the repository "origin".
 
 For the complete list of paths which Git checks for references, and
-- 
2.1.4




--------------9D32A6589AE877F06A20288A
Content-Type: text/x-patch;
 name="0003-I-changed-the-sequence-of-2-sentences.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0003-I-changed-the-sequence-of-2-sentences.patch"

From 3917eeaf8d21b8b90a773c46ee5b9d12eac901e3 Mon Sep 17 00:00:00 2001
From: kalledaballe <kalle@projektwerkstatt.de>
Date: Sat, 10 Feb 2018 16:08:45 +0100
Subject: [PATCH 3/5] I changed the sequence of 2 sentences.

---
 Documentation/user-manual.txt | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index e3efc26..b9dc17a 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -609,13 +609,9 @@ $ git show HEAD^2   # show the second parent of HEAD
 In addition to HEAD, there are several other special names for
 commits:
 
-Merges (to be discussed later), as well as operations such as
-`git reset`, which change the currently checked-out commit, generally
-set ORIG_HEAD to the value HEAD had before the current operation.
+ORIG_HEAD is set to the value HEAD before merging (to be discussed later) operations as well as operations such as `git reset'. which change the currently checked-out commit.
 
-The `git fetch` operation always stores the head of the last fetched
-branch in FETCH_HEAD.  For example, if you run `git fetch` without
-specifying a local branch as the target of the operation
+FETCH_HEAD after a `git fetch' operation stores the head of the last fetched branch. For example, if you run `git fetch' without specifying a local branch as the target of the operation.
 
 -------------------------------------------------
 $ git fetch git://example.com/proj.git theirbranch
@@ -664,7 +660,7 @@ can also make more specific requests:
 
 -------------------------------------------------
 $ git log v2.5..	# commits since (not reachable from) v2.5
-$ git log test..master	# commits reachable from master but not test
+$ git log ..master	# commits reachable from master but not from test
 $ git log master..test	# ...reachable from test but not master
 $ git log master...test	# ...reachable from either test or master,
 			#    but not both
-- 
2.1.4




--------------9D32A6589AE877F06A20288A
Content-Type: text/x-patch;
 name="0004-I-errouneously-have-deleted-one-word-too-much-in-the.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0004-I-errouneously-have-deleted-one-word-too-much-in-the.pa";
 filename*1="tch"

From a084b699ed7a0768530f9112ae8469fd5e297356 Mon Sep 17 00:00:00 2001
From: kalledaballe <kalle@projektwerkstatt.de>
Date: Sat, 10 Feb 2018 16:14:25 +0100
Subject: [PATCH 4/5] I errouneously have deleted one word too much in the last
 commit

---
 Documentation/user-manual.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index b9dc17a..5468163 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -660,7 +660,7 @@ can also make more specific requests:
 
 -------------------------------------------------
 $ git log v2.5..	# commits since (not reachable from) v2.5
-$ git log ..master	# commits reachable from master but not from test
+$ git log test..master	# commits reachable from master but not from test
 $ git log master..test	# ...reachable from test but not master
 $ git log master...test	# ...reachable from either test or master,
 			#    but not both
-- 
2.1.4




--------------9D32A6589AE877F06A20288A
Content-Type: text/x-patch;
 name="0005-small-error-fixed.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0005-small-error-fixed.patch"

From 23b13bd16e752fd2c69c1e8bd23c3c35e6c43503 Mon Sep 17 00:00:00 2001
From: kalledaballe <kalle@projektwerkstatt.de>
Date: Sat, 10 Feb 2018 16:29:39 +0100
Subject: [PATCH 5/5] small error fixed

---
 Documentation/user-manual.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 5468163..8143310 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -661,9 +661,9 @@ can also make more specific requests:
 -------------------------------------------------
 $ git log v2.5..	# commits since (not reachable from) v2.5
 $ git log test..master	# commits reachable from master but not from test
-$ git log master..test	# ...reachable from test but not master
+$ git log master..test	# ...reachable from test but not from master
 $ git log master...test	# ...reachable from either test or master,
-			#    but not both
+			#    but not from both
 $ git log --since="2 weeks ago" # commits from the last 2 weeks
 $ git log Makefile      # commits which modify Makefile
 $ git log fs/		# ... which modify any file under fs/
-- 
2.1.4




--------------9D32A6589AE877F06A20288A--
