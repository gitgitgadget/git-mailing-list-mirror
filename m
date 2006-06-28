From: Junio C Hamano <junkio@cox.net>
Subject: Quick merge status updates.
Date: Tue, 27 Jun 2006 17:23:55 -0700
Message-ID: <7vodwe5dr8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jun 28 02:24:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvNqs-00014f-3I
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 02:24:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbWF1AYA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 20:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbWF1AYA
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 20:24:00 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:5533 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932267AbWF1AX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jun 2006 20:23:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060628002356.FIGC19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 27 Jun 2006 20:23:56 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22764>

I'm planning to do 1.4.1 soonish from what's currently in "next"
(fixes already in "master" plus format-patch updates and some
more tests).  I am waiting for a confirmation that Johannes's
cvsimport fix posted earlier on the list does work, or maybe
Martin would come up with an alternative.  I think then we are
good for a release.

Immediately after 1.4.1 happens, I would like to pull in
"Git.xs/Git.pm" series by Pasky into "next".  After that settles
I'd pull in the diff options rewrite by Timo.

For some time, "pu" was left in the state that does not to pass
the testsuite, but I've fixed what's minimally needed (the
breakage was mostly from the diff options rewrite).  People who
regularly follow "next" on platforms other than i386 or x86-64
Linux might want to try out tonight's "pu" to make sure
"Git.xs/Git.pm" series works on their box before it hits "next".
Breakage there would stop your "git pull" working, so this is
somewhat important.

Thanks.
