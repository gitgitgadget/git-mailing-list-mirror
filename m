From: Pavel Roskin <proski@gnu.org>
Subject: Ideas for qgit
Date: Fri, 23 Jun 2006 00:08:31 -0400
Message-ID: <1151035711.25640.6.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jun 23 06:08:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtcyD-0005nF-Fa
	for gcvg-git@gmane.org; Fri, 23 Jun 2006 06:08:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWFWEIe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 00:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbWFWEIe
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 00:08:34 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:10176 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751239AbWFWEIe
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jun 2006 00:08:34 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1Ftcy9-0005Qz-9w
	for git@vger.kernel.org; Fri, 23 Jun 2006 00:08:33 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1Ftcy8-0006gt-1n; Fri, 23 Jun 2006 00:08:32 -0400
To: git <git@vger.kernel.org>, Marco Costalba <mcostalba@gmail.com>
X-Mailer: Evolution 2.7.2.1 (2.7.2.1-4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22397>

Hi, Marco!

As promised, here's what I would like to see in qgit:

1) Bookmarks or quick tags (qtags).  It may be useful to mark some
commits to make it easier to navigate qgit.  Yet I don't want them to
mix with real tags.  Perhaps qgit could save them separately, e.g.
in .git/refs/qtags to facilitate navigation.  qtags should appear
separately in the popup menu.

2) The "Patch" tab should be redesigned so that the diff can be shown
against the parent or against head/tag/qtag.  Users are not supposed to
enter SHA1.  If they have to, then it only confirms that qgit needs
qtags.

3) It would be nice to have some minimal navigating capabilities on the
Patch tab.  At least it should be possible to go up and down the
revision list and go to any head/tag/qtag/stgit patch.  It would
eliminate the need to switch to the "Rev list" too often.

4) Some bisect support would be nice, at least as good as in gitk.
Actually, I'm not using bisect too much, but it's probably because I'm
not debugging Wine these days.  Everything else is intelligible :-)

5) Branch view based on reflog.  Probably there should be an interface
allowing to limit the displayed revisions to one branch.  I think qgit
should still load all revisions that it loads now, but if users start
complaining about performance too much, maybe qgit should have an option
to load only the logged branch.  The problem is that some parents will
be unavailable in the view.

6) Try to unload some stuff from the popup menus to the main menu.  It
will be too log if we use it for tags, qtags, branch heads and branch
logs.

7) qgit command line should be documented.  "qgit --help" should display
help on stdout.

That said, qgit is in a pretty decent shape right now (except the
"macro" interface, but I'm sure it will be improved before the next
release).  I actually used qgit as an important argument for one project
to go with git rather than with Subversion of Mercurial.  qgit for
Mercurial would be cool, but I'd leave it to Mercurial fans.

-- 
Regards,
Pavel Roskin
