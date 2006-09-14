From: Petr Baudis <pasky@suse.cz>
Subject: Historical kernel repository size
Date: Thu, 14 Sep 2006 16:22:49 +0200
Message-ID: <20060914142249.GK23891@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 14 16:23:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNs7F-0001Hg-Vn
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 16:22:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbWINOWx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 10:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWINOWw
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 10:22:52 -0400
Received: from w241.dkm.cz ([62.24.88.241]:8683 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750781AbWINOWv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Sep 2006 10:22:51 -0400
Received: (qmail 5021 invoked by uid 2001); 14 Sep 2006 16:22:49 +0200
To: Thomas Gleixner <tglx@linutronix.de>
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26999>

  Hi,

  just to test the packing improvements we had achieved over the last
year, I have repacked the historical kernel repository and achieved a
significant improvement:

xpasky@machine[0:0]~/hi/history$ git-repack -a -f
Generating pack...
Done counting 566638 objects.
Deltifying 566638 objects.
 100% (566638/566638) done
Writing 566638 objects.
 100% (566638/566638) done
Total 566638, written 566638 (delta 456212), reused 98435 (delta 0)
Pack pack-4d27038611fe7755938efd4a2745d5d5d35de1c1 created.
xpasky@machine[0:0]~/hi/history$ l .git/objects/pack/
total 476264
-rw-r--r-- 1 xpasky users  13600376 Sep 14 16:18 pack-4d27038611fe7755938efd4a2745d5d5d35de1c1.idx
-rw-r--r-- 1 xpasky users 197168186 Sep 14 16:18 pack-4d27038611fe7755938efd4a2745d5d5d35de1c1.pack
-rw-r--r-- 1 xpasky users  13600376 Sep 14 12:18 pack-cc3517351ecce3ef7ba010559992bdfc10b7acd4.idx
-rw-r--r-- 1 xpasky users 262818936 Sep 14 12:29 pack-cc3517351ecce3ef7ba010559992bdfc10b7acd4.pack

  Since it's a nice place for people to check about how efficient we are
with compressing the repository, perhaps it would be a good idea to
repack the historical repository on kernel.org?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
