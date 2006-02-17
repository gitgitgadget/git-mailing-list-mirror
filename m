From: Junio C Hamano <junkio@cox.net>
Subject: contrib/ area
Date: Fri, 17 Feb 2006 03:07:33 -0800
Message-ID: <7vmzgq451m.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Aneesh Kumar <aneesh.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 17 12:07:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FA3Sc-0003VM-JD
	for gcvg-git@gmane.org; Fri, 17 Feb 2006 12:07:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWBQLHf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Feb 2006 06:07:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbWBQLHf
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Feb 2006 06:07:35 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:1716 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750830AbWBQLHf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2006 06:07:35 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060217110406.YEFS20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 17 Feb 2006 06:04:06 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16337>

As some of you may be aware, I've added contrib/ area to git.git
repository.  Currently there are git-svn from Eric and gitview
from Aneesh.

The intention is to keep interesting tools around git, maybe
even experimental ones, to give users an easier access to them,
and to give tools wider exposure, so that they can be improved
faster.

I am expecting not to touch them myself that much.  As far as my
day-to-day operation is concerned, contrib/git-svn is owned by
Eric and contrib/gitview by Aneesh.  I am willing to help if
users of these components and the contrib/ subtree "owners" have
technical/design issues to resolve, but the initiative to fix
and/or enhance things _must_ be on the side of the subtree
owners.  IOW, I won't be actively looking for bugs and rooms for
enhancements in them as the git maintainer -- I may only do so
just as one of the users when I want to scratch my own itch.  If
you have patches to things in contrib/ area, the patch should be
first sent to the primary author, and then the primary author
should ack and forward it to me (git pull request is nicer).
This is the same way as how I treated gitk, so you know the
drill.

I expect that things that start their life in the contrib/ area
to graduate out of contrib/ once they mature, either by becoming
projects on their own, or moving to the toplevel directory.  On
the other hand, I expect I'll be proposing removal of disused
and inactive ones from time to time.

By the way, I have to admit that merging these two were a bit
painful for me.  They came as text attachments to e-mail
messages, and I ended up hand committing with --author flag,
while fixing up whitespaces in them [*1*].  I do not want to do
that again.  So if you have new things to add to the contrib/
area, please first propose it on the list, and after a list
discussion proves there are some general interests (it does not
have to be a list-wide consensus for a tool targeted to a
relatively narrow audience -- for example I do not work with
projects whose upstream is svn, so I have no use for git-svn
myself), submit a patch to create a subdirectory of contrib/ and
put your stuff there.

One final request to Aneesh.  Could you send a patch to add a
bit of blurb and introductory text in contrib/gitview/README,
please?  As it stands, it would be hard to get as much exposure
as we had hoped by just having it in git.git repository.

[Footnote]

*1* I _am_ picky about whitespaces, and I would encourage people
to enable the pre-commit example hook.
