From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v3 1/3] doc: modernise everyday.txt wording and format in man page style
Date: Mon, 29 Sep 2014 17:41:45 +0100
Message-ID: <1412008907-3988-2-git-send-email-philipoakley@iee.org>
References: <1412008907-3988-1-git-send-email-philipoakley@iee.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 29 18:42:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XYe12-00071J-RN
	for gcvg-git-2@plane.gmane.org; Mon, 29 Sep 2014 18:41:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754898AbaI2QlX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2014 12:41:23 -0400
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:24786 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754873AbaI2QlS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Sep 2014 12:41:18 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AuURAEOKKVROl3pTPGdsb2JhbABgEwEBgnkgM1eJL8A/IQqHSAQCAoERFwEBBQEBAQE4OYQEAQVWIxAIMQEXOQoDEQYKCRuIJwm/LxiPPAsFAgFPBxIBgiQPRIFBBYYoj3eELoQ9lWOBfDwvAQEBgQQBBxeBJAEBAQ
X-IPAS-Result: AuURAEOKKVROl3pTPGdsb2JhbABgEwEBgnkgM1eJL8A/IQqHSAQCAoERFwEBBQEBAQE4OYQEAQVWIxAIMQEXOQoDEQYKCRuIJwm/LxiPPAsFAgFPBxIBgiQPRIFBBYYoj3eELoQ9lWOBfDwvAQEBgQQBBxeBJAEBAQ
X-IronPort-AV: E=Sophos;i="5.04,620,1406588400"; 
   d="scan'208";a="1313654"
Received: from host-78-151-122-83.as13285.net (HELO localhost) ([78.151.122.83])
  by out1.ip02ir2.opaltelecom.net with ESMTP; 29 Sep 2014 17:41:14 +0100
X-Mailer: git-send-email 1.9.4.msysgit.0
In-Reply-To: <1412008907-3988-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257630>

Refresh the contents of everyday.txt contents to a more modern
command style. Also update the mark-up so that it can be formatted
as a man page with AsciiDoc ready for transfer to the Git guides.
The transfer is in subsequent commits.

Guidance on modernising the command style provided by Junio at [1],
[2] and [3].

[1] Individual Developer, both Standalone and Participant
http://article.gmane.org/gmane.comp.version-control.git/254269
[2] Integrator
http://article.gmane.org/gmane.comp.version-control.git/254502
[3] Administrator
http://article.gmane.org/gmane.comp.version-control.git/254824

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 Documentation/everyday.txt | 246 ++++++++++++++++++++++++++-------------------
 1 file changed, 140 insertions(+), 106 deletions(-)

diff --git a/Documentation/everyday.txt b/Documentation/everyday.txt
index b2548ef..cd7f87c 100644
--- a/Documentation/everyday.txt
+++ b/Documentation/everyday.txt
@@ -1,22 +1,37 @@
+giteveryday(7)
+===============
+
+NAME
+----
+giteveryday - A useful minimum set of commands for Everyday Git
+
+SYNOPSIS
+--------
+
 Everyday Git With 20 Commands Or So
-===================================
 
-<<Individual Developer (Standalone)>> commands are essential for
-anybody who makes a commit, even for somebody who works alone.
+DESCRIPTION
+-----------
+
+Git users can broadly be grouped into four categories for the purposes of
+describing here a small set of useful command for everyday Git.
+
+*	<<STANDALONE,Individual Developer (Standalone)>> commands are essential
+	for anybody who makes a commit, even for somebody who works alone.
 
-If you work with other people, you will need commands listed in
-the <<Individual Developer (Participant)>> section as well.
+*	If you work with other people, you will need commands listed in
+	the <<PARTICIPANT,Individual Developer (Participant)>> section as well.
 
-People who play the <<Integrator>> role need to learn some more
-commands in addition to the above.
+*	People who play the <<INTEGRATOR,Integrator>> role need to learn some
+	more commands in addition to the above.
 
-<<Repository Administration>> commands are for system
-administrators who are responsible for the care and feeding
-of Git repositories.
+*	<<ADMINISTRATION,Repository Administration>> commands are for system
+	administrators who are responsible for the care and feeding
+	of Git repositories.
 
 
-Individual Developer (Standalone)[[Individual Developer (Standalone)]]
-----------------------------------------------------------------------
+Individual Developer (Standalone)[[STANDALONE]]
+-----------------------------------------------
 
 A standalone individual developer does not exchange patches with
 other people, and works alone in a single repository, using the
@@ -24,8 +39,6 @@ following commands.
 
   * linkgit:git-init[1] to create a new repository.
 
-  * linkgit:git-show-branch[1] to see where you are.
-
   * linkgit:git-log[1] to see what happened.
 
   * linkgit:git-checkout[1] and linkgit:git-branch[1] to switch
