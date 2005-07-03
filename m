From: Petr Baudis <pasky@suse.cz>
Subject: [ANNOUNCE] Cogito-0.12
Date: Mon, 4 Jul 2005 01:46:29 +0200
Message-ID: <20050703234629.GF13848@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jul 04 01:47:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpEAl-0001Tj-Pu
	for gcvg-git@gmane.org; Mon, 04 Jul 2005 01:46:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbVGCXqo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jul 2005 19:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbVGCXqo
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jul 2005 19:46:44 -0400
Received: from w241.dkm.cz ([62.24.88.241]:2719 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261582AbVGCXqe (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Jul 2005 19:46:34 -0400
Received: (qmail 9736 invoked by uid 2001); 3 Jul 2005 23:46:29 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

  Hello,

  I'm happy to announce the release of the 0.12 version of the Cogito
SCM-like layer over Linus' GIT tree history storage tool. Get it at

	http://www.kernel.org/pub/software/scm/cogito/

or cg-update if you have an older version cloned.

  I wanted to release it later with more cool features, but after all
releasing often is good and people will get to test things more, and
I wanted to make it possible for kernel.org to upgrade to newer RPM.
But it may not be as stable as I'd wish and may have some rough edges,
so be warned.

  This release contains the latest stuff from Linus, with all the
packing stuff and everything. Other things include heaps of bugfixes,
enhanced options parsing, ~/.cgrc support, cg-push, real cg-tag, and
plenty of smaller but nice stuff. And more to come in next days!

  About cg-push, it:

  (i) works only locally or over git+ssh branches

  (ii) the head updated on the other side must be 'master' too
	(high priority to fix)

  (iii) the head updated on the other side is re-created, thus losing
	all attributes (ownership, permissions)
	(high priority to fix)

  (iv) won't update the remote working tree if there is any associated
	with the repository - do cg-cancel to catch up, but that will
	lose any local changes you did (note that I plan to rename
	cg-cancel to cg-reset)

  Also, I've deprecated rsync, as I explained in another mail. Use
cg-branch-chg to change the branch URLs to some more sensible scheme -
most likely HTTP, or SSH if you want to push as well.

  Have fun,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
