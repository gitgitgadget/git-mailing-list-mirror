From: Petr Baudis <pasky@ucw.cz>
Subject: gitweb wishlist
Date: Wed, 11 May 2005 03:26:26 +0200
Message-ID: <20050511012626.GL26384@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 03:19:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVfsM-0005Z8-U9
	for gcvg-git@gmane.org; Wed, 11 May 2005 03:19:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbVEKB0a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 21:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbVEKB0a
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 21:26:30 -0400
Received: from w241.dkm.cz ([62.24.88.241]:59819 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261872AbVEKB02 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2005 21:26:28 -0400
Received: (qmail 8786 invoked by uid 2001); 11 May 2005 01:26:26 -0000
To: Kay Sievers <kay.sievers@vrfy.org>
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

  Hello,

  I would be very happy if you could extend the gitweb scripts a little.
Basically, what I need is to have ability to create a permanent link to
a given file in the repository, which stays same across revisions (as
long as the file stays with the given name, obviously).

  E.g. I would like to have something like

	http://www.kernel.org/git/gitweb.cgi?p=cogito%2Fcogito.git;n=contrib/ciabot.pl

for file contrib/ciabot.pl in the latest Cogito tree, and

	http://www.kernel.org/git/gitweb.cgi?p=cogito%2Fcogito.git;n=contrib

for the list of the contrib/ directory in the latest Cogito tree.

  I think I would prefer the link from the repository index to go not to
the log page, but some "summary" page, which would have some short
information about the repository (owner, description, list of branches
if gitweb supports that, list of tags, link to the latest tree and link
to the log).

  BTW, why are people using ';' in the URIs for separators instead of
good old '&'s? Hmm, actually it just occurred to me that it might be to
workaround entity string problems?

  Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
