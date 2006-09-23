From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Fix buggy ref recording
Date: Sat, 23 Sep 2006 03:16:34 +0200
Message-ID: <20060923011634.GL13132@pasky.or.cz>
References: <Pine.LNX.4.64.0609141005440.4388@g5.osdl.org> <20060919205554.GA8259@pasky.or.cz> <20060922230845.GB8259@pasky.or.cz> <7vzmcrxvgw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 23 03:16:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQw8F-00088N-L8
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 03:16:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965083AbWIWBQg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Sep 2006 21:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965084AbWIWBQg
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Sep 2006 21:16:36 -0400
Received: from w241.dkm.cz ([62.24.88.241]:57812 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S965083AbWIWBQg (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Sep 2006 21:16:36 -0400
Received: (qmail 26285 invoked by uid 2001); 23 Sep 2006 03:16:34 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vzmcrxvgw.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27554>

Dear diary, on Sat, Sep 23, 2006 at 02:44:31AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> I've never seen you send out a corrupt patch over e-mail.
> What's different this time?
> 
> > diff --git a/refs.c b/refs.c
> > index 40f16af..5fdf9c4 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -472,7 +472,7 @@ static struct ref_lock *lock_ref_sha1_ba
> >
> >  	lock->ref_name = xstrdup(ref);
> >  	lock->log_file = xstrdup(git_path("logs/%s", ref));
> 
> The empty line at the beginning of the hunk is totally empty,
> not even with a SP to show it is a context line.

Sorry, I've cut'n'pasted from an ssh session on repo.or.cz and *thought*
that I fixed the whitespaces...

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
