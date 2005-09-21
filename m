From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 0.99.7a
Date: Wed, 21 Sep 2005 02:10:27 -0700
Message-ID: <7vr7biyef0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Sep 21 11:11:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EI0cc-0000gC-3q
	for gcvg-git@gmane.org; Wed, 21 Sep 2005 11:10:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbVIUJKc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 05:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbVIUJKb
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 05:10:31 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:48115 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750782AbVIUJKb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2005 05:10:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050921091027.ETUC11628.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 21 Sep 2005 05:10:27 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9033>

With help from various people, 0.99.7a is out to fix
showstoppers, brown paper bags, and obviously safe
improvements.

 - For distributions that do not have Python 2.4 yet, we stop
   requiring it.  Instead, we ship our own copy of "subprocess"
   module with blessings of Peter Astrand, the author, as a
   fallback.  Many thanks to HPA for suggesting the directions
   on this issue.

 - A long-standing bug in git-init-db that creates a bogus empty
   directory while copying templates has been found and fixed,
   thanks to Pasky and HPA.

 - Linus fixed short SHA1 name completion -- this is not a
   strict showstopper bugfix but deemed safe enough.

 - git-show-branch, when run in a corrupt repository, segfaulted
   instead of complaining.

 - 0.99.7 created compatibility symlinks for commands that are
   not available in that installation/configuration.  Thanks to
   Patrick Mauritz this is now fixed.

 - Platforms that lack strcasestr() could not use mailinfo;
   Linus wrote 'a stupid replacement', which was further fixed
   by Joachim B Haga.  This is not a showstopper but even if
   this replacement were buggy the platforms that could not
   compile git for the lack of it would not be in worse shape
   anyway, so this is included here.

 - Needlessly insulting error message in git checkout was backed
   out.  Sorry about that.
