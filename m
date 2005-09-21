From: Petr Baudis <pasky@suse.cz>
Subject: Another gitweb wishlist
Date: Wed, 21 Sep 2005 22:16:56 +0200
Message-ID: <20050921201656.GA10575@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 21 22:19:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIB1a-0004co-FR
	for gcvg-git@gmane.org; Wed, 21 Sep 2005 22:17:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbVIUUQ7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 16:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964809AbVIUUQ7
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 16:16:59 -0400
Received: from w241.dkm.cz ([62.24.88.241]:43161 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964808AbVIUUQ6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2005 16:16:58 -0400
Received: (qmail 21061 invoked by uid 2001); 21 Sep 2005 22:16:56 +0200
To: kay.sievers@vrfy.org, ch@gierke.de
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9074>

  Hello,

  I have accumulated some more stuff I'm missing in gitweb, so I'm
dumping it on you now. ;-)

  (i) Speed - the http://kernel.org/git/ document takes anytime between
roughly 30 seconds to one minute to load. What's taking so long?

  (ii) I need persistent links to the latest version of <file>. Obvious

	http://kernel.org/git/?p=cogito/cogito.git;a=blob;f=contrib/ciabot.pl

does not quite work right, since there are no links to (most
importantly) the plain view (and blob_plain link doesn't work), tree
view and such.

  (iii) Too hard to follow history of renamed files. Let's take
git-log.sh.  I'll immediately stop at the big rename commit:

	http://kernel.org/git/?p=git/git.git;a=commit;h=215a7ad1ef790467a4cd3f0dcffbd6e5f04c38f7

If I want to continue following its history before the rename, I have to
manually go to the tree of the parent commit and get the history of the
original file there. This is quite annoying and significantly reduces
practicality of the feature on the GIT repository precisely because of
the big rename.

  (iv) Related to (iii), if you get the hb  parameter to the blob view,
you should offer the 'diff' and 'history' links in the blob view. Also
the 'log' and 'shortlog' links should point to more sensible locations,
either the same as in the relevant commit's view, or see (v).

  (v) Only shortlog is available for per-file history. Perhaps it would
be nicer to make 'log' and 'shortlog' links in blob context go to the
file's history, and in file history switch between shortlog/log display
mode.

  Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