@@ -45,7 +58,7 @@ following commands.
 
   * linkgit:git-rebase[1] to maintain topic branches.
 
-  * linkgit:git-tag[1] to mark known point.
+  * linkgit:git-tag[1] to mark a known point.
 
 Examples
 ~~~~~~~~
@@ -75,14 +88,12 @@ $ edit/compile/test
 $ git diff HEAD <4>
 $ git commit -a -s <5>
 $ edit/compile/test
-$ git reset --soft HEAD^ <6>
-$ edit/compile/test
-$ git diff ORIG_HEAD <7>
-$ git commit -a -c ORIG_HEAD <8>
-$ git checkout master <9>
-$ git merge alsa-audio <10>
-$ git log --since='3 days ago' <11>
-$ git log v2.43.. curses/ <12>
+$ git diff HEAD^ <6>
+$ git commit -a --amend <7>
+$ git checkout master <8>
+$ git merge alsa-audio <9>
+$ git log --since='3 days ago' <10>
+$ git log v2.43.. curses/ <11>
 ------------
 +
 <1> create a new topic branch.
@@ -90,22 +101,21 @@ $ git log v2.43.. curses/ <12>
 <3> you need to tell Git if you added a new file; removal and
 modification will be caught if you do `git commit -a` later.
 <4> to see what changes you are committing.
-<5> commit everything as you have tested, with your sign-off.
-<6> take the last commit back, keeping what is in the working tree.
-<7> look at the changes since the premature commit we took back.
-<8> redo the commit undone in the previous step, using the message
-you originally wrote.
-<9> switch to the master branch.
-<10> merge a topic branch into your master branch.
-<11> review commit logs; other forms to limit output can be
+<5> commit everything, as you have tested, with your sign-off.
+<6> look at all your changes including the previous commit.
+<7> amend the previous commit, adding all your new changes,
+using your original message.
+<8> switch to the master branch.
+<9> merge a topic branch into your master branch.
+<10> review commit logs; other forms to limit output can be
 combined and include `--max-count=10` (show 10 commits),
 `--until=2005-12-10`, etc.
-<12> view only the changes that touch what's in `curses/`
+<11> view only the changes that touch what's in `curses/`
 directory, since `v2.43` tag.
 
 
-Individual Developer (Participant)[[Individual Developer (Participant)]]
-------------------------------------------------------------------------
+Individual Developer (Participant)[[PARTICIPANT]]
+-------------------------------------------------
 
 A developer working as a participant in a group project needs to
 learn how to communicate with others, and uses these commands in
@@ -123,6 +133,10 @@ addition to the ones needed by a standalone developer.
   * linkgit:git-format-patch[1] to prepare e-mail submission, if
     you adopt Linux kernel-style public forum workflow.
 
+  * linkgit:git-send-email[1] to send your e-mail submission without
+    corruption by your MUA.
+
+
 Examples
 ~~~~~~~~
 
@@ -131,27 +145,34 @@ Clone the upstream and work on it.  Feed changes to upstream.::
 ------------
 $ git clone git://git.kernel.org/pub/scm/.../torvalds/linux-2.6 my2.6
 $ cd my2.6
-$ edit/compile/test; git commit -a -s <1>
-$ git format-patch origin <2>
-$ git pull <3>
-$ git log -p ORIG_HEAD.. arch/i386 include/asm-i386 <4>
-$ git pull git://git.kernel.org/pub/.../jgarzik/libata-dev.git ALL <5>
-$ git reset --hard ORIG_HEAD <6>
-$ git gc <7>
-$ git fetch --tags <8>
+$ git checkout -b mine master <1>
+$ edit/compile/test; git commit -a -s <2>
+$ git format-patch master <3>
+$ git send-email --to="person <email@example.com>" 00*.patch <4>
+$ git pull <5>
+$ git log -p ORIG_HEAD.. arch/i386 include/asm-i386 <6>
+$ git ls-remote --heads http://git.kernel.org/.../jgarzik/libata-dev.git <7>
+$ git pull git://git.kernel.org/pub/.../jgarzik/libata-dev.git ALL <8>
+$ git reset --hard ORIG_HEAD <9>
+$ git gc <10>
+$ git fetch --tags <11>
 ------------
 +
-<1> repeat as needed.
-<2> extract patches from your branch for e-mail submission.
-<3> `git pull` fetches from `origin` by default and merges into the
+<1> checkout a new branch 'mine' from master.
+<2> repeat as needed.
+<3> extract patches from your branch, relative to master,
+<4> and email them.
+<5> `git pull` fetches from `origin` by default and merges into the
 current branch.
-<4> immediately after pulling, look at the changes done upstream
+<6> immediately after pulling, look at the changes done upstream
 since last time we checked, only in the
 area we are interested in.
