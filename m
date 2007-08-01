From: Steve Hoelzer <shoelzer@gmail.com>
Subject: [PATCH] Try to be consistent with capitalization in the documentation
Date: Wed, 1 Aug 2007 10:43:06 -0500
Message-ID: <514D28CB-25F8-49B2-921E-8EFA60BE864C@gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 01 17:42:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGGLG-0002fm-BR
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 17:42:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758689AbXHAPls (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 11:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758076AbXHAPls
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 11:41:48 -0400
Received: from wx-out-0506.google.com ([66.249.82.231]:60652 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758689AbXHAPlq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 11:41:46 -0400
Received: by wx-out-0506.google.com with SMTP id h31so207577wxd
        for <git@vger.kernel.org>; Wed, 01 Aug 2007 08:41:46 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer;
        b=W8kHUgMdFq+89Gcv6o/6xsR6mtJSlZFjCqx46dkCOqX2eitxwKPQ9EjK7A+kAUnOI/MBUhWx9q6vvILJvJ3EuGRiVtwId7hYRdQZNV1pnX+CwNiu5Begbhcsxo+Ko3V9Ls11md/wXC4bhUrLS+Ocf80mgcFc+nnK3BNg6LPnYR4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer;
        b=M36R9BhJlg8DsYAikRMzfhg2PzJZDzBdIAwbZEpgtHZ/3rbaRwxDG+3FaQeJqr+dUrYv42iw7ff2vntv1JO5rO2VImhJDZv/dcYE6PQaJqQdOcSd8xy2zk8qA9KLRSQ9ZF7FAzT8pYFY2ezyW80FSYGImEjBNGL1paD7ovH+o4Q=
Received: by 10.70.122.11 with SMTP id u11mr1463999wxc.1185982905078;
        Wed, 01 Aug 2007 08:41:45 -0700 (PDT)
Received: from ?192.168.0.200? ( [67.162.25.86])
        by mx.google.com with ESMTPS id h20sm1446684wxd.2007.08.01.08.41.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 01 Aug 2007 08:41:44 -0700 (PDT)
X-Mailer: Apple Mail (2.752.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54444>

Signed-off-by: Steve Hoelzer <shoelzer@gmail.com>
---

Try to be consistent with capitalization in the documentation.

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index bc6aa88..198ab47 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -134,8 +134,8 @@ $ git branch -d -r origin/todo origin/html origin/ 
man   <1>
$ git branch -D test                                    <2>
------------
+
-<1> delete remote-tracking branches "todo", "html", "man"
-<2> delete "test" branch even if the "master" branch does not have all
+<1> Delete remote-tracking branches "todo", "html", "man".
+<2> Delete "test" branch even if the "master" branch does not have all
commits from test branch.
diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index b1f5e7f..b36e705 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -76,10 +76,10 @@ $ git diff --cached   <2>
$ git diff HEAD       <3>
------------
+
-<1> changes in the working tree not yet staged for the next commit.
-<2> changes between the index and your last commit; what you
+<1> Changes in the working tree not yet staged for the next commit.
+<2> Changes between the index and your last commit; what you
would be committing if you run "git commit" without "-a" option.
-<3> changes in the working tree since your last commit; what you
+<3> Changes in the working tree since your last commit; what you
would be committing if you run "git commit -a"
Comparing with arbitrary commits::
@@ -90,12 +90,12 @@ $ git diff HEAD -- ./test  <2>
$ git diff HEAD^ HEAD      <3>
------------
+
-<1> instead of using the tip of the current branch, compare with the
+<1> Instead of using the tip of the current branch, compare with the
tip of "test" branch.
-<2> instead of comparing with the tip of "test" branch, compare with
+<2> Instead of comparing with the tip of "test" branch, compare with
the tip of the current branch, but limit the comparison to the
file "test".
-<3> compare the version before the last commit and the last commit.
+<3> Compare the version before the last commit and the last commit.
Limiting the diff output::
@@ -106,11 +106,11 @@ $ git diff --name-status                <2>
$ git diff arch/i386 include/asm-i386   <3>
------------
+
-<1> show only modification, rename and copy, but not addition
+<1> Show only modification, rename and copy, but not addition
nor deletion.
-<2> show only names and the nature of change, but not actual
+<2> Show only names and the nature of change, but not actual
diff output.
-<3> limit diff output to named subtrees.
+<3> Limit diff output to named subtrees.
Munging the diff output::
+
@@ -119,9 +119,9 @@ $ git diff --find-copies-harder -B -C  <1>
$ git diff -R                          <2>
------------
+
-<1> spend extra cycles to find renames, copies and complete
+<1> Spend extra cycles to find renames, copies and complete
rewrites (very expensive).
-<2> output diff in reverse.
+<2> Output diff in reverse.
Author
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 2c9db98..2e1b7b6 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -107,11 +107,11 @@ pull after you are done and ready.
When things cleanly merge, these things happen:
-1. the results are updated both in the index file and in your
-   working tree,
-2. index file is written out as a tree,
-3. the tree gets committed, and
-4. the `HEAD` pointer gets advanced.
+1. The results are updated both in the index file and in your
+   working tree.
+2. Index file is written out as a tree.
+3. The tree gets committed.
+4. The `HEAD` pointer gets advanced.
Because of 2., we require that the original state of the index
file to match exactly the current `HEAD` commit; otherwise we
diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 19c5b9b..15e3aca 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -63,7 +63,7 @@ $ git commit -a -c ORIG_HEAD  <3>
<1> This is most often done when you remembered what you
just committed is incomplete, or you misspelled your commit
message, or both.  Leaves working tree as it was before "reset".
-<2> make corrections to working tree files.
+<2> Make corrections to working tree files.
<3> "reset" copies the old head to .git/ORIG_HEAD; redo the
commit by starting with its log message.  If you do not need to
edit the message further, you can give -C option instead.
@@ -106,17 +106,17 @@ $ git reset                                <3>
$ git pull git://info.example.com/ nitfol  <4>
------------
+
-<1> you are happily working on something, and find the changes
+<1> You are happily working on something, and find the changes
in these files are in good order.  You do not want to see them
when you run "git diff", because you plan to work on other files
and changes with these files are distracting.
-<2> somebody asks you to pull, and the changes sounds worthy of  
merging.
-<3> however, you already dirtied the index (i.e. your index does
+<2> Somebody asks you to pull, and the changes sounds worthy of  
merging.
+<3> However, you already dirtied the index (i.e. your index does
not match the HEAD commit).  But you know the pull you are going
to make does not affect frotz.c nor filfre.c, so you revert the
index changes for these two files.  Your changes in working tree
remain there.
-<4> then you can pull and merge, leaving frotz.c and filfre.c
+<4> Then you can pull and merge, leaving frotz.c and filfre.c
changes still in the working tree.
Undo a merge or pull::
@@ -133,15 +133,15 @@ Fast forward
$ git reset --hard ORIG_HEAD       <4>
------------
+
-<1> try to update from the upstream resulted in a lot of
+<1> Try to update from the upstream resulted in a lot of
conflicts; you were not ready to spend a lot of time merging
right now, so you decide to do that later.
<2> "pull" has not made merge commit, so "git reset --hard"
which is a synonym for "git reset --hard HEAD" clears the mess
from the index file and the working tree.
-<3> merge a topic branch into the current branch, which resulted
+<3> Merge a topic branch into the current branch, which resulted
in a fast forward.
-<4> but you decided that the topic branch is not ready for public
+<4> But you decided that the topic branch is not ready for public
consumption yet.  "pull" or "merge" always leaves the original
tip of the current branch in ORIG_HEAD, so resetting hard to it
brings your index file and the working tree back to that state,
