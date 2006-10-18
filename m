From: Petr Baudis <pasky@suse.cz>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 02:14:55 +0200
Message-ID: <20061018001455.GI20017@pasky.or.cz>
References: <45345AEF.6070107@utoronto.ca> <200610171030.35854.jnareb@gmail.com> <vpqejt76vgz.fsf@ecrins.imag.fr> <BAYC1-PASMTP02ADC5BEF688E61583283CAE0E0@CEZ.ICE> <vpqbqob5euu.fsf@ecrins.imag.fr> <BAYC1-PASMTP10E107E5EB0F7E69167F41AE0E0@CEZ.ICE> <vpqejt73vln.fsf@ecrins.imag.fr> <BAYC1-PASMTP10F617306F1477E66FA441AE0E0@CEZ.ICE> <vpqlknf10u5.fsf@ecrins.imag.fr> <20061017110655.f7bcf3f1.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 02:15:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZz5O-0003DY-Fs
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 02:15:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbWJRAO6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 20:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbWJRAO6
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 20:14:58 -0400
Received: from w241.dkm.cz ([62.24.88.241]:3795 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751301AbWJRAO5 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Oct 2006 20:14:57 -0400
Received: (qmail 11864 invoked by uid 2001); 18 Oct 2006 02:14:55 +0200
To: Sean <seanlkml@sympatico.ca>
Content-Disposition: inline
In-Reply-To: <20061017110655.f7bcf3f1.seanlkml@sympatico.ca>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29145>

Dear diary, on Tue, Oct 17, 2006 at 05:06:55PM CEST, I got a letter
where Sean <seanlkml@sympatico.ca> said that...
> [1] As an aside, I don't understand why bazaar pushes the idea
> of "plugins".  For instance someone mentioned that bazaar has
> a bisect "plugin".  Well Git was able to add a bisect "command"
> without needing a plugin architecture.. so i'm at a loss as 
> to why plugins are seen as an advantage.

Greater flexibility, you can "provide this great Git addon that will
let you push over FTP" without requiring users to patch their Git
installations or wait for new Git version that might include it.
Especially important if you want a lot of users test out your
experimental feature or if it's something project-specific etc.

BTW, I'm thinking about implementing some plugin functionality for
gitweb so that you can add your own views, so that git-browser can
integrate to it more reasonably. (Currently it has completely different
UI and you have to patch gitweb in order to get the proper links at
proper places.) Sure, git-browser might get fully integrated to gitweb
later but that needs to be done sensitively so that people are not
scared by the horrible javascript blobs, etc.; currently git-browser is
very experimental, and adding it would be quite intrusive.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
