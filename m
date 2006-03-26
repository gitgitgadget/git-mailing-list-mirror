From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git
Date: Sat, 25 Mar 2006 22:00:03 -0800
Message-ID: <7v1wwprbj0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Mar 26 08:00:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNOIV-0008Oa-EE
	for gcvg-git@gmane.org; Sun, 26 Mar 2006 08:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWCZGAG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Mar 2006 01:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWCZGAG
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Mar 2006 01:00:06 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:9873 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750743AbWCZGAF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Mar 2006 01:00:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060326060004.ZIIH25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 26 Mar 2006 01:00:04 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18028>

* The 'master' branch has these since the last announcement.

 - git-svn memory usage reduction (Eric Wong)
 - documentation updates (Francis Daly, Jon Loeliger)
 - fix updating working tree after cvsimport reads from CVS
 - fetch exits non-zero when fast-forward check fails.
 - improve git-pull's failur case when pulling into the tracking branch.
 - commit-tree checks return value from write_sha1_file().
 - git-apply understands "@@ -l, +m @@" correctly.

----------------------------------------------------------------

* The 'next' branch, in addition, has these.

These are harmless and useful to be pushed into "master"; I just
have not gotten around to.

 - updates around git-clone:
   . --use-separate-remote
   . --reference <repo>
   . fetch,parse-remote,fmt-merge-msg: refs/remotes/* support (Eric Wong)
   . sha1_name() understands refs/remotes/$foo/HEAD

 - sha1_name safety and core.warnambiguousrefs
 - git-merge knows some strategies want to skip trivial merges

------------

I really should do some more stats on this and push it out.
Just haven't got around to do so.

 - insanely fast rename detection (Linus and me)

------------

These look very good, but people depend on them, so I'd like to
simmer them in "next" for a couple of days to hear success
stories, or "ah crap I got burned" story ;-).

 - tar-tree updates (Rene Scharfe)
 - send-email updates (Eric Wong)

------------

Hot off the press.  I smell the beginning of a good stuff here.

 - truly built-in diff (Linus with Davide)

------------

This is harmless to be pushed into "master" but is staying here
only because nobody expressed urgency.

 - ls-{files,tree} --abbrev (Eric Wong)

----------------------------------------------------------------

* The 'pu' branch, in addition, has these.

Since I do not have a good guinea pig case to use this, I
haven't read and understood the code being patched enough to
comment on the change this one introduces; it looks obviously
correct, though.

I'd like an ACK or two from people who works with SVN gateway
before I apply this to "master".

 - git-svnimport: if a limit is specified, respect it (Anand Kumria)

------------

This script does what it claims to do, but I do not think of a
useful use case for this.  When I have packs with garbage
objects in them (because I rewind my "pu" branch I usually end
up having a handful in my packs), I just run "repack -a -d" and
that is good enough.  So I need a bit of convincing to keep
this.

 - Add git-explode-packs (Martin Atukunda)