-<5> fetch from a specific branch from a specific repository and merge.
-<6> revert the pull.
-<7> garbage collect leftover objects from reverted pull.
-<8> from time to time, obtain official tags from the `origin`
+<7> check the branch names in an external repository (if not known).
+<8> fetch from a specific branch 'ALL' from a specific repository
+and merge it.
+<9> revert the pull.
+<10> garbage collect leftover objects from reverted pull.
+<11> from time to time, obtain official tags from the `origin`
 and store them under `.git/refs/tags/`.
 
 
@@ -166,7 +187,7 @@ remote.origin.fetch refs/heads/*:refs/remotes/origin/*
 branch.master.remote origin
 branch.master.merge refs/heads/master
 satellite$ git config remote.origin.push \
-           master:refs/remotes/satellite/master <3>
+           +refs/heads/*:refs/remotes/satellite/* <3>
 satellite$ edit/compile/test/commit
 satellite$ git push origin <4>
 
@@ -181,10 +202,10 @@ machine.
 <2> clone sets these configuration variables by default.
 It arranges `git pull` to fetch and store the branches of mothership
 machine to local `remotes/origin/*` remote-tracking branches.
-<3> arrange `git push` to push local `master` branch to
-`remotes/satellite/master` branch of the mothership machine.
-<4> push will stash our work away on `remotes/satellite/master`
-remote-tracking branch on the mothership machine.  You could use this
+<3> arrange `git push` to push all local branches to
+their corresponding branch of the mothership machine.
+<4> push will stash all our work away on `remotes/satellite/*`
+remote-tracking branches on the mothership machine.  You could use this
 as a back-up method.
 <5> on mothership machine, merge the work done on the satellite
 machine into the master branch.
@@ -195,17 +216,18 @@ Branch off of a specific tag.::
 $ git checkout -b private2.6.14 v2.6.14 <1>
 $ edit/compile/test; git commit -a
 $ git checkout master
-$ git format-patch -k -m --stdout v2.6.14..private2.6.14 |
-  git am -3 -k <2>
+$ git cherry-pick v2.6.14..private2.6.14 <2>
 ------------
 +
 <1> create a private branch based on a well known (but somewhat behind)
 tag.
 <2> forward port all changes in `private2.6.14` branch to `master` branch
-without a formal "merging".
+without a formal "merging". Or longhand +
+`git format-patch -k -m --stdout v2.6.14..private2.6.14 |
+  git am -3 -k`
 
 
-Integrator[[Integrator]]
+Integrator[[INTEGRATOR]]
 ------------------------
 
 A fairly central person acting as the integrator in a group
@@ -213,6 +235,9 @@ project receives changes made by others, reviews and integrates
 them and publishes the result for others to use, using these
 commands in addition to the ones needed by participants.
 
+This section can also be applied to a git-request-pull workflow,
+or the GitHub (www.github.com) pull-request flow.
+
   * linkgit:git-am[1] to apply patches e-mailed in from your
     contributors.
 
@@ -225,23 +250,26 @@ commands in addition to the ones needed by participants.
 
   * linkgit:git-push[1] to publish the bleeding edge.
 
+  * linkgit:git-request-pull[1] to create a summary of changes
+    for your upstream to pull.
+
 
 Examples
 ~~~~~~~~
 
-My typical Git day.::
+A typical integrator's Git day.::
 +
 ------------
 $ git status <1>
-$ git show-branch <2>
+$ git branch --no-merged master <2>
 $ mailx <3>
 & s 2 3 4 5 ./+to-apply
 & s 7 8 ./+hold-linus
 & q
 $ git checkout -b topic/one master
-$ git am -3 -i -s -u ./+to-apply <4>
+$ git am -3 -i -s ./+to-apply <4>
 $ compile/test
-$ git checkout -b hold/linus && git am -3 -i -s -u ./+hold-linus <5>
+$ git checkout -b hold/linus && git am -3 -i -s ./+hold-linus <5>
 $ git checkout topic/one && git rebase master <6>
 $ git checkout pu && git reset --hard next <7>
 $ git merge topic/one topic/two && git merge hold/linus <8>
@@ -249,51 +277,51 @@ $ git checkout maint
 $ git cherry-pick master~4 <9>
 $ compile/test
 $ git tag -s -m "GIT 0.99.9x" v0.99.9x <10>
-$ git fetch ko && git show-branch master maint 'tags/ko-*' <11>
-$ git push ko <12>
-$ git push ko v0.99.9x <13>
+$ git fetch ko && for branch in master maint next pu <11>
+    do
+        git show-branch ko/$branch $branch <12>
+    done
+$ git push --follow-tags ko <13>
 ------------
 +
-<1> see what I was in the middle of doing, if any.
-<2> see what topic branches I have and think about how ready
-they are.
+<1> see what you were in the middle of doing, if anything.
+<2> see which branches haven't been merged into 'master' yet.
+Likewise for any other integration branches e.g. 'maint', 'next'
+and 'pu' (potential updates).
 <3> read mails, save ones that are applicable, and save others
-that are not quite ready.
-<4> apply them, interactively, with my sign-offs.
-<5> create topic branch as needed and apply, again with my
-sign-offs.
+that are not quite ready (other mail readers are available).
+<4> apply them, interactively, with your sign-offs.
+<5> create topic branch as needed and apply, again with sign-offs.
 <6> rebase internal topic branch that has not been merged to the
 master or exposed as a part of a stable branch.
 <7> restart `pu` every time from the next.
 <8> and bundle topic branches still cooking.
 <9> backport a critical fix.
 <10> create a signed tag.
-<11> make sure I did not accidentally rewind master beyond what I
-already pushed out.  `ko` shorthand points at the repository I have
-at kernel.org, and looks like this:
+<11> make sure master was not accidentally rewound beyond that
+already pushed out.  `ko` shorthand points at the Git maintainer's
+repository at kernel.org, and looks like this:
 +
 ------------
-$ cat .git/remotes/ko
-URL: kernel.org:/pub/scm/git/git.git
-Pull: master:refs/tags/ko-master
-Pull: next:refs/tags/ko-next
-Pull: maint:refs/tags/ko-maint
-Push: master
-Push: next
-Push: +pu
-Push: maint
+(in .git/config)
+[remote "ko"]
+        url = kernel.org:/pub/scm/git/git.git
+        fetch = refs/heads/*:refs/remotes/ko/*
+        push = refs/heads/master
+        push = refs/heads/next
+        push = +refs/heads/pu
+        push = refs/heads/maint
 ------------
 +
-In the output from `git show-branch`, `master` should have
-everything `ko-master` has, and `next` should have
-everything `ko-next` has.
-
-<12> push out the bleeding edge.
-<13> push the tag out, too.
+<12> In the output from `git show-branch`, `master` should have
+everything `ko/master` has, and `next` should have
+everything `ko/next` has, etc.
+<13> push out the bleeding edge, together with new tags that point
+into the pushed history.
 
 
-Repository Administration[[Repository Administration]]
-------------------------------------------------------
+Repository Administration[[ADMINISTRATION]]
+-------------------------------------------
 
 A repository administrator uses the following tools to set up
 and maintain access to the repository by developers.
@@ -304,9 +332,19 @@ and maintain access to the repository by developers.
   * linkgit:git-shell[1] can be used as a 'restricted login shell'
     for shared central repository users.
 
+  * linkgit:git-http-backend[1] provides a server side implementation
+    of Git-over-HTTP ("Smart http") allowing both fetch and push services.
+
+  * linkgit:gitweb[1] provides a web front-end to Git repositories,
+    which can be set-up using the linkgit:git-instaweb[1] script.
+
 link:howto/update-hook-example.html[update hook howto] has a good
 example of managing a shared central repository.
 
+In addition there are a number of other widely deployed hosting, browsing
+and reviewing solutions such as:
+
+  * gitolite, gerrit code review, cgit and others.
 
 Examples
 ~~~~~~~~
@@ -350,7 +388,10 @@ service git
 Check your xinetd(8) documentation and setup, this is from a Fedora system.
 Others might be different.
 
-Give push/pull only access to developers.::
+Give push/pull only access to developers using git-over-ssh.::
+
+e.g. those using:
+`$ git push/pull ssh://host.xz/pub/scm/project`
 +
 ------------
 $ grep git /etc/passwd <1>
@@ -363,8 +404,8 @@ $ grep git /etc/shells <2>
 ------------
 +
 <1> log-in shell is set to /usr/bin/git-shell, which does not
-allow anything but `git push` and `git pull`.  The users should
-get an ssh access to the machine.
+allow anything but `git push` and `git pull`.  The users require
+ssh access to the machine.
 <2> in many distributions /etc/shells needs to list what is used
 as the login shell.
 
@@ -401,13 +442,6 @@ for branch policy control.
 david is the release manager and is the only person who can
 create and push version tags.
 
-HTTP server to support dumb protocol transfer.::
-+
-------------
-dev$ git update-server-info <1>
-dev$ ftp user@isp.example.com <2>
-ftp> cp -r .git /home/user/myproject.git
-------------
-+
-<1> make sure your info/refs and objects/info/packs are up-to-date
-<2> upload to public HTTP server hosted by your ISP.
+GIT
+---
+Part of the linkgit:git[1] suite
-- 
1.9.4.msysgit.0
