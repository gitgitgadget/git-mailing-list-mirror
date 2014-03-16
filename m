From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH pu] Documentation/giteveryday: fix some obvious problems
Date: Sun, 16 Mar 2014 19:11:46 -0400
Message-ID: <1395011506-21447-1-git-send-email-artagnon@gmail.com>
Cc: Philip Oakley <philipoakley@iee.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 17 00:11:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPKD3-0004HD-R3
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 00:11:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbaCPXLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2014 19:11:08 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:60568 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755770AbaCPXLG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2014 19:11:06 -0400
Received: by mail-yk0-f169.google.com with SMTP id 142so13105371ykq.0
        for <git@vger.kernel.org>; Sun, 16 Mar 2014 16:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=HAnSsKoqjaR0v00dU7+hJzhLuruBLX6wiCJgnvl7Lrw=;
        b=vfiR7dQTJgLrI7s3IbivB5NcIyFFQNiuvXArbHVAHnoe5Ey2Rxp6iO2B+szwqWJ7vV
         hWErT6rA+dwjU5XoBlBpgFp3fFnRp6kCLclhPlo7fwm0Cqp4N9xWDGHb8bQzTlUG4aV/
         tqlZAPvEw5L11ClROatH0esakukXJYJl3INmoS2p4XNCid3TjzefgZTdY5eCZfVb8BuW
         V/gZi8KHpSo9I6ywAH/ObuRZDKSA0mHlpr+EFyrEnHJUS/PZ+QTz/sI/nKFvQ3YXMYvo
         hDIte/TIfwEBkBrm/kTRO21C12nhR3Rmxd628yHZqGbZEZpn+uJ3VfkOb6YnldipegjC
         ruhQ==
X-Received: by 10.236.231.101 with SMTP id k95mr5367548yhq.34.1395011465361;
        Sun, 16 Mar 2014 16:11:05 -0700 (PDT)
Received: from fran.hsd1.ga.comcast.net. (c-98-242-72-155.hsd1.ga.comcast.net. [98.242.72.155])
        by mx.google.com with ESMTPSA id r46sm9597782yhd.29.2014.03.16.16.11.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 16 Mar 2014 16:11:04 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.431.g014438b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244215>

Fix a few minor things.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Philip,

 I spotted a few obvious issues with your giteveryday patch in
 pu. Maybe Junio can squash this into your patch? Contents are still a
 bit stale, but I'm not sure what other markup problems are there.

 Documentation/giteveryday.txt | 78 +++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 40 deletions(-)

diff --git a/Documentation/giteveryday.txt b/Documentation/giteveryday.txt
index 8dc298f..82ff8ec 100644
--- a/Documentation/giteveryday.txt
+++ b/Documentation/giteveryday.txt
@@ -35,8 +35,6 @@ following commands.
 
   * linkgit:git-init[1] to create a new repository.
 
-  * linkgit:git-show-branch[1] to see where you are.
-
   * linkgit:git-log[1] to see what happened.
 
   * linkgit:git-checkout[1] and linkgit:git-branch[1] to switch
@@ -61,8 +59,8 @@ following commands.
 Examples
 ~~~~~~~~
 
-Use a tarball as a starting point for a new repository.::
-+
+Use a tarball as a starting point for a new repository:
+
 ------------
 $ tar zxf frotz.tar.gz
 $ cd frotz
@@ -71,12 +69,12 @@ $ git add . <1>
 $ git commit -m "import of frotz source tree."
 $ git tag v2.43 <2>
 ------------
-+
+
 <1> add everything under the current directory.
 <2> make a lightweight, unannotated tag.
 
-Create a topic branch and develop.::
-+
+Create a topic branch and develop:
+
 ------------
 $ git checkout -b alsa-audio <1>
 $ edit/compile/test
@@ -95,7 +93,7 @@ $ git merge alsa-audio <10>
 $ git log --since='3 days ago' <11>
 $ git log v2.43.. curses/ <12>
 ------------
-+
+
 <1> create a new topic branch.
 <2> revert your botched changes in `curses/ux_audio_oss.c`.
 <3> you need to tell Git if you added a new file; removal and
@@ -137,8 +135,8 @@ addition to the ones needed by a standalone developer.
 Examples
 ~~~~~~~~
 
-Clone the upstream and work on it.  Feed changes to upstream.::
-+
+Clone the upstream and work on it.  Feed changes to upstream:
+
 ------------
 $ git clone git://git.kernel.org/pub/scm/.../torvalds/linux-2.6 my2.6
 $ cd my2.6
@@ -151,7 +149,7 @@ $ git reset --hard ORIG_HEAD <6>
 $ git gc <7>
 $ git fetch --tags <8>
 ------------
-+
+
 <1> repeat as needed.
 <2> extract patches from your branch for e-mail submission.
 <3> `git pull` fetches from `origin` by default and merges into the
@@ -166,8 +164,8 @@ area we are interested in.
 and store them under `.git/refs/tags/`.
 
 
-Push into another repository.::
-+
+Push into another repository:
+
 ------------
 satellite$ git clone mothership:frotz frotz <1>
 satellite$ cd frotz
