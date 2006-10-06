From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: start to generate PATH_INFO URLs
Date: Fri, 6 Oct 2006 17:30:30 +0200
Message-ID: <20061006152925.GP20017@pasky.or.cz>
References: <20060929221641.GC2871@admingilde.org> <7v8xk2jofc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Waitz <tali@admingilde.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 06 17:40:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVroT-0003t6-89
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 17:40:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbWJFPke (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 11:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbWJFPke
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 11:40:34 -0400
Received: from w241.dkm.cz ([62.24.88.241]:23740 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751367AbWJFPkd (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Oct 2006 11:40:33 -0400
Received: (qmail 11521 invoked by uid 2001); 6 Oct 2006 17:30:30 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v8xk2jofc.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28407>

Dear diary, on Sat, Sep 30, 2006 at 12:30:47AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Martin Waitz <tali@admingilde.org> writes:
> 
> > Instead of providing the project as a ?p= parameter it is simply appended
> > to the base URI.
> > All other parameters are appended to that, except for ?a=summary which
> > is the default and can be omitted.
> 
> Supporting PATH_INFO in the sense that we do sensible things
> when we get called with one is one thing, but generating such a
> URL that uses PATH_INFO is a different thing.  I suspect not
> everybody's webserver is configured to call us with PATH_INFO,
> so this should be conditional.

Hmm, which webservers support CGI but don't pass PATH_INFO?


BTW, couple of notes for people who will want to try it: if gitweb.cgi
serves as your indexfile, this will break; you need to override $my_uri
in gitweb_config. Also, you need to change the default location of CSS,
favicon and logo to an absolute URL.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
