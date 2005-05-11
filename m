From: Petr Baudis <pasky@ucw.cz>
Subject: [ANNOUNCE] git-pb git tree
Date: Wed, 11 May 2005 05:16:13 +0200
Message-ID: <20050511031613.GO26384@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed May 11 05:09:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVhac-00064c-DZ
	for gcvg-git@gmane.org; Wed, 11 May 2005 05:08:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbVEKDQS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 23:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbVEKDQR
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 23:16:17 -0400
Received: from w241.dkm.cz ([62.24.88.241]:29358 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261893AbVEKDQP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2005 23:16:15 -0400
Received: (qmail 21684 invoked by uid 2001); 11 May 2005 03:16:13 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

  Hello,

  I've published the git-pb git tree. This is a purely "core GIT" tree,
with no traces of Cogito itself inside, and intended to be safe-to-pull
for Linus. It will hopefully be soon fully synchronized by the GIT part
of the Cogito tree (it already has all the important bits), and will
stay so - any GIT stuff will go to the Cogito tree through the git-pb
tree.

  I plan to integrate the well-looking core git patches flying through
the mailing list to the git-pb tree, as well as various own stuff
(related or not related to what Cogito needs for operating well).  I
will be pulling from Linus on regular basis, and from git-jc too if I
feel comfortable with what's inside.

  I'm also thinking about git-pbc for the possibly controversial stuff
(taking care of hidden files, perhaps librarifications).


  You get it as a Git tree at

	rsync://rsync.kernel.org/pub/scm/cogito/git-pb.git
	http://www.kernel.org/pub/scm/cogito/git-pb.git


  On related note, I've set up a Git->CIA gateway. CIA is a commit
aggregator, tracking large number of open source projects. Cogito's and
git-pb's corner is at http://cia.navi.cx/stats/project/Cogito, the
commits are also broadcasted to the #git OPN channel (which is the point
of the whole thing, after all ;-).


  Have fun,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
