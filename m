From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 1.0.3
Date: Fri, 23 Dec 2005 00:11:34 -0800
Message-ID: <7voe389qrt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Dec 23 09:11:47 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Epi1c-0004tX-KV
	for gcvg-git@gmane.org; Fri, 23 Dec 2005 09:11:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030457AbVLWILh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Dec 2005 03:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030458AbVLWILg
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Dec 2005 03:11:36 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:54732 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1030457AbVLWILg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Dec 2005 03:11:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051223081138.NJMM25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 23 Dec 2005 03:11:38 -0500
To: git@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13987>

Only trivial fixes and cosmetics, there is nothing to see here,
except the versioning scheme has been updated.

Starting in 0.99.7 days and continuing until yesterday,
maintenance releases were named with letter suffixes, like
0.99.7a, 0.99.7b,...  Some people seem to have had trouble with
grasping the concept [*1*] ;-)

So the numbering scheme switched to a boring decimal:

 - The maintenance releases that follow 1.0.0 are named 1.0.1,
   1.0.2, 1.0.3,..., and contain only bugfixes [*2*].

 - The next release that follows 1.0.0 is 1.1.0, which, unlike
   1.0.X, is allowed to have enhancements.

 - If one builds and installs from a random revision on the
   "master" branch or "pu" branch after 1.0.0 happens but before
   1.1.0 happens, "git --version" would say 1.0.GIT.  There will
   not be such an intermediate state on the "maint" branch.

I'll slow down until early next year and will not make a formal
roadmap for 1.1.0 and onwards for now, but I've reviewed the
TODO items and updated them here:

    http://kernel.org/git/?p=git/git.git;a=blob;hb=todo;f=TODO

I have not prioritized them quite yet, other than dropping a
couple of obviously unneeded or done items.


[Footnote]

*1* No, I did not model these release naming after military
jets, as somebody privately suggested me in an e-mail.  I had an
impression that letter updates over there are more often
enhancements and/or repurposing to prolong the service life than
bugfixes.  I mimicked ancient Linux versions with letter
suffixes, but come to think of it, they were more enhancements
than fixes, I suspect.

*2* Inevitably there are borderline cases.  One could argue that
the [IPV6address] syntax is a fix: "earlier we ought to have
handled it".  The file:// URL failure case detection could be
called enhancements: "we never said we support file:// URL".


shortlog since 1.0.0b which should have been 1.0.2
--------------------------------------------------


Alex Riesen:
      \n usage in stderr output

Johannes Schindelin:
      git-format-patch should show the correct version
      sha1_to_hex: properly terminate the SHA1

Junio C Hamano:
      send-pack: reword non-fast-forward error message.

Nick Hengeveld:
      Fix for http-fetch from file:// URLs

Pavel Roskin:
      sanity check in add_packed_git()
