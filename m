From: "Mike Coleman" <tutufan@gmail.com>
Subject: [PATCH] fix some doc typos and grammar
Date: Fri, 2 Feb 2007 00:25:30 -0600
Message-ID: <3c6c07c20702012225v19b7aa66vc98a028f700914db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 02 07:25:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCrrd-0004KZ-6k
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 07:25:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423134AbXBBGZc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 01:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423135AbXBBGZc
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 01:25:32 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:38210 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423134AbXBBGZc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 01:25:32 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1156929nfa
        for <git@vger.kernel.org>; Thu, 01 Feb 2007 22:25:30 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=XU+HLJDZK/RI/ox/S3f+IpjynhwufVUKz0uBBQ/3kGj9N29ti/DyfV+5/vn7pK214jj186+YbUoo8etzfpQ7PSYXqKy6xhJwAO+0RRt5J9DDnpBd1XKVLCqzWfq/2Oun3FfetorQJlwL1rs6W5Ka2IU2Bn4cH2JrgQzVy5Ju0Mg=
Received: by 10.49.94.18 with SMTP id w18mr174546nfl.1170397530334;
        Thu, 01 Feb 2007 22:25:30 -0800 (PST)
Received: by 10.48.246.15 with HTTP; Thu, 1 Feb 2007 22:25:30 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38462>

[This is my first patch, which I'm trying via cut-and-paste into
gmail, which I realize sucks.  Any ideas for a better way?  Is anyone
sending patches via gmail+pop?  I gave up my previous shell/email
provider because they just weren't keeping the spam down.  Any
suggestions for something that works?  --Mike]

suggest user manual mention .gitignore

Signed-off-by: Michael Coleman <tutufan@gmail.com>
---
 Documentation/core-tutorial.txt |    6 +++---
 Documentation/user-manual.txt   |    8 +++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/core-tutorial.txt b/Documentation/core-tutorial.txt
index 86a9c75..1cd834b 100644
--- a/Documentation/core-tutorial.txt
+++ b/Documentation/core-tutorial.txt
@@ -624,7 +624,7 @@ name for the state at that point.
 Copying repositories
 --------------------

-git repositories are normally totally self-sufficient and relocatable
+git repositories are normally totally self-sufficient and relocatable.
 Unlike CVS, for example, there is no separate notion of
 "repository" and "working tree". A git repository normally *is* the
 working tree, with the local git information hidden in the `.git`
@@ -1118,7 +1118,7 @@ You could do without using any branches at all, by
 keeping as many local repositories as you would like to have
 branches, and merging between them with `git pull`, just like
 you merge between branches. The advantage of this approach is
-that it lets you keep set of files for each `branch` checked
+that it lets you keep a set of files for each `branch` checked
 out and you may find it easier to switch back and forth if you
 juggle multiple lines of development simultaneously. Of
 course, you will pay the price of more disk usage to hold
@@ -1300,7 +1300,7 @@ differences since stage 2 (i.e. your version).
 Publishing your work
 --------------------

-So we can use somebody else's work from a remote repository; but
+So, we can use somebody else's work from a remote repository, but
 how can *you* prepare a repository to let other people pull from
 it?

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index b6916d1..6576625 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -398,7 +398,7 @@ branch name, but this longer name can also be useful.  Most
 importantly, it is a globally unique name for this commit: so if you
 tell somebody else the object name (for example in email), then you are
 guaranteed that name will refer to the same commit in their repository
-that you it does in yours (assuming their repository has that commit at
+that it does in yours (assuming their repository has that commit at
 all).

 Understanding history: commits, parents, and reachability
@@ -617,7 +617,7 @@ the relationships between these snapshots.
 Git provides extremely flexible and fast tools for exploring the
 history of a project.

-We start with one specialized tool which is useful for finding the
+We start with one specialized tool that is useful for finding the
 commit that introduced a bug into a project.

 How to use bisect to find a regression
@@ -1492,7 +1492,7 @@ dangling commit 13472b7c4b80851a1bc551779171dcb03655e9b5
 ...
 -------------------------------------------------

-and watch for output that mentions "dangling commits".  You can examine
+You can examine
 one of those dangling commits with, for example,

 ------------------------------------------------
@@ -2923,6 +2923,8 @@ Think about how to create a clear chapter
dependency graph that will
 allow people to get to important topics without necessarily reading
 everything in between.

+Say something about .gitignore.
+
 Scan Documentation/ for other stuff left out; in particular:
 	howto's
 	some of technical/?
-- 
1.5.0.rc3
