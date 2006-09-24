From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] cg-commit: fix signed off handling
Date: Sun, 24 Sep 2006 22:05:05 +0200
Message-ID: <20060924200505.GY20017@pasky.or.cz>
References: <20060825002740.GH2817@diku.dk> <20060924174519.GW20017@pasky.or.cz> <20060924183246.GA695@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 24 22:05:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRaDu-0006dB-Na
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 22:05:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbWIXUFI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 16:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbWIXUFH
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 16:05:07 -0400
Received: from w241.dkm.cz ([62.24.88.241]:63115 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751373AbWIXUFG (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Sep 2006 16:05:06 -0400
Received: (qmail 15567 invoked by uid 2001); 24 Sep 2006 22:05:05 +0200
To: Jonas Fonseca <fonseca@diku.dk>
Content-Disposition: inline
In-Reply-To: <20060924183246.GA695@diku.dk>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27692>

Dear diary, on Sun, Sep 24, 2006 at 08:32:46PM CEST, I got a letter
where Jonas Fonseca <fonseca@diku.dk> said that...
> Petr Baudis <pasky@suse.cz> wrote Sun, Sep 24, 2006:
> > diff --git a/cg-commit b/cg-commit
> > index 43e6c6c..beedb6f 100755
> > --- a/cg-commit
> > +++ b/cg-commit
> > @@ -402,10 +402,6 @@ if [ "$msgfile" ]; then
> >  	written=1
> >  fi
> >  
> > -# Always have at least one blank line, to ease the editing for
> > -# the poor people whose text editor has no 'O' command.
> > -[ "$written" ] || { tty -s && echo >>"$LOGMSG"; }
> > -
> >  add_signoff() {
> >  	if [ "$signoff" ] && ! grep -q -i "signed-off-by: $signoff" $LOGMSG; then
> >  		grep -q -i sign-off-by $LOGMSG || echo
> 			   ^^^^^^^^^^^
> 
> My patch also fixed this to grep for "signed-off-by".

Oh, thanks - fixed.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
