From: Petr Baudis <pasky@suse.cz>
Subject: [CFH] Remotes conversion script
Date: Sun, 24 Sep 2006 23:21:42 +0200
Message-ID: <20060924212142.GB20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Sep 24 23:22:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRbQN-0003pC-K1
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 23:22:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbWIXVVq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 17:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbWIXVVq
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 17:21:46 -0400
Received: from w241.dkm.cz ([62.24.88.241]:59369 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932139AbWIXVVo (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Sep 2006 17:21:44 -0400
Received: (qmail 28294 invoked by uid 2001); 24 Sep 2006 23:21:42 +0200
To: git@vger.kernel.org
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27697>

  Hi,

  if someone is currently bored, it would be very nice to have a
conversion script for converting remotes/ to [remote] .config sections
(unless I missed it and someone already did such a great thing).

  I think about supporting just the [remote] sections in Cogito since
they are much easier to handle than the remotes/ file format, but in
order to maintain reasonable degree of compatibility with current
repositories (even freshly cloned since git-clone still generates those
horrible things ;-) ) such a script would be a must... and since this is
not interesting strictly for Cogito only, I hoped that perhaps some core
Git people would be interested to help here.

  PS: It would be nice if Git, when writing remote records during clone,
would note "this is supposed to just cover all the remote branches".
While Git does not support it now, in cg-fetch I would like to support
automatically picking up new branches in case you cloned all the
branches initially, but I need to distinguish the case when you are
interested in just a fixed set of those. BTW, I want to also remove gone
branches, but in line with the Git paranoia I'll just move the refs to
refs/remotes/*/.attic/ and let the user shoot at will.

  Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
