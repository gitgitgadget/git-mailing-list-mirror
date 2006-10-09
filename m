From: Petr Baudis <pasky@suse.cz>
Subject: Re: Does GIT has vc keywords like CVS/Subversion?
Date: Mon, 9 Oct 2006 04:59:05 +0200
Message-ID: <20061009025905.GM20017@pasky.or.cz>
References: <4b3406f0610081825y1d066579yba305b6540c8d0e9@mail.gmail.com> <4529B77A.707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dongsheng Song <dongsheng.song@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 09 04:59:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWlMJ-0004pu-BP
	for gcvg-git@gmane.org; Mon, 09 Oct 2006 04:59:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638AbWJIC7J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Oct 2006 22:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbWJIC7J
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Oct 2006 22:59:09 -0400
Received: from w241.dkm.cz ([62.24.88.241]:34499 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751638AbWJIC7H (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Oct 2006 22:59:07 -0400
Received: (qmail 16092 invoked by uid 2001); 9 Oct 2006 04:59:05 +0200
To: Liu Yubao <yubao.liu@gmail.com>
Content-Disposition: inline
In-Reply-To: <4529B77A.707@gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28560>

Dear diary, on Mon, Oct 09, 2006 at 04:44:10AM CEST, I got a letter
where Liu Yubao <yubao.liu@gmail.com> said that...
> Dongsheng Song wrote:
> >I want to know whether there is a plan to add this feature, or GIT
> >doesn't require it at all.
> >
> >Keywords like LastChangedDate, LastChangedRevision, LastChangedBy, Id
> >are useful for version control.
> >
> I almost mistake I sent my last question twice:-), maybe we need more FAQs
> like this:
> Q: Does GIT [some feature] like [some vcs] ?
> A: No. Because ...

I have added direct link to FAQ in the Git wiki to the Git homepage
header - http://git.or.cz/gitwiki/GitFaq. It's a wiki, so feel free to
add more q/a there.

> IMHO, I don't think keyword substitution is a good idea, as it will confuse
> the external diff/merge tools.

There can be valid usage scenarios for keyword substitution but I tend
to agree that it usually is not necessary to have it (and projects tend
to use it just "because we can", which is of course their right). Also,
implementing it in Git poses some challenges and has some ugly
implications (like actually having to start to worry about binary
files).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
