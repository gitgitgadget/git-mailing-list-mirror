From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git
Date: Tue, 04 Apr 2006 16:06:07 -0700
Message-ID: <7v3bgt54bk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Apr 05 01:06:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQubF-0002sb-BR
	for gcvg-git@gmane.org; Wed, 05 Apr 2006 01:06:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbWDDXGK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Apr 2006 19:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbWDDXGJ
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Apr 2006 19:06:09 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:41374 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1750912AbWDDXGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Apr 2006 19:06:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060404230608.YOCV17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 4 Apr 2006 19:06:08 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18411>

I've tagged the tip of "master" as 1.3.0-rc2.  It has the
following changes since the last announcement.

 - enhancement and a minor fix to built-in xdiff
   (Davide Libenzi and Mark Wooding)

 - contrib/git-svn updates (Eric Wong)

 - documentation updates (J. Bruce Fields)

 - build and other assorted fixes and cleanups (Jason Riedy,
   Peter Eriksen, Rene Scharfe, Yasushi SHOJI, and Jim Radford)

 - Solaris "clone" fix (Linus and Jason Riedy with initial
   reproduction help from Peter Eriksen)

 - revision traversal latency improvements with paths and
   max-age limiting (Linus and me)

 - http-fetch updates (Nick Hengeveld)

 - updated gitk (Paul Mackerras)


* The 'next' branch, in addition, has these.

 - fix cloning of upsteram whose HEAD does not point at master
   (me); this is an attempt to fix a real bug, but I haven't had
   a chance to test it sufficiently enough to convince myself it
   is ready.

 - pickaxe enhancements that looks for needles matching regexp
   (Petr Baudis)

 - combine-diff that uses built-in xdiff (me)

* The 'pu' branch, in addition, has these.

 - assorted gitk updates from the list (Johannes Schindelin,
   Keith Packard and Mark Wooding); I am waiting for some of
   them to trickle back from Paul's canonical gitk tree.

 - beginning of new pickaxe (me); I've got busy before getting this
   one to do anything interesting.  Currently it is just a bit
   faster way to do 'rev-list | diff-tree --stdin path' for a
   single path.
