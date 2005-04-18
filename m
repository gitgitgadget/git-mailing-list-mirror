From: Petr Baudis <pasky@ucw.cz>
Subject: [ANNOUNCE] git-pasky-0.5
Date: Tue, 19 Apr 2005 00:25:40 +0200
Message-ID: <20050418222540.GI5554@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Apr 19 00:22:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNecq-0000ME-1b
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 00:21:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbVDRWZt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 18:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbVDRWZt
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 18:25:49 -0400
Received: from w241.dkm.cz ([62.24.88.241]:60335 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261158AbVDRWZl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 18:25:41 -0400
Received: (qmail 14001 invoked by uid 2001); 18 Apr 2005 22:25:40 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

  Hello,

  so here finally goes git-pasky-0.5, my set of scripts upon Linus
Torvald's git, which aims to provide a humanly usable interface, to a
degree similar to a SCM tool. You can get it at

	http://pasky.or.cz/~pasky/dev/git/

  See the READMEs etc for some introduction.

  This contains plenty of changes, it's difficult to sum it up. It has
been reworked to better support the concept of branches; you can create
local branches which share the GIT object repository by git fork. There
is also git init which will yet you start a new GIT object repository
(possibly seeding it from some rsync URL), git status, better git log,
much cleaner concept of tracking (and consequently simpler yet better
git pull). Of course it contains the latest updates from Linus' branch
too.

  There is also git merge, which does some merging, but note well that
it is vastly inferior to what we _can_ do (and what I will do now).
Expect 0.6 soon where git merge will actually make use of the merging
facilities. I released 0.5 basically only because I have been postponing
it so long that I really feel ashamed of myself. ;-)

  Have fun,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
