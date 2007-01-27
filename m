From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: git user's manual
Date: Sat, 27 Jan 2007 01:28:26 -0500
Message-ID: <20070127062826.GE14205@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 27 07:28:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAh3I-0007o9-Et
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 07:28:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912AbXA0G22 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 01:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751920AbXA0G22
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 01:28:28 -0500
Received: from mail.fieldses.org ([66.93.2.214]:33761 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751912AbXA0G21 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 01:28:27 -0500
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HAh34-0006u8-N7
	for git@vger.kernel.org; Sat, 27 Jan 2007 01:28:26 -0500
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37921>

I'm still tinkering with this "Git User's Manual"; you can see the
current draft at:

	http://fieldses.org/~bfields/git-user-manual.html

or get the source from the branch master in:

	git://linux-nfs.org/~bfields/git.git

Changes include:

	- a "quick start" with a bunch of commands and no explanation,
	  as the first chapter
	- discussion of git-remote, presenting that as the primary
	  method for tracking remotes and postponing fetches of
	  individual branches till later.  (Is this a sensible
	  approach?)
	- import of a slightly modified version of the README as the
	  start of a "git internals' chapter.
	- discussion of history rewriting, pitfalls thereof,
	  cherry-pick, rebase, etc.
	- updates to try to track recent interface improvements,
	  etc.

So it's longer, but still incomplete, and some of it's probably quite
wrong....

Despite that I'm tempted to ask that it be merged some time soon and
just not referred to much yet; then hopefully people could help bludgeon
it into shape before we start adding pointers to it from elsewhere.

Then we'll have to figure out whether it could obsolete any existing
documentation.  I'd kind of like to rip out tutorial-2.txt at least, and
maybe absorb cvs-migration and a few other things as new chapters.

I dunno; thoughts?

--b.
