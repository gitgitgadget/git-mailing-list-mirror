From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC][RESEND][PATCH] Allow fetching from multiple repositories at once
Date: Sat, 23 Sep 2006 21:17:27 +0200
Message-ID: <20060923191727.GE20017@pasky.or.cz>
References: <20060923164308.16334.49252.stgit@machine.or.cz> <45156780.6070801@gmail.com> <20060923170439.GQ8259@pasky.or.cz> <Pine.LNX.4.63.0609231921110.25853@wbgn013.biozentrum.uni-wuerzburg.de> <20060923173943.GA20017@pasky.or.cz> <Pine.LNX.4.63.0609231947340.25853@wbgn013.biozentrum.uni-wuerzburg.de> <20060923180539.GC20017@pasky.or.cz> <Pine.LNX.4.63.0609232007550.25853@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: A Large Angry SCM <gitzilla@gmail.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 23 21:17:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRD0H-000678-4G
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 21:17:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbWIWTRa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 15:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbWIWTRa
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 15:17:30 -0400
Received: from w241.dkm.cz ([62.24.88.241]:17376 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751457AbWIWTR3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Sep 2006 15:17:29 -0400
Received: (qmail 1817 invoked by uid 2001); 23 Sep 2006 21:17:27 +0200
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0609232007550.25853@wbgn013.biozentrum.uni-wuerzburg.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27616>

  Hi,

Dear diary, on Sat, Sep 23, 2006 at 08:14:28PM CEST, I got a letter
where Johannes Schindelin <Johannes.Schindelin@gmx.de> said that...
> Hmmm. Did you test if this makes things better? If so, could you test with 
> one proxy repo on the server? I bet that this would be even more 
> efficient.

  I didn't test it but it _has_ to... ;-))

  I will try to do some real benchmarks (repo.or.cz might come handy
here again) but I don't know when will I get to it. I will try the proxy
setup as well.

> And the proxy repo would be updated best by a hook, not a cronjob.

  You would have a race window there.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
