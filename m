From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 2/1] gitweb: Use fixed string for "next" link in commitdiff view
Date: Tue, 24 Oct 2006 17:27:18 +0200
Message-ID: <20061024152718.GE20017@pasky.or.cz>
References: <200610230037.57183.jnareb@gmail.com> <200610240008.08325.jnareb@gmail.com> <20061024114923.GD20017@pasky.or.cz> <200610241359.57389.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 17:28:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcOBY-0003pf-Kw
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 17:27:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965101AbWJXP1V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 11:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965153AbWJXP1V
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 11:27:21 -0400
Received: from w241.dkm.cz ([62.24.88.241]:9964 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S965101AbWJXP1U (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 11:27:20 -0400
Received: (qmail 6672 invoked by uid 2001); 24 Oct 2006 17:27:18 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <200610241359.57389.jnareb@gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29984>

Dear diary, on Tue, Oct 24, 2006 at 01:59:57PM CEST, I got a letter
where Jakub Narebski <jnareb@gmail.com> said that...
> >>> Would it even be necessary to use any SHA-1 name in these cases,
> >>> I wonder.  Would it make the page less useful if we replace all
> >>> of the above _commit_ with a fixed string, say, "parent"?
> > 
> > I really disagree here - what's the point of not using SHA-1? The extra
> > string carries zero information in comparison with the previous state
> > and I just can't see how it *improves* stuff. If you're walking in a
> > maze and making marks on walls, it's still more useful if you have
> > corridors named by "A", "B", "C", "D" on junctions if you sometimes want
> > to walk back to the marked corridors.
> 
> That's why instead of resending the patch/amending the commit, I have
> put changing shortened SHA1 to constant name in new patch.

Huh, I don't quite understand. You threw away all the "A", "B", "C", "D"
and kept only the marks.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
