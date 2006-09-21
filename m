From: Petr Baudis <pasky@suse.cz>
Subject: Re: Git user survey and `git pull`
Date: Thu, 21 Sep 2006 18:40:48 +0200
Message-ID: <20060921164048.GY8259@pasky.or.cz>
References: <20060921162401.GD3934@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 21 18:44:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQRbZ-000756-TV
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 18:40:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbWIUQku (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 12:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbWIUQku
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 12:40:50 -0400
Received: from w241.dkm.cz ([62.24.88.241]:18855 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751324AbWIUQku (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Sep 2006 12:40:50 -0400
Received: (qmail 5126 invoked by uid 2001); 21 Sep 2006 18:40:48 +0200
To: Shawn Pearce <spearce@spearce.org>
Content-Disposition: inline
In-Reply-To: <20060921162401.GD3934@spearce.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27488>

Dear diary, on Thu, Sep 21, 2006 at 06:24:01PM CEST, I got a letter
where Shawn Pearce <spearce@spearce.org> said that...
> in other words pull does the download and doesn't automatically
> start a merge

This is artifact of the BitKeeper terminology. This is the meaning in
most other VCSes but in BitKeeper, pull meant "get changes and merge
them", not just "get changes". So the BitKeeper legacy lives on. :-)

The route I took for Cogito is to just avoid calling _any_ command
"pull". It's too confusing. "update" does the same as "cvs update" or
"svn update" and I didn't notice people having much problem with that.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
