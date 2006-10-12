From: Petr Baudis <pasky@suse.cz>
Subject: Re: cg-commit does not run pre-commit hook?
Date: Thu, 12 Oct 2006 03:15:48 +0200
Message-ID: <20061012011548.GT20017@pasky.or.cz>
References: <20061011203054.C5F80353A48@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 12 03:16:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXpAx-0004IG-SD
	for gcvg-git@gmane.org; Thu, 12 Oct 2006 03:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161334AbWJLBPu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 21:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965250AbWJLBPu
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 21:15:50 -0400
Received: from w241.dkm.cz ([62.24.88.241]:49827 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S965249AbWJLBPu (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Oct 2006 21:15:50 -0400
Received: (qmail 1093 invoked by uid 2001); 12 Oct 2006 03:15:48 +0200
To: Wolfgang Denk <wd@denx.de>
Content-Disposition: inline
In-Reply-To: <20061011203054.C5F80353A48@atlas.denx.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28766>

  Hi,

Dear diary, on Wed, Oct 11, 2006 at 10:30:54PM CEST, I got a letter
where Wolfgang Denk <wd@denx.de> said that...
> I noticed that cg-commit does not run the pre-commit  hook.  Is  this
> intentional,  or  am  I  doing anyhting wrong? When I use git-coimmit
> instead the hook is run just  fine.  This  is  with  git-1.4.2.1  and
> cogito-0.18 of FC4 / FC5 systems.

  historically, Git and Cogito use a different set of hooks (Cogito got
hooks first but Git picked own names and usage and now is prevalent).
I have plans for making Cogito support Git hooks and slowly deprecate
those own ones for which Git has counterparts, but didn't get to it yet.
I might do today during the more boring lectures... ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
