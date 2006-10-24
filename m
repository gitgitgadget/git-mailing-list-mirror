From: Petr Baudis <pasky@suse.cz>
Subject: [ANNOUNCE] repo.or.cz now supports "project forks"
Date: Tue, 24 Oct 2006 06:52:01 +0200
Message-ID: <20061024045201.GX20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Oct 24 06:52:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcEGm-0003Fg-U4
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 06:52:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752025AbWJXEwG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 00:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752028AbWJXEwF
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 00:52:05 -0400
Received: from w241.dkm.cz ([62.24.88.241]:23446 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1752025AbWJXEwD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 00:52:03 -0400
Received: (qmail 18113 invoked by uid 2001); 24 Oct 2006 06:52:01 +0200
To: git@vger.kernel.org
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29922>

  Hi,

  FYI, the http://repo.or.cz/ public Git hosting now supports project
forking, which basically means that if you've done something cool to an
existing project and want to publish your work, you can create a "fork"
of the project on repo.or.cz and it will group nicely together in gitweb
and users will be hinted about the possibility to use --reference when
cloning your changes; also, repo.or.cz disk space will be conserved
thanks to the alternates mechanism. ;-)

  The other main goal aside gitweb grouping wasn't achieved yet though -
greatly reduced push times. Hey, pushing Git to a new repository takes
inordinate amount of time (actually also mostly because all the objects are
unpacked on the remote side, which is silly as well), I didn't try pushing
Linux kernel to a fresh repository but it'll likely take ages. The idea
would be to make git-receive-pack take alternates into account when
announcing what commits does the server side have, but someone will need
to code up a patch for that...

  It wasn't tested heavily, so please tell me about any warts you hit.

  Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
