From: Petr Baudis <pasky@ucw.cz>
Subject: Pushing vs. alternates
Date: Tue, 24 Oct 2006 05:53:35 +0200
Message-ID: <20061024035335.GW20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Oct 24 05:53:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcDMC-00040i-UQ
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 05:53:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030204AbWJXDxh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 23:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965080AbWJXDxh
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 23:53:37 -0400
Received: from w241.dkm.cz ([62.24.88.241]:62901 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S965077AbWJXDxg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Oct 2006 23:53:36 -0400
Received: (qmail 12832 invoked by uid 2001); 24 Oct 2006 05:53:35 +0200
To: git@vger.kernel.org
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29921>

  Hi,

  I don't have time to code that myself right now, so I'm just tossing
an idea around - pushing to a directory with alternates set up should
avoid sending objects that are already in the alternate object database.
This is obviously very hard to achieve, but I think it should be
possible to do something like look if $alternate/../refs/ exists and in
that case send haves for those refs - that could give good results. Or
is that a bad idea for some reason?

  That would be quite useful for the repo.or.cz's forked objects.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
