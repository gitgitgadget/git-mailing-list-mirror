From: Petr Baudis <pasky@suse.cz>
Subject: Re: Integrating gitweb and git-browser (was: Re: VCS comparison table)
Date: Wed, 18 Oct 2006 03:52:11 +0200
Message-ID: <20061018015211.GP20017@pasky.or.cz>
References: <vpqejt76vgz.fsf@ecrins.imag.fr> <BAYC1-PASMTP02ADC5BEF688E61583283CAE0E0@CEZ.ICE> <vpqbqob5euu.fsf@ecrins.imag.fr> <BAYC1-PASMTP10E107E5EB0F7E69167F41AE0E0@CEZ.ICE> <vpqejt73vln.fsf@ecrins.imag.fr> <BAYC1-PASMTP10F617306F1477E66FA441AE0E0@CEZ.ICE> <vpqlknf10u5.fsf@ecrins.imag.fr> <20061017110655.f7bcf3f1.seanlkml@sympatico.ca> <20061018001455.GI20017@pasky.or.cz> <eh40e1$9g1$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 03:55:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ga0bQ-0003t4-Hw
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 03:52:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbWJRBwO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 21:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbWJRBwO
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 21:52:14 -0400
Received: from w241.dkm.cz ([62.24.88.241]:12516 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750823AbWJRBwN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Oct 2006 21:52:13 -0400
Received: (qmail 23775 invoked by uid 2001); 18 Oct 2006 03:52:11 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <eh40e1$9g1$1@sea.gmane.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29175>

Dear diary, on Wed, Oct 18, 2006 at 03:36:36AM CEST, I got a letter
where Jakub Narebski <jnareb@gmail.com> said that...
> Petr Baudis wrote:
> 
> > BTW, I'm thinking about implementing some plugin functionality for
> > gitweb 
> 
> Features support is kind of plugin system for gitweb. But certainly we could
> split gitweb into modules.
> 
> > so that you can add your own views, so that git-browser can 
> > integrate to it more reasonably. (Currently it has completely different
> > UI and you have to patch gitweb in order to get the proper links at
> > proper places.) Sure, git-browser might get fully integrated to gitweb
> > later but that needs to be done sensitively so that people are not
> > scared by the horrible javascript blobs, etc.; currently git-browser is
> > very experimental, and adding it would be quite intrusive.
> 
> I was thinking about adding using JavaScript, in shortlog (and perhaps
> shortlog-extended, i.e. with date and author) views one extra "diagram"
> column, with width set using JavaScript generated embedded style, and use
> only part of git-browser that generates diagram to draw it there.

Shortlog is paginated and that's not very practical for diagrams, I
think - you need to gradually extend it instead in that case. But yes,
keeping the _visual_ difference of git-browser and gitweb as small as
possible has been the main reason for me to think about integrating it
more tightly.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
