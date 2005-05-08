From: Petr Baudis <pasky@ucw.cz>
Subject: [ANNOUNCE] Cogito-0.10
Date: Mon, 9 May 2005 01:34:31 +0200
Message-ID: <20050508233431.GP9495@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon May 09 01:27:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUvBN-0001FY-Vp
	for gcvg-git@gmane.org; Mon, 09 May 2005 01:27:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263007AbVEHXek (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 19:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263008AbVEHXek
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 19:34:40 -0400
Received: from w241.dkm.cz ([62.24.88.241]:56032 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S263007AbVEHXeh (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 May 2005 19:34:37 -0400
Received: (qmail 14031 invoked by uid 2001); 8 May 2005 23:34:31 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

  Hello,

  I'm happy to announce new release of Cogito, my SCM-like layer upon
the Linus' GIT tree history storage engine, aiming for user-friendliness.
Get it at

	http://www.kernel.org/pub/software/scm/cogito

or cg-update if you already have any decently fresh version.

  The highlights are cg-logging of individual files, cg-export
foo.tar.gz, fixed cg-init of fresh trees (it makes an initial commit
now), cg-commit message processing enhancements (in cooperation mainly
with Marcel Holtmann), cg-restore, cg-admin-uncommit, and cg-X* stuff in
a library directory. And also merge with Linus, which brings some stuff
chronologically pre-cogito-0.9, but I forgot to pull before release.

  Usage changes:
    * cg-update without parameters now does not recover lost files;
      that functionality was moved to cg-restore which can do that
      with individual files only too.
    * cg-update and cg-pull w/o arguments default to "origin" again.
      Everyone rejoices.
    * cg-init SOURCE_LOC is now deprecated, cg-init should not be
      called directly for the cloning stuff anymore. Use it only for
      creating new repositories now.
    * cg-clone can take a -s argument now which makes it to clone to
      the current directory instead of a subdirectory.

  I think the usage is very stabilized by now, and is actually quite
unlikely to change anymore - you can safely start to get used to it. The
only change still queued is removing cg-init SOURCE_LOC functionality
altogether; I'm delaying that yet mainly because of the
http://www.kernel.org/git/ text. ;-)

  I think we are overall stabilizing very nicely, and might actually
be nearing cogito-1.0 (but let that not stop you doing anything yet...
perhaps except rewriting the whole thing in Befunge).

  Please note that my patch queue is basically empty now. The only
things I have marked for consideration yet are:

4778 N   Apr 22 Morten Welinder ( 7.0K) [PATCH] Constify
5607 N T Apr 28 Philip Pokorny  ( 2.5K) PATCH[*/4]: Allow tree-id to return the ID of a tree object

  So if you have a patch you think I should have in my tree too, please
resend it. Do not forget to put the patch inline to the mail body or as
a text/plain attachment, and to sign it off.

  Have fun,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
