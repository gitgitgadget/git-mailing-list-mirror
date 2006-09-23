From: Petr Baudis <pasky@suse.cz>
Subject: Re: The GPL: No shelter for the Linux kernel?
Date: Sat, 23 Sep 2006 20:14:06 +0200
Message-ID: <20060923181406.GC11916@pasky.or.cz>
References: <MDEHLPKNGKAHNMBLJOLKIEJNOJAB.davids@webmaster.com> <Pine.LNX.4.61.0609231004330.9543@yvahk01.tjqt.qr> <Pine.LNX.4.64.0609231051570.4388@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
	David Schwartz <davids@webmaster.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 23 20:14:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRC0y-0002jh-G9
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 20:14:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbWIWSOJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 14:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbWIWSOJ
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 14:14:09 -0400
Received: from w241.dkm.cz ([62.24.88.241]:55277 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751390AbWIWSOH (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Sep 2006 14:14:07 -0400
Received: (qmail 28311 invoked by uid 2001); 23 Sep 2006 20:14:06 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609231051570.4388@g5.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27610>

  (Quoting in full for the git@ people.)

Dear diary, on Sat, Sep 23, 2006 at 08:00:23PM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> said that...
> On Sat, 23 Sep 2006, Jan Engelhardt wrote:
> > 
> > Now that you raise it: I think developers can already have done that 
> > if they wish - properly name author and conditions who may possibly 
> > change the license to what. Not that I have seen such code yet, but you 
> > never know.
> 
> Side note: in "git", we kind of discussed this. And because the project 
> was started when the whole GPL version discussion was already in bloom, 
> the git project has a note at top of the COPYING file that says:
> 
>  Note that the only valid version of the GPL as far as this project
>  is concerned is _this_ particular version of the license (ie v2, not
>  v2.2 or v3.x or whatever), unless explicitly otherwise stated.
> 
>  HOWEVER, in order to allow a migration to GPLv3 if that seems like
>  a good idea, I also ask that people involved with the project make
>  their preferences known. In particular, if you trust me to make that
>  decision, you might note so in your copyright message, ie something
>  like
> 
>         This file is licensed under the GPL v2, or a later version
>         at the discretion of Linus.
> 
>   might avoid issues. But we can also just decide to synchronize and
>   contact all copyright holders on record if/when the occasion arises.
> 
> but note how it's still at the discretion of the actual developers (ie 
> when you add a file, you can either not specify any extensions, in which 
> case it's "GPLv2 only", or you can specify "GPLv2 or any later", or you 
> can specify the "GPLv2 or any later at the discretion of Linus Torvalds".
> 
> The silly thing, of course, is that I'm not even the maintainer any more, 
> and that Junio has done a kick-ass job of maintaining the thing, and is 
> definitely the main author by now. So the whole "discretion of Linus" is a 
> bit insane.
> 
> [ Although exactly _because_ Junio has been such a great maintainer, I'd 
>   bow down to whatever decision he does, so my "discretion" would be to 
>   let him decide, if he wanted to. At some point, you have to trust some 
>   people, and just let go - if they do more than you do, they damn well 
>   have more rights than you do too. "Maintainership has its privileges" ]
> 
> Anyway, I suspect the git language was a mistake. We should just have done 
> what the kernel did - make the version number be clear and fixed, so that 
> people don't even have to worry about exactly what conditions might cause 
> a relicensing to happen.

  Actually, this didn't catch on very well anyway, I guess because most
people just know it's GPLv2 and don't even bother to peek at COPYING, we
are a bit sloppy about copyright notices and most of them don't mention
licence at all (if there are any in the file at all), and adding
explicit copyright notices to mails isn't too popular either.

	$ git grep 'discretion'
	COPYING:        at the discretion of Linus.
	git-annotate.perl:# at the discretion of Linus Torvalds.
	git-relink.perl:# Later versions of the GPL at the discretion of Linus Torvalds
	git-request-pull.sh:# at the discretion of Linus Torvalds.

and I've found no patches with such special assignment.

  I think people don't really want to bother with thinking too much
about licences at all unless absolutely necessary, they just want to do
the fun part (coding). :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
