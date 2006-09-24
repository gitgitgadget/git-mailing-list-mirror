From: Petr Baudis <pasky@suse.cz>
Subject: Re: cg-commit -p -m ignores -p
Date: Sun, 24 Sep 2006 19:48:37 +0200
Message-ID: <20060924174837.GX20017@pasky.or.cz>
References: <20060915132319.12117.qmail@7d60384c102e6d.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Sep 24 19:48:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRY5q-0001Oi-Ui
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 19:48:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbWIXRsj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 13:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbWIXRsj
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 13:48:39 -0400
Received: from w241.dkm.cz ([62.24.88.241]:61869 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751316AbWIXRsj (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Sep 2006 13:48:39 -0400
Received: (qmail 11288 invoked by uid 2001); 24 Sep 2006 19:48:37 +0200
To: git@vger.kernel.org, 387515@bugs.debian.org
Content-Disposition: inline
In-Reply-To: <20060915132319.12117.qmail@7d60384c102e6d.315fe32.mid.smarden.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27685>

Dear diary, on Fri, Sep 15, 2006 at 03:23:19PM CEST, I got a letter
where Gerrit Pape <pape@smarden.org> said that...
> Hi, please see http:/bugs.debian.org/387515 or below.  I agree that
> ideally cg-commit should behave differently.
> 
> Thanks, Gerrit.
> 
> ----- Forwarded message from Andrew Suffield <asuffield@suffields.me.uk> -----
> 
> cg-commit -p -m ignores the -p argument and silently commits. Yes,
> this is documented, but it's still stupid behaviour; if the user had
> meant that, they would have just used -m alone.
> 
> At the very least, it should abort with an error (on the basis that
> the command makes no sense); more sensibly, it should create a log
> message with the given string and then spawn an editor (and then since
> the user will probably exit without changing the file, the "Abort or
> commit?" message would appear as per usual, which seems to me to be
> appropriate behaviour).
> 
> 
> ----- End forwarded message -----

Thanks, fixed by making cg-commit -p imply -e.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
