From: Petr Baudis <pasky@ucw.cz>
Subject: [ANNOUNCE] Cogito-0.9
Date: Sun, 8 May 2005 04:59:05 +0200
Message-ID: <20050508025905.GP9495@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun May 08 04:52:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUbtz-0008Aj-1g
	for gcvg-git@gmane.org; Sun, 08 May 2005 04:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262791AbVEHC7K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 May 2005 22:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbVEHC7K
	(ORCPT <rfc822;git-outgoing>); Sat, 7 May 2005 22:59:10 -0400
Received: from w241.dkm.cz ([62.24.88.241]:41930 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262791AbVEHC7H (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 May 2005 22:59:07 -0400
Received: (qmail 30079 invoked by uid 2001); 8 May 2005 02:59:05 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

  Hello,

  so Cogito version 0.9, my SCM-like layer over Linus' GIT versioned
tree storage system, is out. Get it at

	http://www.kernel.org/pub/scm/cogito/

  or just cg-update your tree. The highlights is cg-pulling over HTTP,
ssh, and from local trees, sheer amount of bugfixes, regular merging
with Linus, and few usage changes; most importantly, cg-log and
cg-mkpatch now take the revision specifiers as -r arguments to make it
possible to narrow that down to individual files (otherwise, I consider
the Cogito CLI basically stabilized, except for some cg-cancel vs
cg-update cleanups; but that shouldn't affect anything day-to-day,
except making the day-to-day stuff possibly easier again).

  This is mostly so that I can satisfy people hungry to upgrade to next
Cogito release. I know about the unmerged patches (well, at least some
of them), and will go through them soon; I have some of own agenda I
want to work on too.

  Have fun,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