@@ -185,7 +183,7 @@ mothership$ cd frotz
 mothership$ git checkout master
 mothership$ git merge satellite/master <5>
 ------------
-+
+
 <1> mothership machine has a frotz repository under your home
 directory; clone from it to start a repository on the satellite
 machine.
@@ -200,8 +198,8 @@ as a back-up method.
 <5> on mothership machine, merge the work done on the satellite
 machine into the master branch.
 
-Branch off of a specific tag.::
-+
+Branch off of a specific tag:
+
 ------------
 $ git checkout -b private2.6.14 v2.6.14 <1>
 $ edit/compile/test; git commit -a
@@ -209,7 +207,7 @@ $ git checkout master
 $ git format-patch -k -m --stdout v2.6.14..private2.6.14 |
   git am -3 -k <2>
 ------------
-+
+
 <1> create a private branch based on a well known (but somewhat behind)
 tag.
 <2> forward port all changes in `private2.6.14` branch to `master` branch
@@ -240,8 +238,8 @@ commands in addition to the ones needed by participants.
 Examples
 ~~~~~~~~
 
-My typical Git day.::
-+
+My typical Git day:
+
 ------------
 $ git status <1>
 $ git show-branch <2>
@@ -261,10 +259,10 @@ $ git cherry-pick master~4 <9>
 $ compile/test
 $ git tag -s -m "GIT 0.99.9x" v0.99.9x <10>
 $ git fetch ko && git show-branch master maint 'tags/ko-*' <11>
-$ git push ko <12>
-$ git push ko v0.99.9x <13>
+$ git push ko
+$ git push ko v0.99.9x
 ------------
-+
+
 <1> see what I was in the middle of doing, if any.
 <2> see what topic branches I have and think about how ready
 they are.
@@ -282,7 +280,7 @@ master, nor exposed as a part of a stable branch.
 <11> make sure I did not accidentally rewind master beyond what I
 already pushed out.  `ko` shorthand points at the repository I have
 at kernel.org, and looks like this:
-+
+
 ------------
 $ cat .git/remotes/ko
 URL: kernel.org:/pub/scm/git/git.git
@@ -294,7 +292,7 @@ Push: next
 Push: +pu
 Push: maint
 ------------
-+
+
 In the output from `git show-branch`, `master` should have
 everything `ko-master` has, and `next` should have
 everything `ko-next` has.
@@ -322,24 +320,24 @@ example of managing a shared central repository.
 Examples
 ~~~~~~~~
 We assume the following in /etc/services::
-+
+
 ------------
 $ grep 9418 /etc/services
 git		9418/tcp		# Git Version Control System
 ------------
 
-Run git-daemon to serve /pub/scm from inetd.::
-+
+Run git-daemon to serve /pub/scm from inetd:
+
 ------------
 $ grep git /etc/inetd.conf
 git	stream	tcp	nowait	nobody \
   /usr/bin/git-daemon git-daemon --inetd --export-all /pub/scm
 ------------
-+
+
 The actual configuration line should be on one line.
 
-Run git-daemon to serve /pub/scm from xinetd.::
-+
+Run git-daemon to serve /pub/scm from xinetd:
+
 ------------
 $ cat /etc/xinetd.d/git-daemon
 # default: off
@@ -357,12 +355,12 @@ service git
         log_on_failure  += USERID
 }
 ------------
-+
+
 Check your xinetd(8) documentation and setup, this is from a Fedora system.
 Others might be different.
 
-Give push/pull only access to developers.::
-+
+Give push/pull only access to developers:
+
 ------------
 $ grep git /etc/passwd <1>
 alice:x:1000:1000::/home/alice:/usr/bin/git-shell
@@ -372,15 +370,15 @@ david:x:1003:1003::/home/david:/usr/bin/git-shell
 $ grep git /etc/shells <2>
 /usr/bin/git-shell
 ------------
-+
+
 <1> log-in shell is set to /usr/bin/git-shell, which does not
 allow anything but `git push` and `git pull`.  The users should
 get an ssh access to the machine.
 <2> in many distributions /etc/shells needs to list what is used
 as the login shell.
 
-CVS-style shared repository.::
-+
+CVS-style shared repository:
+
 ------------
 $ grep git /etc/group <1>
 git:x:9418:alice,bob,cindy,david
@@ -403,7 +401,7 @@ refs/heads/master	alice\|cindy
 refs/heads/doc-update	bob
 refs/tags/v[0-9]*	david
 ------------
-+
+
 <1> place the developers into the same git group.
 <2> and make the shared repository writable by the group.
 <3> use update-hook example by Carl from Documentation/howto/
@@ -412,14 +410,14 @@ for branch policy control.
 david is the release manager and is the only person who can
 create and push version tags.
 
-HTTP server to support dumb protocol transfer.::
-+
+HTTP server to support dumb protocol transfer:
+
 ------------
 dev$ git update-server-info <1>
 dev$ ftp user@isp.example.com <2>
 ftp> cp -r .git /home/user/myproject.git
 ------------
-+
+
 <1> make sure your info/refs and objects/info/packs are up-to-date
 <2> upload to public HTTP server hosted by your ISP.
 
-- 
1.9.0.431.g014438b
