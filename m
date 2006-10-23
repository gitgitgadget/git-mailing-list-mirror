From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Make git-branch a builtin
Date: Tue, 24 Oct 2006 01:19:40 +0200
Message-ID: <20061023231940.GU20017@pasky.or.cz>
References: <11616396262982-git-send-email-hjemli@gmail.com> <20061023215506.GB8344@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 01:19:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc958-0001O3-HT
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 01:19:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055AbWJWXTm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 19:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752057AbWJWXTm
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 19:19:42 -0400
Received: from w241.dkm.cz ([62.24.88.241]:37254 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1752055AbWJWXTm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Oct 2006 19:19:42 -0400
Received: (qmail 8028 invoked by uid 2001); 24 Oct 2006 01:19:40 +0200
To: Shawn Pearce <spearce@spearce.org>
Content-Disposition: inline
In-Reply-To: <20061023215506.GB8344@spearce.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29899>

Dear diary, on Mon, Oct 23, 2006 at 11:55:06PM CEST, I got a letter
where Shawn Pearce <spearce@spearce.org> said that...
> Lars Hjemli <hjemli@gmail.com> wrote:
> [snip]
> > ---
> >  Makefile         |    3 +-
> >  builtin-branch.c |  217 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  builtin.h        |    1 +
> >  git-branch.sh    |  131 --------------------------------
> >  git.c            |    1 +
> >  5 files changed, 221 insertions(+), 132 deletions(-)
> [snip]
> > diff --git a/git-branch.sh b/git-branch.sh
> > deleted file mode 100755
> > index 4379a07..0000000
> > --- a/git-branch.sh
> > +++ /dev/null
> > @@ -1,131 +0,0 @@
> [snip 131 lines]
> 
> Aside from compatability with non-Git tools...
> 
> Wouldn't it make more sense to just include the full SHA1 of the
> file we are deleting rather than the entire 131 line negative diff?

I think this way it's easier to review since you can check what is going
away with the new stuff you introduce instead.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
