From: Petr Baudis <pasky@ucw.cz>
Subject: Merge with git-pasky II.
Date: Thu, 14 Apr 2005 02:29:02 +0200
Message-ID: <20050414002902.GU25711@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 02:26:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DLsBN-0005OT-Hu
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 02:26:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbVDNA3W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Apr 2005 20:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbVDNA3W
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Apr 2005 20:29:22 -0400
Received: from w241.dkm.cz ([62.24.88.241]:25018 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261255AbVDNA3G (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Apr 2005 20:29:06 -0400
Received: (qmail 3444 invoked by uid 2001); 14 Apr 2005 00:29:02 -0000
To: torvalds@osdl.org
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

  Hello Linus,

  I think my tree should be ready for merging with you. It is the final
tree and I've already switched my main branch for it, so it's what
people doing git pull are getting for some time already.

  Its main contents are all of my shell scripts. Apart of that, some
tiny fixes scattered all around can be found there, as well as some
patches which went through the mailing list. My last merge with you
concerned your commit 39021759c903a943a33a28cfbd5070d36d851581.

  It's again

	rsync://pasky.or.cz/git/

this time my HEAD is fba83970090ef54c6eb86dcc2c2d5087af5ac637.

  Note that my rsync tree still contains even my old branch; I thought
I'd leave it around in the public objects database for some time, shall
anyone want to have a look at the history of some of the scripts. But if
you want it gone, tell me and I will prune it (and perhaps offer it in
/git-old/ or whatever). I'm using the following:

	fsck-cache --unreachable $(commit-id) | grep unreachable \
		| cut -d ' ' -f 2 | sed 's/^\(..\)/.git\/objects\/\1\//' \
		| xargs rm

  Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
